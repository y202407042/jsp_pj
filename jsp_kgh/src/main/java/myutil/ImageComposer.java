package myutil;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.imageio.ImageIO;

public class ImageComposer {

    public static String composeImage(
            String srcImagePath,
            String quoteText,
            String speaker,
            String outputDirPath) throws IOException {

        if (quoteText == null) quoteText = "";
        if (speaker == null)   speaker   = "";

        // 1. 원본 인물 이미지
        BufferedImage portrait = ImageIO.read(new File(srcImagePath));
        if (portrait == null) {
            throw new IOException("이미지를 읽을 수 없습니다: " + srcImagePath);
        }

        // 2. 최종 캔버스(16:9)
        int width  = 1365;
        int height = 768;

        // 왼쪽 45% 영역에 인물
        int leftWidth = (int) (width * 0.45);

        BufferedImage canvas =
                new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = canvas.createGraphics();

        // 안티앨리어싱
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING,
                RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

        // 배경 검정
        g2d.setColor(Color.BLACK);
        g2d.fillRect(0, 0, width, height);

        // 3. 왼쪽에 인물 사진 꽉 채우기 (cover 방식)
        int pW = portrait.getWidth();
        int pH = portrait.getHeight();

        int targetW = leftWidth;
        int targetH = height;

        double scaleW = (double) targetW / pW;
        double scaleH = (double) targetH / pH;
        double scale  = Math.max(scaleW, scaleH);

        int scaledW = (int) (pW * scale);
        int scaledH = (int) (pH * scale);

        int drawX = (leftWidth - scaledW) / 2;
        int drawY = (height   - scaledH) / 2;

        g2d.setClip(0, 0, leftWidth, height);
        g2d.drawImage(portrait, drawX, drawY, scaledW, scaledH, null);
        g2d.setClip(null);

        // 4. 오른쪽 영역(텍스트)
        int rightX      = leftWidth;
        int rightWidth  = width - leftWidth;
        int paddingX    = 80;
        int paddingYTop = 40;
        int paddingYBot = 80;
        int textAreaX   = rightX + paddingX;
        int textAreaW   = rightWidth - paddingX * 2;

        // 5. 본문 텍스트 (가운데 정렬, 1.5배 폰트)
        quoteText = quoteText.replace("\r", "");
        String[] lines = quoteText.split("\n");

        int mainFontSize   = 48;  // 32 * 1.5
        int authorFontSize = 30;  // 20 * 1.5
        int quoteFontSize  = 100; // 50 * 2
        int lineGap        = 14;

        Font mainFont = new Font("Malgun Gothic", Font.PLAIN, mainFontSize);
        g2d.setFont(mainFont);
        g2d.setColor(Color.WHITE);
        FontMetrics fm = g2d.getFontMetrics();

        // 텍스트 블록 높이
        int textBlockHeight = 0;
        if (lines.length > 0) {
            textBlockHeight = lines.length * fm.getHeight()
                    + (lines.length - 1) * lineGap;
        }

        int availableHeight = height - paddingYTop - paddingYBot;
        int offsetUp = 40; // 좀 더 위로
        int startY = paddingYTop + (availableHeight - textBlockHeight) / 2 - offsetUp;

        int y = startY + fm.getAscent();
        for (String line : lines) {
            String drawLine = (line == null) ? "" : line;
            int lineWidth = fm.stringWidth(drawLine);
            int lineX = textAreaX + (textAreaW - lineWidth) / 2; // ★ 본문만 가운데 정렬
            g2d.drawString(drawLine, lineX, y);
            y += fm.getHeight() + lineGap;
        }

        // 6. 따옴표 – 처음처럼 좌/우 배치
        Font quoteFont = new Font("Malgun Gothic", Font.BOLD, quoteFontSize);
        g2d.setFont(quoteFont);
        FontMetrics qfm = g2d.getFontMetrics();

        String openQuote  = "“";
        String closeQuote = "”";

        // 여는 따옴표: 오른쪽 영역의 왼쪽 위 근처
        int openWidth = qfm.stringWidth(openQuote);
        int openX = textAreaX;                   // 왼쪽
        int openY = startY - qfm.getDescent() - 30;
        g2d.drawString(openQuote, openX, openY);

        // 닫는 따옴표: 오른쪽 영역의 오른쪽 아래 근처
        int closeWidth = qfm.stringWidth(closeQuote);
        int closeX = rightX + rightWidth - paddingX - closeWidth; // 오른쪽
		int closeY = height - paddingYBot - 30;
        g2d.drawString(closeQuote, closeX, closeY);

        // 7. 화자(출처) – 처음처럼 우측 정렬 (오른쪽 아래)
        if (!speaker.trim().isEmpty()) {
            Font authorFont = new Font("Malgun Gothic", Font.PLAIN, authorFontSize);
            g2d.setFont(authorFont);
            FontMetrics afm = g2d.getFontMetrics();

            int aWidth = afm.stringWidth(speaker);
            int aX = rightX + rightWidth - (paddingX + 10) - aWidth; // 오른쪽 정렬
            int aY = height - paddingYBot - 20;               // 따옴표보다 조금 위
            g2d.drawString(speaker, aX, aY);
        }

        g2d.dispose();

        // 8. 결과 파일 저장
        File outDir = new File(outputDirPath);
        if (!outDir.exists()) {
            outDir.mkdirs();
        }

        String fileName = "quote_" + UUID.randomUUID() + ".png";
        File outFile = new File(outDir, fileName);
        ImageIO.write(canvas, "png", outFile);

        return fileName;
    }
}
