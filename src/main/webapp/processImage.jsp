<%-- processImage.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="com.example.jsp_pj.myutil.ImageComposer" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    String ctx = request.getContextPath();

    // 결과 이미지를 저장할 폴더 (generated_images)
    String realPath = application.getRealPath("/generated_images");
    String webPath  = ctx + "/generated_images/";

    System.out.println("=== DEBUG START ===<br>");
    System.out.println("Content-Type: " + request.getContentType() + "<br>");
    System.out.println("realPath = " + realPath + "<br>");
    System.out.println("preset dir realPath = " + application.getRealPath("/preset_backgrounds") + "<br>");
    System.out.println("=== DEBUG END ===<br>");

    File dir = new File(realPath);
    if (!dir.exists()) {
        dir.mkdirs();
    }

    int maxSize = 5 * 1024 * 1024; // 5MB

    // multipart/form-data 여부 확인
    String ctype = request.getContentType();
    if (ctype == null || !ctype.toLowerCase().startsWith("multipart/form-data")) {
        System.out.println("오류 발생: Posted content type isn't multipart/form-data<br>");
        System.out.println("<a href='" + ctx + "/quote.jsp'>다시 시도</a>");
        return;
    }

    try {
        // 1) MultipartRequest로 폼 데이터 받기
        MultipartRequest multi = new MultipartRequest(
                request,
                realPath,                 // 업로드(임시) 경로
                maxSize,
                "UTF-8",
                new DefaultFileRenamePolicy()
        );

        // 2) 텍스트 파라미터
        String quoteText = multi.getParameter("quoteText");
        String speaker   = multi.getParameter("speaker");
        String preset    = multi.getParameter("preset");
        String passcode  = multi.getParameter("passcode");
        String category  = multi.getParameter("category");

        if (quoteText == null) quoteText = "";
        if (speaker   == null) speaker   = "";
        if (preset    == null || preset.trim().equals("")) {
            preset = "공자.jpg"; // 기본값
        }
        if (passcode == null || passcode.trim().equals("")) passcode = "0000";
        if (category == null || category.trim().equals("")) category = "etc";

        // 3) 사용할 원본 이미지 실제 경로
        String srcImagePath = application.getRealPath("/preset_backgrounds/" + preset);

        // 4) 이미지 합성 호출
        String composedFileName =
                ImageComposer.composeImage(srcImagePath, quoteText, speaker, realPath);

        // 5) 성공 시 DB에 저장 + 세션에 경로 저장 후 result.jsp로 이동
        if (composedFileName != null) {
            String fullImagePath = webPath + composedFileName;

            // DB 저장
            String dbUrl  = "jdbc:mysql://localhost:3306/quote_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
            String dbUser = "quote_user";
            String dbPass = "q1234";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                     PreparedStatement ps = conn.prepareStatement(
                             "INSERT INTO quote(text_content, speaker, category, passcode, image_path) VALUES (?, ?, ?, ?, ?)"
                     )) {
                    ps.setString(1, quoteText);
                    ps.setString(2, speaker);
                    ps.setString(3, category);
                    ps.setString(4, passcode);
                    ps.setString(5, fullImagePath);
                    ps.executeUpdate();
                }
            } catch (Exception e) {
                e.printStackTrace(); // 일단 콘솔에만
            }

            session.setAttribute("imageUrl", fullImagePath);
            response.sendRedirect(ctx + "/result.jsp");
        } else {
            System.out.println("<h3>이미지 합성에 실패했습니다.</h3>");
            System.out.println("<a href='" + ctx + "/quote.jsp'>다시 시도</a>");
        }

    } catch (Exception e) {
        System.out.println("<h3>오류 발생: " + e.getMessage() + "</h3>");
        System.out.println("<a href='" + ctx + "/quote.jsp'>다시 시도</a>");
        e.printStackTrace();
    }
%>
