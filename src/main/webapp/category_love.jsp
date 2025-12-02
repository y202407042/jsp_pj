<%@ page contentType="text/html; charset=UTF-8" %>
<%
  // 폴더명, 이미지 총 개수, 확장자 설정
  String folder = "love";
  int total = 7;
  String ext = "jpg";
  // 초기 랜덤 이미지 번호 생성 (1~7)
  int initial = (int)(Math.random() * total) + 1;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Love Quotes</title>
  <style>
    /* 기본 마진/패딩 제거, 전체 높이 100% */
html, body {
  margin: 0;
  padding: 0;
  height: 100%;
}

body {
  min-height: 100vh;
  display: flex;
  flex-direction: column;   /* 헤더 → 본문 → 푸터 */
  background: #ffffff;
}

/* 헤더 스타일 */
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

/* 메인 콘텐츠 영역 (좌우 광고 + 중앙 이미지) */
.content-wrapper {
  flex: 1;
  background: #ffffff;
  display: flex;              /* 좌-중-우 가로 배치 */
  align-items: center;        /* 세로 가운데 정렬 */
  justify-content: space-between;
  box-sizing: border-box;
  padding-top: 40px;
}

/* 좌우 광고 영역 */
.side-ad {
  display: block;
  width: 250px;
  flex-shrink: 0;
  margin-top: -50px;   /* 헤더 위로 살짝 올리기 */
}
.side-ad img {
  width: 250px;
  height: auto;
  display: block;
  cursor: pointer;
}

/* 중앙 영역 (이미지 + 아이콘 버튼) */
.center-area {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

/* 메인 이미지 영역 */
.image-area {
  margin-bottom: 20px;
}
.main-image {
  max-width: 75vw;
  max-height: 70vh;
  object-fit: contain;
  display: block;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 1);  /* 그림자 효과 */
}

/* 아이콘 버튼 컨테이너 */
#iconContainer {
  display: flex;
  gap: 24px;
  align-items: center;
}

/* 공통 아이콘 박스 크기 */
.icon-box {
  width: 55px;
  height: 55px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* 🔁 랜덤 버튼 */
#randomIcon {
  width: 55px;
  height: 55px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32px;
  line-height: 1;
  cursor: pointer;
  position: relative;
  top: -3px;
}

/* 다운로드 아이콘 */
#downloadIcon {
  width: 55px;
  height: 55px;
  display: block;
  cursor: pointer;
}

#randomIcon:hover,
#downloadIcon:hover {
  opacity: 0.8; /* 호버시 살짝 투명 */
}

/* MaruBuri 폰트 로드 */
@font-face {
  font-family: 'MaruBuri';
  src: url('resources/fonts/MaruBuri-Regular.ttf') format('truetype');
  font-weight: 400;
}

/* 푸터 스타일 */
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
  <!-- 헤더: 로고 + 메뉴 -->
  <div class="header">
    <a href="main.jsp" class="logo-link">
      <img src="resources/logo2.png" alt="TheQuoteBox" class="logo-image">
    </a>
    <div class="menu">
      <a href="todayQuote.jsp">오늘의 명언</a>
      <a href="quote.jsp">명언 만들기</a>
    </div>
  </div>

  <!-- 메인 콘텐츠: 좌우 광고 + 중앙 이미지 -->
  <div class="content-wrapper">
    <!-- 왼쪽 광고 -->
    <a href="https://www.saramin.co.kr/zf_user/" target="_blank" class="side-ad left-ad">
      <img src="resources/ad1.jpg" alt="광고 1">
    </a>

    <!-- 중앙: 랜덤 사랑 명언 이미지 + 버튼 -->
    <div class="center-area">
      <div class="image-area">
        <!-- JSP로 초기 랜덤 이미지 표시 -->
        <img class="main-image" id="mainImage"
             src="<%=request.getContextPath()%>/resources/<%=folder%>/<%=initial%>.<%=ext%>"
             alt="Love Quote Image">
      </div>

      <!-- 🔁 랜덤 / 다운로드 버튼 -->
      <div id="iconContainer">
        <span id="randomIcon" title="다른 이미지 보기" aria-label="랜덤 이미지">🔁</span>
        <img src="resources/download.png" alt="Download" id="downloadIcon"
             title="명언 이미지 다운로드" aria-label="사진 다운로드">
      </div>
    </div>

    <!-- 오른쪽 광고 -->
    <a href="https://www.acmicpc.net/" target="_blank" class="side-ad right-ad">
      <img src="resources/ad2.jpg" alt="광고 2">
    </a>
  </div>

  <!-- 푸터: 팀 정보 + 깃허브 링크 -->
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

  <script>
    // JSP에서 넘어온 변수들
    const totalImages = <%= total %>;
    const folder = "<%= folder %>";
    const ext = "<%= ext %>";
    const mainImage = document.getElementById('mainImage');
    const randomIcon = document.getElementById('randomIcon');
    const downloadIcon = document.getElementById('downloadIcon');

    let currentImage = <%= initial %>; // 현재 이미지 번호

    // 🔁 버튼: 중복되지 않는 랜덤 이미지로 변경
    randomIcon.addEventListener('click', () => {
      let randomNumber;
      do {
        randomNumber = Math.floor(Math.random() * totalImages) + 1;
      } while (randomNumber === currentImage);

      mainImage.src =
        '<%=request.getContextPath()%>/resources/' + folder + '/' + randomNumber + '.' + ext;
      currentImage = randomNumber;
    });

    // 다운로드 버튼: 현재 이미지 다운로드
    downloadIcon.addEventListener('click', () => {
      const link = document.createElement('a');
      link.href = mainImage.src;
      const parts = mainImage.src.split('/');
      const filename = parts[parts.length - 1]; // 파일명 추출
      link.download = filename;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  </script>
</body>
</html>
