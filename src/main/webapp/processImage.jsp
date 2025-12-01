<%-- processImage.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="com.example.jsp_pj.myutil.ImageComposer.java" %>
<%@ page import="com.example.jsp_pj.myutil.ImageComposer" %>

<%
    request.setCharacterEncoding("UTF-8");

    String ctx = request.getContextPath();

    // 결과 이미지를 저장할 폴더 (generated_images)
    String realPath = application.getRealPath("/generated_images");
    String webPath  = ctx + "/generated_images/";

    File dir = new File(realPath);
    if (!dir.exists()) {
        dir.mkdirs();
    }

    int maxSize = 5 * 1024 * 1024; // 5MB

    // ▶ 방어용: multipart/form-data 여부 확인 (안 그러면 Posted content type 에러)
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
        String preset    = multi.getParameter("preset");  // quote.jsp에서 name="preset"

        if (quoteText == null) quoteText = "";
        if (speaker   == null) speaker   = "";
        if (preset    == null || preset.trim().equals("")) {
            preset = "공자.jpg"; // 혹시라도 선택이 안 넘어오면 기본값
        }

        // 3) 사용할 원본 이미지 실제 경로
        String srcImagePath = application.getRealPath("/preset_backgrounds/" + preset);

        // 4) 이미지 합성 호출 (ImageComposer는 4개 인자 버전으로 구현되어 있어야 함)
        String composedFileName =
                ImageComposer.composeImage(srcImagePath, quoteText, speaker, realPath);

        // 5) 성공 시 세션에 경로 저장 후 result.jsp로 이동
        if (composedFileName != null) {
            session.setAttribute("imageUrl", webPath + composedFileName);
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
