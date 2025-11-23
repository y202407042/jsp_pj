<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 25. 11. 18.
  Time: 오후 1:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>TheQuoteBox</title>
  <style>
body {
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
  background: #ffffff;
  color: #000000;
}

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

.logo-link {
  display: flex;
  align-items: center;
  height: 100%;
}

.logo-image {
  height: 80px;
  width: auto;
  display: block;
}

.menu {
  display: flex;
  gap: 2vw;
}

.menu a {
  color: #ffffff;
  font-size: 1.3vw;
  font-weight: bold;
  text-decoration: none;
}

.menu a:hover {
  text-decoration: underline;
}

.container {
  border: 3px solid #000000;
  padding: 3vw;
  min-height: 70vh;
  box-sizing: border-box;
}

.footer {
  border: 3px solid #000000;
  padding: 10px;
  text-align: center;
  font-size: 14px;
  background-color: #000000; /* 검은 배경 */
  color: #ffffff;            /* 흰 글씨 */
}

a {
  text-decoration: none;
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
    <a href="createQuote.jsp">명언 만들기</a>
  </div>
</div>


<div class="container">
  <a href="category.jsp?type=love">
    <div class="category-box" style="background-image:url('resources/love.jpg');">
      <span class="category-text">사랑</span>
    </div>
  </a>
  <a href="category.jsp?type=philosophy">
    <div class="category-box" style="background-image:url('resources/philosophy.jpg');">
      <span class="category-text">철학</span>
    </div>
  </a>
  <a href="category.jsp?type=motivation">
    <div class="category-box" style="background-image:url('resources/motivation.jpg');">
      <span class="category-text">동기부여</span>
    </div>
  </a>
  <a href="category.jsp?type=life">
    <div class="category-box" style="background-image:url('resources/life.jpg');">
      <span class="category-text">삶</span>
    </div>
  </a>

  <div class="quote-box">
    <% String recentQuote = (String) request.getAttribute("recentQuote"); %>
    <%= recentQuote != null ? recentQuote : "최근 생성된 명언이 표시됩니다." %>
  </div>
</div>

<div class="footer">
  Made by 김규환 김민서 이민태
</div>
</body>
</html>
