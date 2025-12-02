<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>명언 이미지 생성하기 - TheQuoteBox</title>
  <style>
body {
  margin: 0;
  padding: 0;
  font-family: "Malgun Gothic", Arial, sans-serif;
  background: #ffffff;
  color: #000000;
}

/* 공통 헤더/푸터는 main.jsp 그대로 */
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
  padding: 2vw 3vw;
  min-height: 70vh;
  box-sizing: border-box;
}

/* 좌: 명언 내용 / 화자, 우: 배경 이미지 */
.section-title {
  font-weight: bold;
  margin-bottom: 8px;
}

.form-grid {
  display: grid;
  grid-template-columns: 1.1fr 0.9fr;
  gap: 20px;
}

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

/* 비밀번호 */
.meta-row {
  margin-top: 12px;
  display: flex;
  gap: 20px;
  align-items: center;
  flex-wrap: wrap;
}
.meta-row label { margin-right: 4px; }

.pass-input {
  width: 80px;
  padding: 4px;
  text-align: center;
}

/* 배경 이미지 선택 */
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

/* 미리보기 */
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

/* 버튼 */
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
  <h2>명언 이미지 생성하기</h2>
  <form action="${pageContext.request.contextPath}/processImage.jsp"
        method="post"
        enctype="multipart/form-data">
    <div class="form-grid">
      <!-- 왼쪽: 명언 내용 / 화자 / 비번 -->
      <div>
        <div class="section-title">① 명언 내용</div>
        <textarea name="quoteText" class="textarea-quote"
                  placeholder="이미지 중앙에 들어갈 문장을 입력하세요." required></textarea>

        <div class="section-title" style="margin-top:10px;">② 화자</div>
        <input type="text" name="speaker" class="input-speaker"
               placeholder="예) 공자, 아인슈타인 등">

        <div class="meta-row">
          <div>
            <label for="passcode">비밀번호 (4자리 숫자)</label>
            <input type="password" id="passcode" name="passcode"
                   maxlength="4"
                   pattern="[0-9]{4}"
                   inputmode="numeric"
                   required
                   class="pass-input" placeholder="1234">
          </div>
        </div>
      </div>

      <!-- 오른쪽: 배경 이미지 선택 -->
      <div>
        <div class="section-title">③ 배경 사진 선택</div>
        <div class="bg-grid">
          <%
              String realPath = application.getRealPath("/preset_backgrounds");
              File bgDir = new File(realPath);
              File[] files = bgDir.listFiles();
              String defaultName = "공자.jpg"; // 있으면 기본 선택
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

        <div class="preview-box">
          <div style="margin-bottom:4px;">선택한 배경 미리보기</div>
          <img id="bgPreview" src="preset_backgrounds/<%=defaultName%>" alt="미리보기">
        </div>
      </div>
    </div>

    <div class="btn-area">
      <button type="submit" class="submit-btn">이미지 생성하기</button>
    </div>
  </form>
  
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

<script>
  function updatePreview(fileName) {
    const img = document.getElementById('bgPreview');
    img.src = 'preset_backgrounds/' + fileName;
  }
</script>

</body>
</html>
