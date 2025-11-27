<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>TheQuoteBox</title>
  <style>
/* 기본 html, body 높이, 여백 초기화 */
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}

/* 상단 헤더 스타일 */
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
.logo-link { display: flex; align-items: center; height: 100%; }
.logo-image { height: 80px; width: auto; display: block; }
.menu { display: flex; gap: 2vw; }
.menu a { color: #ffffff; font-size: 1.3vw; font-weight: bold; text-decoration: none; }
.menu a:hover { text-decoration: underline; }
/* 메인 컨테이너 박스 */
.container {
  
  padding: 3vw;
  min-height: 70vh;
  box-sizing: border-box;
}

/* 카테고리 박스 스타일 및 위치 지정 */
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

/* 카테고리 박스 어두운 오버레이 */
.category-box::before {
  content: "";
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  border-radius: 8px;
  z-index: 0;
}

/* 카테고리 텍스트는 오버레이 위에 표시 */
.category-text {
  position: relative;
  z-index: 1;
  font-weight: bold;
}

/* 카테고리 박스 호버시 테두리 강조 */
.category-box:hover {
  border: 4px solid #000000; /* 굵은 검정 테두리 */
  box-sizing: border-box;
}

/* 명언 박스 스타일 */
.quote-box {
  clear: both; /* float 요소 해제 */
  width: 90%;
  height: 15vh;
  background: #ffffff;
  margin: 5vh auto;
  border-radius: 8px;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 2vw;
  font-weight: bold;
  color: #000000;
}

/* 커스텀 폰트 정의 */
@font-face {
  font-family: 'MaruBuri';
  src: url('resources/fonts/MaruBuri-Regular.ttf') format('truetype');
  font-weight: 400;
}

/* 하단 푸터 스타일 */
.footer {
  padding: 20px 0 30px;
  text-align: center;
  font-size: 14px;
  background-color: #000000;
  color: #ffffff;
  font-family: 'MaruBuri', sans-serif;
}

/* 푸터 내 링크 스타일 */
.footer a {
  color: #ffffff;
  text-decoration: none;
}

/* 푸터 링크 호버시 밑줄 */
.footer a:hover {
  text-decoration: underline;
}

/* 구분선 */
.footer-line {
  width: 90%;
  border-top: 1px solid #ffffff;
  margin: 10px auto 15px;
}

/* 모든 링크 기본 텍스트 데코 제거 */
a {
  text-decoration: none;
}
  </style>
</head>
<body>

<!-- 헤더 영역: 로고와 메뉴 -->
<div class="header">
  <a href="main.jsp" class="logo-link">
    <img src="resources/logo2.png" alt="TheQuoteBox" class="logo-image">
  </a>
  <div class="menu">
    <a href="todayQuote.jsp">오늘의 명언</a>
    <a href="createQuote.jsp">명언 만들기</a>
  </div>
</div>

<!-- 메인 컨테이너: 카테고리 링크와 최근 명언 박스 -->
<div class="container">

  <!-- 사랑 카테고리 -->
  <a href="category_love.jsp">
    <div class="category-box" style="background-image:url('resources/love.jpg');">
      <span class="category-text">사랑</span>
    </div>
  </a>

  <!-- 철학 카테고리 -->
  <a href="category_philosophy.jsp">
    <div class="category-box" style="background-image:url('resources/philosophy.jpg');">
      <span class="category-text">철학</span>
    </div>
  </a>

  <!-- 동기부여 카테고리 -->
  <a href="category_motivation.jsp">
    <div class="category-box" style="background-image:url('resources/motivation.jpg');">
      <span class="category-text">동기부여</span>
    </div>
  </a>

  <!-- 삶 카테고리 -->
  <a href="category_life.jsp">
    <div class="category-box" style="background-image:url('resources/life.jpg');">
      <span class="category-text">삶</span>
    </div>
  </a>

  <!-- 최근 생성된 명언 표시 영역 -->
  <div class="quote-box">
    <% 
      // request에서 최근 명언 받아서 출력, 없으면 기본 문구 표시
      String recentQuote = (String) request.getAttribute("recentQuote"); 
    %>
    <%= recentQuote != null ? recentQuote : "최근 생성된 명언이 표시됩니다." %>
  </div>

</div>

<!-- 푸터 영역: 팀정보, 깃허브, 연락처 등 -->
<div class="footer">
  <div>
    TheQuoteBox | 7조 | <strong>김민서</strong>, 김규환, 이민태
  </div>
  <div>
    Github : 
    <a href="https://github.com/y202407042/jsp_pj" target="_blank">
      [https://github.com/y202407042/jsp_pj](https://github.com/y202407042/jsp_pj)
    </a>
  </div>
  <div>
    문의 : y202407042 | kingMintae | 202407038
  </div>
  <div>
    주소 : 경기도 부천시 경인로 590 (5407호)
  </div>

  <div class="footer-line"></div>

  <div>
    Copyleft © Team 7
  </div>
</div>

</body>
</html>
