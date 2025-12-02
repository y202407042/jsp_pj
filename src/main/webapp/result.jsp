<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 요청 인코딩 설정 (한글 깨짐 방지)
    request.setCharacterEncoding("UTF-8");

    // 컨텍스트 경로 얻기
    String ctx = request.getContextPath();

    // 세션에서 이미지 URL 가져오기
    String imageUrl = (String) session.getAttribute("imageUrl");
    
    // 유효한 이미지 URL이 있으면 세션에 최근 명언 이미지 정보 저장
    if (imageUrl != null && !imageUrl.trim().equals("")) {
        session.setAttribute("recentImageUrl", imageUrl);
        session.setAttribute("recentQuoteText", "최근 생성된 명언 이미지");
        System.out.println("DEBUG: recentImageUrl saved to session: " + imageUrl);
    }
    
    // 디버그 출력
    System.out.println("DEBUG result.jsp imageUrl = " + imageUrl);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>명언 이미지 결과 - TheQuoteBox</title>
  <style>
    /* 기본 body 스타일 (마진, 패딩 제거, 폰트, 배경, 글자색) */
    body {
      margin: 0;
      padding: 0;
      font-family: "Malgun Gothic", Arial, sans-serif;
      background: #ffffff;
      color: #000000;
    }
    /* 상단 헤더 바 스타일 */
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
    /* 로고 링크 스타일 (가로 flex 정렬, 높이 맞춤) */
    .logo-link { display:flex; align-items:center; height:100%; }
    .logo-image { height:80px; width:auto; display:block; }
    /* 메뉴 아이템 스타일 (가로 배치, 간격) */
    .menu { display:flex; gap:2vw; }
    .menu a { color:#ffffff; font-size:1.3vw; font-weight:bold; text-decoration:none; }
    .menu a:hover { text-decoration:underline; }

    /* 메인 컨테이너 스타일 (테두리, 내부 여백, 최소 높이, 정렬) */
    .container {
      border: 3px solid #000000;
      padding: 3vw;
      min-height: 70vh;
      box-sizing: border-box;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    /* 명언 이미지 결과 카드 스타일 (배경, 패딩, 둥근 테두리, 그림자, 위치) */
    .result-card {
      background: #000000;
      padding: 20px 20px 36px;
      border-radius: 12px;
      box-shadow: 0 0 15px rgba(0,0,0,0.5);
      position: relative;
    }
    /* 결과 이미지 크기 및 테두리 둥글게 */
    .result-card img {
      max-width: 80vw;
      max-height: 60vh;
      display: block;
      border-radius: 8px;
    }
    /* 다운로드 링크 위치 및 스타일 (절대 위치, 오른쪽 하단) */
    .download-link {
      position: absolute;
      right: 30px;
      bottom: 18px;
      color: #ffffff;
      text-decoration: underline;
      font-size: 14px;
    }
    .download-link:hover { color:#dddddd; }
    /* 새 이미지 만들기 및 메인으로 가기 링크 스타일 */
    .new-link {
      margin-top: 18px;
      font-size: 14px;
    }
    .new-link a {
      color:#000;
      text-decoration: underline;
    }

    /* 웹폰트 MaruBuri 로드 및 폰트 가중치 설정 */
    @font-face {
      font-family: 'MaruBuri';
      src: url('<%=ctx%>/resources/fonts/MaruBuri-Regular.ttf') format('truetype');
      font-weight: 400;
      font-style: normal;
    }
    @font-face {
      font-family: 'MaruBuri';
      src: url('<%=ctx%>/resources/fonts/MaruBuri-SemiBold.ttf') format('truetype');
      font-weight: 600;
      font-style: normal;
    }

    /* 하단 푸터 스타일 (배경, 글자 색, 폰트) */
    .footer {
      padding: 15px 0 20px;
      text-align: center;
      font-size: 14px;
      background-color: #000000;
      color: #ffffff;
      font-family: 'MaruBuri', sans-serif;
    }
    .footer a { color: #ffffff; text-decoration: none; }
    .footer a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="header">
  <a href="<%=ctx%>/main.jsp" class="logo-link">
    <img src="<%=ctx%>/resources/logo2.png" alt="TheQuoteBox" class="logo-image">
  </a>
  <div class="menu">
    <a href="<%=ctx%>/todayQuote.jsp">오늘의 명언</a>
    <a href="<%=ctx%>/quote.jsp">명언 만들기</a>
  </div>
</div>

<div class="container">
  <h2>✨ 명언 이미지 생성 완료! ✨</h2>

  <% if (imageUrl != null && !imageUrl.trim().equals("")) { %>
    <div class="result-card">
      <!-- 생성된 명언 이미지 출력 -->
      <img src="<%= imageUrl %>" alt="생성된 명언 이미지">
      <!-- 이미지 다운로드 링크 -->
      <a class="download-link" href="<%= imageUrl %>" download="quote_image.png">
        이미지 다운로드
      </a>
    </div>
    <div class="new-link">
      <!-- 새 이미지 만들기, 메인 페이지 이동 링크 -->
      <a href="<%=ctx%>/quote.jsp">새로운 이미지 만들기 🔄️</a>&nbsp;&nbsp;&nbsp;   
      <a href="<%=ctx%>/main.jsp">메인으로 돌아가기 🔙</a>
    </div>
  <% } else { %>
    <!-- 이미지 URL이 없거나 빈 문자열일 경우 오류 메시지 -->
    <p>결과 이미지를 불러오는 데 실패했습니다.</p>
    <div class="new-link">
      <a href="<%=ctx%>/quote.jsp">다시 시도하기</a>
    </div>
  <% } %>
</div>

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
    <div>
      Copyleft © Team 7
    </div>
  </div>
