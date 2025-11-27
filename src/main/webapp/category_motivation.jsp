<%@ page contentType="text/html; charset=UTF-8" %>
<%
  String folder = "motivation";
  int total = 7;
  String ext = "jpg";
  int initial = (int)(Math.random() * total) + 1;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>motivation Quotes</title>
  <style>
html, body {
  margin: 0;
  padding: 0;
  height: 100%;
}

body {
  min-height: 100vh;
  display: flex;
  flex-direction: column;   /* 헤더 - 본문 - 푸터 */
  background: #ffffff;
}

/* 헤더 */
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

/* 헤더와 푸터 사이 흰 영역 */
.content-wrapper {
  flex: 1;                         /* 남는 높이 전부 사용 */
  background: #ffffff;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;         /* 세로 가운데 (이미지+아이콘 묶어서) */
  padding: 40px 0 40px;            /* 위/아래 여백 */
  box-sizing: border-box;
}

/* 이미지 */
.image-area {
  margin-bottom: 20px;             /* 이미지와 아이콘 사이 간격 */
}
.main-image {
  max-width: 70vw;
  max-height: 60vh;
  object-fit: contain;
  display: block;
}

#iconContainer {
  display: flex;
  gap: 24px;
  align-items: center; /* 컨테이너 기준 중앙 */
}

/* 공통 박스 (55x55) */
.icon-box {
  width: 55px;
  height: 55px;
  display: flex;
  align-items: center;
  justify-content: center;
}


/* 🔁 버튼 */
#randomIcon {
  width: 55px;
  height: 55px;
  display: flex;         /* 박스 안에서 이모지 가운데 */
  align-items: center;
  justify-content: center;
  font-size: 32px;       /* 필요하면 조절 */
  line-height: 1;
  cursor: pointer;
    position: relative;
  top: -3px;   /* 필요하면 2px까지 올려보면서 조정 */
}

/* 다운로드 이미지 */
#downloadIcon {
  width: 55px;
  height: 55px;
  display: block;        /* 이미지 아래 여백 제거 */
  cursor: pointer;
}

#randomIcon:hover,
#downloadIcon:hover {
  opacity: 0.8;
}

/* 폰트 & 푸터 */
@font-face {
  font-family: 'MaruBuri';
  src: url('resources/fonts/MaruBuri-Regular.ttf') format('truetype');
  font-weight: 400;
}
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
    <a href="main.jsp" class="logo-link">
      <img src="resources/logo2.png" alt="TheQuoteBox" class="logo-image">
    </a>
    <div class="menu">
      <a href="todayQuote.jsp">오늘의 명언</a>
      <a href="createQuote.jsp">명언 만들기</a>
    </div>
  </div>

  <!-- 흰색 영역: 이미지 + 아이콘 -->
  <div class="content-wrapper">
    <div class="image-area">
      <img class="main-image" id="mainImage"
           src="<%=request.getContextPath()%>/resources/<%=folder%>/<%=initial%>.<%=ext%>"
           alt="motivation Quote Image">
    </div>

    <div id="iconContainer">
      <span id="randomIcon" title="다른 이미지 보기" aria-label="랜덤 이미지">🔁</span>
      <img src="resources/download.png" alt="Download" id="downloadIcon"
           title="명언 이미지 다운로드" aria-label="사진 다운로드">
    </div>
  </div>

  <div class="footer">
    <div>
      TheQuoteBox | 7조 | <strong>김민서</strong>, 김규환, 이민태
    </div>
    <div>
      Github :
      <a href="https://github.com/y202407042/jsp_pj" target="_blank">
        https://github.com/y202407042/jsp_pj
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
    const totalImages = <%= total %>;
    const folder = "<%= folder %>";
    const ext = "<%= ext %>";
    const mainImage = document.getElementById('mainImage');
    const randomIcon = document.getElementById('randomIcon');
    const downloadIcon = document.getElementById('downloadIcon');

    let currentImage = <%= initial %>;

    randomIcon.addEventListener('click', () => {
      let randomNumber;
      do {
        randomNumber = Math.floor(Math.random() * totalImages) + 1;
      } while (randomNumber === currentImage);

      mainImage.src =
        '<%=request.getContextPath()%>/resources/' + folder + '/' + randomNumber + '.' + ext;
      currentImage = randomNumber;
    });

    downloadIcon.addEventListener('click', () => {
      const link = document.createElement('a');
      link.href = mainImage.src;
      const parts = mainImage.src.split('/');
      const filename = parts[parts.length - 1];
      link.download = filename;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    });
  </script>
</body>
</html>
