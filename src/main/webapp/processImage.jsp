<%-- processImage.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="com.example.jsp_pj.myutil.ImageComposer" %>
<%@ page import="java.sql.*" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");
    String ctx = request.getContextPath();

    // 저장할 폴더 실제 경로 및 웹 경로 설정
    String realPath = application.getRealPath("/generated_images");
    String webPath  = ctx + "/generated_images/";

    // 저장 폴더가 없으면 생성
    File dir = new File(realPath);
    if (!dir.exists()) {
        dir.mkdirs();
    }

    // 최대 업로드 파일 크기 (5MB)
    int maxSize = 5 * 1024 * 1024;

    // 요청 타입 확인 multipart/form-data 필수
    String ctype = request.getContentType();
    if (ctype == null || !ctype.toLowerCase().startsWith("multipart/form-data")) {
        out.println("오류 발생: Posted content type isn't multipart/form-data<br>");
        out.println("<a href='" + ctx + "/quote.jsp'>다시 시도</a>");
        return;
    }

    try {
        // 1) MultipartRequest 생성 - 업로드 및 파라미터 수신
        MultipartRequest multi = new MultipartRequest(
                request,
                realPath,                 // 업로드 저장 경로
                maxSize,
                "UTF-8",
                new DefaultFileRenamePolicy() // 파일명 중복시 자동 이름 변경 정책
        );

        // 2) 파라미터 추출
        String quoteText = multi.getParameter("quoteText");
        String speaker   = multi.getParameter("speaker");
        String preset    = multi.getParameter("preset");
        String passcode  = multi.getParameter("passcode");
        String category  = multi.getParameter("category");

        // 파라미터 기본값 지정
        if (quoteText == null) quoteText = "";
        if (speaker   == null) speaker   = "";
        if (preset == null || preset.trim().equals("")) preset = "공자.jpg"; // 기본 배경 이미지
        if (passcode == null || passcode.trim().equals("")) passcode = "0000";
        if (category == null || category.trim().equals("")) category = "etc";

        // 3) 원본 이미지 실제 경로 (preset backgrounds 폴더)
        String srcImagePath = application.getRealPath("/preset_backgrounds/" + preset);

        // 4) 이미지 합성 호출 (유틸리티 클래스 사용)
        String composedFileName = ImageComposer.composeImage(srcImagePath, quoteText, speaker, realPath);

        // 5) 합성 성공 시 DB 저장 및 세션에 경로 저장 후 결과 페이지로 리다이렉트
        if (composedFileName != null) {
            String fullImagePath = webPath + composedFileName;

            // DB 연결 정보
            String dbUrl  = "jdbc:mysql://localhost:3306/quote_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
            String dbUser = "quote_user";
            String dbPass = "q1234";

            try {
                // 드라이버 로드 및 DB 연결
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                     PreparedStatement ps = conn.prepareStatement(
                             "INSERT INTO quote(text_content, speaker, category, passcode, image_path) VALUES (?, ?, ?, ?, ?)"
                     )) {
                    // 쿼리 파라미터 바인딩
                    ps.setString(1, quoteText);
                    ps.setString(2, speaker);
                    ps.setString(3, category);
                    ps.setString(4, passcode);
                    ps.setString(5, fullImagePath);
                    ps.executeUpdate();
                }
            } catch (Exception e) {
                // DB 에러 콘솔 출력 (처리중 문제 발생 시 무시 가능)
                e.printStackTrace();
            }

            // 세션에 이미지 경로 저장
            session.setAttribute("imageUrl", fullImagePath);
            // 결과 페이지로 리다이렉트
            response.sendRedirect(ctx + "/result.jsp");
        } else {
            // 이미지 합성 실패 처리
            out.println("<h3>이미지 합성에 실패했습니다.</h3>");
            out.println("<a href='" + ctx + "/quote.jsp'>다시 시도</a>");
        }

    } catch (Exception e) {
        // 예외 처리: 오류 메시지 출력 및 다시 시도 링크
        out.println("<h3>오류 발생: " + e.getMessage() + "</h3>");
        out.println("<a href='" + ctx + "/quote.jsp'>다시 시도</a>");
        // 상세 스택 추적 콘솔 출력
        e.printStackTrace();
    }
%>
