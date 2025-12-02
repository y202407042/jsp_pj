<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
     String ctx =request.getContextPath();

    String imageUrl = (String) session.getAttribute("imageUrl");
    session.removeAttribute("imageUrl");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>명언 이미지 결과 - TheQuoteBox</title>
  <style>
body {
  margin: 0;
  padding: 0;
  font-family: "Malgun Gothic", Arial, sans-serif;
  background: #ffffff;
  color: #000000;
}

/* main.jsp와 동일한 헤더/푸터 */
.header {
  border: 3px solid #000000;
  padding: 0 32px;
  font-size: 32px;
  font-weight: bold;
  height: 90px;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  background-color: #000000;
  color: #ffffff;
  justify-content: space-between;
}
.logo-link { display:flex; align-items:center; height:100%; }
.logo-image { height:80px; width:auto; display:block; }
.menu { display:flex; gap:2vw; }
.menu a { color:#ffffff; font-size:1.3vw; font-weight:bold; text-decoration:none; }
.menu a:hover { text-decoration:underline; }

.container {
  border: 3px solid #000000;
  padding: 3vw;
  min-height: 70vh;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.result-card {
  background: #000000;
  padding: 20px 20px 36px;
  border-radius: 12px;
  box-shadow: 0 0 15px rgba(0,0,0,0.5);
  position: relative;
}

.result-card img {
  max-width: 80vw;
  max-height: 60vh;
  display: block;
  border-radius: 8px;
}

/* 카드 안 우측 아래에 겹치는 다운로드 링크 */
.download-link {
  position: absolute;
  right: 30px;
  bottom: 18px;
  color: #ffffff;
  text-decoration: underline;
  font-size: 14px;
}
.download-link:hover { color:#dddddd; }

.footer {
  border: 3px solid #000000;
  padding: 10px;
  text-align: center;
  font-size: 14px;
  background-color: #000000;
  color: #ffffff;
}

.new-link {
  margin-top: 18px;
  font-size: 14px;
}
.new-link a {
  color:#000;
  text-decoration: underline;
}
  </style>
</head>
<body>
<div class="header">
  <a href="main.jsp" class="logo-link">
    <img src="resources/logo2.png" alt="TheQuoteBox" class="logo-image">
  </a>
  <div class="menu">
    <a href="todayQuote.jsp">오늘의 명언</a>
    <a href="quote.jsp">명언 만들기</a>
  </div>
</div>

<div class="container">
  <h2>✨ 명언 이미지 생성 완료! ✨</h2>

  <% if (imageUrl != null && !imageUrl.trim().equals("")) { %>
    <div class="result-card">
      <img src="<%=imageUrl%>" alt="생성된 명언 이미지">
      <a class="download-link" href="<%=imageUrl%>" download="quote_image.png">
        이미지 다운로드
      </a>
    </div>
    <div class="new-link">
      <a href="<%=ctx%>/quote.jsp">새로운 이미지 만들기</a> |
      <a href="<%=ctx%>/main.jsp">메인으로 돌아가기</a>
    </div>
  <% } else { %>
    <p>결과 이미지를 불러오는 데 실패했습니다.</p>
    <div class="new-link">
      <a href="<%=ctx%>/quote.jsp">다시 시도하기</a>
    </div>
  <% } %>
</div>

<div class="footer">
  Made by 김규환 김민서 이민태
</div>
</body>
</html>
