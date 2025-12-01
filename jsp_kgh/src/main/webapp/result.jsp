<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 컨텍스트 경로 (예: /jspkgh)
    String ctx = request.getContextPath();

    // processImage.jsp 에서 세션에 넣어둔 이미지 경로
    String imageUrl = (String) session.getAttribute("imageUrl");

    // 한 번 쓰고 나면 세션에서 제거
    session.removeAttribute("imageUrl");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>명언 이미지 결과</title>
    <style>
    body {
        font-family: "Malgun Gothic", sans-serif;
        background: #000;
        color: #fff;
        text-align: center;
        margin: 0;
        padding: 40px 0;
    }
    h1 {
        font-size: 28px;
        margin-bottom: 20px;
    }
    .wrapper {
        display: inline-block;
        background:#000;
        padding: 0 20px 30px;
        border-radius: 8px;
        position: relative;           /* ★ 카드 위에 링크를 올리기 위한 기준 */
    }
    .card-img {
        max-width: 1000px;
        width: 90vw;
        border: 1px solid #444;
        box-shadow: 0 0 20px rgba(0,0,0,0.7);
        display:block;
    }
    /* ▼ 카드 안 오른쪽 아래에 겹치는 "이미지 다운로드" 텍스트 */
    .btn {
        position: absolute;
        right: 85px;                 /* 위치 조정: 우측에서 얼마나 떨어질지 */
        bottom: 90px;                 /* 위치 조정: 아래에서 얼마나 떨어질지 */
        color: #ffffff;
        text-decoration: underline;
        font-size: 14px;
        font-weight: normal;
        background: none;
        padding: 0;
        border: none;
        cursor: pointer;
    }
    .btn:hover {
        color: #dddddd;
    }
    .link-new {
        display: block;
        margin-top: 16px;
        color: #bbb;
        font-size:13px;
    }
    .link-new:hover {
        color: #fff;
    }
</style>

</head>
<body>

<h1>✨ 명언 이미지 생성 완료! ✨</h1>

<div class="wrapper">
<% if (imageUrl != null && !imageUrl.trim().equals("")) { %>
    <img src="<%=imageUrl%>" alt="생성된 명언 이미지" class="card-img">
    <!-- 카드(검은 영역) 안에서 화자 밑에 붙어 있는 느낌의 다운로드 버튼 -->
    <a class="btn" href="<%=imageUrl%>" download="quote_image.png">이미지 다운로드</a>
<% } else { %>
    <p>결과 이미지를 불러오는 데 실패했습니다.</p>
<% } %>
    <a class="link-new" href="<%=ctx%>/quote.jsp">새로운 이미지 만들기</a>
</div>

</body>
</html>
