<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>명언 이미지 생성하기 - TheQuoteBox</title>
  <style>
/* 공통 헤더 스타일 */
/* body 스타일 수정 - 중복 제거하고 단순화 */
/* 1. html, body 기본 설정 (맨 위에) */
html {
  height: 100%;
}

body {
  margin: 0;
  padding: 0;
  font-family: "Malgun Gothic", Arial, sans-serif;
  background: #ffffff;
  color: #000000;
  display: flex;
  flex-direction: column;
  min-height: 100vh; /* 전체 화면 높이 최소 보장 */
  box-sizing: border-box;
}

/* 2. 헤더 - 고정 높이 */
.header {
  flex-shrink: 0; /* 축소 안됨 */
  height: 90px;
  border: 3px solid #000000;
  padding: 0 32px;
  font-size: 32px;
  font-weight: bold;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  background-color: #000000;
  color: #ffffff;
  justify-content: space-between;
}

/* 3. 메인 컨테이너 - 남은 공간 모두 차지 */
.container {
  flex: 1; /* 핵심: 남은 모든 공간 채움 */
  border: 3px solid #000000;
  padding: 2vw 3vw;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  min-height: 0; /* flex 자식에서 필요 */
}

/* 4. 푸터 - 항상 바닥 고정 */
.footer {
  flex-shrink: 0; /* 축소 안됨 */
  padding: 20px 0 30px;
  text-align: center;
  font-size: 14px;
  background-color: #000000;
  color: #ffffff;
  font-family: 'MaruBuri', sans-serif;
}


/* html 초기화 (맨 위에 추가) */
html {
  height: 100%;
  margin: 0;
  padding: 0;
}

.logo-link { display:flex; align-items:center; height:100%; }
.logo-image { height:80px; width:auto; display:block; }
.menu { display:flex; gap:2vw; }
.menu a { color:#ffffff; font-size:1.3vw; font-weight:bold; text-decoration:none; }
.menu a:hover { text-decoration:underline; }

/* 섹션 제목 */
.section-title {
  font-weight: bold;
  margin-bottom: 8px;
}

/* 좌우 그리드 레이아웃 */
.form-grid {
  display: grid;
  grid-template-columns: 1.1fr 0.9fr; /* 좌:1.1, 우:0.9 */
  gap: 20px;
}

/* 텍스트 입력 영역 */
.textarea-quote {
  width: 100%;
  height: 160px;
  resize: none;
  font-size: 16px;
  padding: 10px;
  box-sizing: border-box;
}

.input-speaker {
  width: 100%;
  padding: 8px;
  box-sizing: border-box;
}

/* 배경 이미지 목록 */
.bg-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  max-height: 360px;
  overflow-y: auto;
  border: 1px solid #ccc;
  padding: 8px;
  box-sizing: border-box;
}

.bg-item {
  display: inline-block;
  text-align: center;
  font-size: 11px;
}

.bg-item img {
  display: block;
  width: 90px;
  height: 90px;
  object-fit: cover;
  border-radius: 4px;
  border: 1px solid #ddd;
  margin-bottom: 4px;
}

/* 미리보기 영역 */
.preview-box {
  margin-top: 10px;
  text-align: center;
}
.preview-box img {
  max-width: 100%;
  max-height: 200px;
  border-radius: 6px;
  border: 1px solid #ccc;
}

/* 제출 버튼 */
.btn-area {
  margin-top: 20px;
  text-align: center;
}
.submit-btn {
  font-size: 16px;
  padding: 10px 28px;
  background: #000000;
  color: #ffffff;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}
.submit-btn:hover {
  background: #333333;
}

.footer a { color: #ffffff; text-decoration: none; }
.footer a:hover { text-decoration: underline; }
.footer-line { width: 90%; border-top: 1px solid #ffffff; margin: 10px auto 15px; }
a { text-decoration: none; }
  </style>
</head>
<body>

<!-- 헤더 -->
<div class="header">
  <a href="main.jsp" class="logo-link">
    <img src="resources/logo2.png" alt="TheQuoteBox" class="logo-image">
  </a>
  <div class="menu">
    <a href="todayQuote.jsp">오늘의 명언</a>
    <a href="quote.jsp">명언 만들기</a>
  </div>
</div>

<!-- 메인 폼 -->
<div class="container">
  <h2>명언 사진 생성하기 📸</h2>

  <!-- multipart/form-data로 processImage.jsp 전송 -->
  <form action="processImage.jsp" method="post" enctype="multipart/form-data">

    <div class="form-grid">
      <!-- 왼쪽: 명언 입력 -->
      <div>
        <div class="section-title">1️⃣ 쓰고 싶은 문장</div>
        <textarea name="quoteText" class="textarea-quote"
                  placeholder="이미지 중앙에 들어갈 문장을 입력하세요." required></textarea>

        <div class="section-title" style="margin-top:10px;">2️⃣ 화자</div>
        <input type="text" name="speaker" class="input-speaker"
               placeholder="예) 공자, 아인슈타인 등">
      </div>

      <!-- 오른쪽: 배경 이미지 선택 -->
      <div>
        <div class="section-title">3️⃣ 배경 사진 선택</div>
        <div class="bg-grid">
          <%
            // preset_backgrounds 폴더에서 이미지 파일 목록 동적 생성
            String realPath = application.getRealPath("/preset_backgrounds");
            File bgDir = new File(realPath);
            File[] files = bgDir.listFiles();
            String defaultName = "공자.jpg"; // 기본 선택 이미지
            
            if (files != null) {
                for (File f : files) {
                    if (!f.isFile()) continue;
                    String fileName = f.getName();
          %>
          <label class="bg-item">
            <input type="radio" name="preset" value="<%=fileName%>"
                   onclick="updatePreview('<%=fileName%>')"
                   <%= defaultName.equals(fileName) ? "checked" : "" %>>
            <img src="preset_backgrounds/<%=fileName%>" alt="<%=fileName%>">
            <span><%=fileName%></span>
          </label>
          <%
                }
            }
          %>
        </div>

        <!-- 실시간 배경 미리보기 -->
        <div class="preview-box">
          <div style="margin-bottom:4px;">배경 미리보기 🖼️</div>
          <img id="bgPreview" src="preset_backgrounds/<%=defaultName%>" alt="미리보기">
        </div>
      </div>
    </div>

    <div class="btn-area">
      <button type="submit" class="submit-btn">이미지 생성하기</button>
    </div>
  </form>
</div>

<!-- 푸터 -->
<div class="footer">
  <div>TheQuoteBox | 7조 | <strong>김민서</strong>, 김규환, 이민태</div>
  <div>
    Github: <a href="https://github.com/y202407042/jsp_pj" target="_blank">
      [https://github.com/y202407042/jsp_pj](https://github.com/y202407042/jsp_pj)
    </a>
  </div>
  <div>문의 : y202407042 | kingMintae | 202407038</div>
  <div>주소 : 경기도 부천시 경인로 590 (5407호)</div>
  <div class="footer-line"></div>
  <div>Copyleft © Team 7</div>
</div>

<!-- 배경 이미지 실시간 미리보기 JavaScript -->
<script>
  function updatePreview(fileName) {
    const img = document.getElementById('bgPreview');
    img.src = 'preset_backgrounds/' + fileName;
  }
</script>

</body>
</html>
