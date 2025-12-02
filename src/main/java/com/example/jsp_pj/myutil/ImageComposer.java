package com.example.jsp_pj.myutil;

import java.awt.Color;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import javax.imageio.ImageIO;

public class ImageComposer {

    // 명언 사진 생성기
    public static String composeImage(
            String srcImagePath,  // 원본 인물 사진 경로
            String quoteText,     // 명언 텍스트
            String speaker,       // 화자 이름
            String outputDirPath) // 저장할 폴더 경로
            throws IOException {

        // 입력 값 처리 (null방지)
        if (quoteText == null) quoteText = "";
        if (speaker == null)   speaker   = "";

        // 원본 인문 사진 불러오기
        BufferedImage portrait = ImageIO.read(new File(srcImagePath));
        if (portrait == null) {
            throw new IOException("😱 이미지를 읽을 수 없습니다: " + srcImagePath);
        }

        // 최종 캔버스 만들기 (16:9)
        int width  = 1365;  // 가로
        int height = 768;   // 세로

        // 왼쪽 45%는 인물 사진 / 오른쪽 55%는 텍스트
        int leftWidth = (int) (width * 0.45);

        BufferedImage canvas = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = canvas.createGraphics();

        // 글씨 설정
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        g2d.setRenderingHint(RenderingHints.KEY_TEXT_ANTIALIASING, RenderingHints.VALUE_TEXT_ANTIALIAS_ON);

        // 배경
        g2d.setColor(Color.BLACK);
        g2d.fillRect(0, 0, width, height);

        // 왼쪽에 인물 사진 꽉 채우기
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
        int drawY = (height - scaledH) / 2;

        g2d.setClip(0, 0, leftWidth, height);
        g2d.drawImage(portrait, drawX, drawY, scaledW, scaledH, null);
        g2d.setClip(null);

        // 우측 텍스트 영역 설정
        int rightX      = leftWidth;
        int rightWidth  = width - leftWidth;
        int paddingX    = 80;
        int paddingYTop = 40;
        int paddingYBot = 80;
        int textAreaX   = rightX + paddingX;
        int textAreaW   = rightWidth - paddingX * 2;

        // 폰트 크기 설정
        int mainFontSize   = 48;
        int authorFontSize = 30;
        int quoteFontSize  = 100;
        int lineGap        = 14;

        // 본문 텍스트 줄 단위로 나누기
        quoteText = quoteText.replace("\r", "");
        String[] lines = quoteText.split("\n");

        // MaruBuri SemiBold 폰트 기본 경로 (webapp/resources/fonts 위치 가정)
        String fontPath = outputDirPath + "/../resources/fonts/MaruBuri-SemiBold.ttf";

        // 폰트 한 번 로드
        Font maruBuriBase;
        try {
            maruBuriBase = Font.createFont(Font.TRUETYPE_FONT, new File(fontPath));
        } catch (FontFormatException | IOException e) {
            e.printStackTrace();
            maruBuriBase = new Font("SansSerif", Font.PLAIN, mainFontSize);
        }

        // 본문 폰트 설정 및 흰색 글씨
        Font mainFont = maruBuriBase.deriveFont(Font.PLAIN, mainFontSize);
        g2d.setFont(mainFont);
        g2d.setColor(Color.WHITE);
        FontMetrics fm = g2d.getFontMetrics();

        int availableHeight = height - paddingYTop - paddingYBot;
        int offsetUp = 40;

        int textBlockHeight = 0;
        if (lines.length > 0) {
            textBlockHeight = lines.length * fm.getHeight() + (lines.length -1) * lineGap;
        }

        int startY;
        if (textBlockHeight > availableHeight) {
            startY = paddingYTop;
        } else {
            startY = paddingYTop + (availableHeight - textBlockHeight)/2 - offsetUp;
        }

        // 큰따옴표 폰트 설정
        Font quoteFont;
        try {
            quoteFont = Font.createFont(Font.TRUETYPE_FONT, new File(fontPath)).deriveFont(Font.BOLD, quoteFontSize);
        } catch (FontFormatException | IOException e) {
            e.printStackTrace();
            quoteFont = new Font("SansSerif", Font.BOLD, quoteFontSize);
        }
        g2d.setFont(quoteFont);
        FontMetrics qfm = g2d.getFontMetrics();

        String openQuote  = "“";
        String closeQuote = "”";

        int openWidth = qfm.stringWidth(openQuote);
        int openX = textAreaX;
        int openY = startY - qfm.getDescent() - 30;
        g2d.drawString(openQuote, openX, openY);

        int closeWidth = qfm.stringWidth(closeQuote);
        int closeX = rightX + rightWidth - paddingX - closeWidth;
        int closeY = height - paddingYBot - 30;
        g2d.drawString(closeQuote, closeX, closeY);

        // 본문 텍스트 그리기
        g2d.setFont(mainFont);
        int yPos = startY;
        for (String line : lines) {
            g2d.drawString(line, textAreaX, yPos);
            yPos += fm.getHeight() + lineGap;
        }

        // 화자 이름 (우측 하단 정렬)
        if (!speaker.trim().isEmpty()) {
            Font authorFont;
            try {
                authorFont = Font.createFont(Font.TRUETYPE_FONT, new File(fontPath)).deriveFont(Font.PLAIN, authorFontSize);
            } catch (FontFormatException | IOException e) {
                e.printStackTrace();
                authorFont = new Font("SansSerif", Font.PLAIN, authorFontSize);
            }
            g2d.setFont(authorFont);
            FontMetrics afm = g2d.getFontMetrics();

            int aWidth = afm.stringWidth(speaker);
            int aX = rightX + rightWidth - (paddingX + 10) - aWidth;
            int aY = height - paddingYBot - 20;
            g2d.drawString(speaker, aX, aY);
        }

        g2d.dispose();

        // 이미지 파일 저장
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
