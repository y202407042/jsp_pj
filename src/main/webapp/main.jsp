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

    /* ===== 헤더 ===== */
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

    /* ===== 메인 컨테이너 ===== */
    .container {
      border: 3px solid #000000;
      padding: 3vw;
      min-height: 70vh;
      box-sizing: border-box;
    }

    /* 공통 카테고리 카드 (위의 4개 + 우리들의 명언까지 같은 스타일) */
    .category-box {
      position: relative;
      width: 48%;
      height: 250px;
      background-size: cover;
      background-position: center;
      color: white;
      margin: 1%;
      float: left;
      font-size: 3vw;
      display: flex;
      justify-content: center;
      align-items: center;
      cursor: pointer;
      border-radius: 8px;
      box-sizing: border-box;
      overflow: hidden;
    }

    .category-box::before {
      content: "";
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(0, 0, 0, 0.4);
      border-radius: 8px;
      z-index: 0;
    }

    .category-text {
      position: relative;
      z-index: 1;
      font-weight: bold;
    }

    .category-box:hover {
      border: 4px solid #000000;
      box-sizing: border-box;
    }

    /* 5번째 “우리들의 명언” 카드: 가운데 한 줄에 배치 */
    .category-box.center {
      float: none;          /* 좌우 배치 해제 */
      clear: both;          /* 위의 4개 float 아래로 확실히 내리기 */
      width: 48%;           /* 크기는 위 카드랑 동일 */
      margin: 2% auto 0;    /* 위에 약간 여백, 좌우 중앙 정렬 */
    }

    /* float 정리용 */
    .clear {
      clear: both;
    }

    /* ===== 푸터 ===== */
    .footer {
      border: 3px solid #000000;
      padding: 10px;
      text-align: center;
      font-size: 14px;
      background-color: #000000;
      color: #ffffff;
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
    <a href="quote.jsp">명언 만들기</a>
  </div>
</div>

<div class="container">
  <!-- 상단 4개 카테고리 -->
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

  <!-- 줄 한번 정리해서 5번째 카드는 그 아래 한 줄에 -->
  <div class="clear"></div>

  <!-- 우리들의 명언 카테고리 (logo.png 배경) -->
  <a href="category.jsp?type=generated">
    <div class="category-box center" style="background-image:url('resources/logo.png');">
      <span class="category-text">우리들의 명언</span>
    </div>
  </a>

  <div class="clear"></div>
</div>

<div class="footer">
  Made by 김규환 김민서 이민태
</div>
</body>
</html>
