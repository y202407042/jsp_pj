<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>
<%
String[] quotes = {
	"“행운은 마음의 준비가 있는 사람에게만 미소를 짓는다.”",
	  "“사랑은 신뢰의 행위다, 믿으니까 믿는 것이다.”",
	  "“성공은 여러분이 얼마나 많은 것을 성취하느냐가 아니라 여러분이 얼마나 많은 것을 성취하도록 다른 사람들에게 영감을 주느냐에 달려 있다.”",
	  "“우리의 모든 꿈은 그것을 추구할 용기만 있다면 이루어진다.”",
	  "“강한 자가 살아남는 것이 아니라 살아남은 자가 강한 것이다.”",
	  "“인생에는 되감기 버튼이 없다.”",
	  "“고기는 씹을수록 맛이 난다. 그리고 책도 읽을수록 맛이 난다.”",
	  "“가장 중요한 것은 긍정적인 태도를 갖고 절대 포기하지 않는 것이다.”",
	  "“다른 사람의 꿈에 갇히지 마세요.”",
	  "“시간은 인간이 가장 공평하게 살아갈 수 있는 유일한 것이다.”",
	  "“내 인생에 문제가 생겼다고 안타까워하거나 슬퍼하지 마세요. 이것 또한 지나갑니다.”",
	  "“머리와 입으로 하는 사랑에는 향기가 없다. 진정한 사랑은 이해, 관용, 포용, 동화, 자기 낮춤이 선행된다.”",
	  "“운이 없다고 생각하니까 운이 나빠지는 것이다.”",
	  "“길을 모르면 길을 찾고, 길이 없으면 길을 닦아야 된다.”",
	  "“99도까지 열심히 올려놓아도 마지막 1도를 넘기지 못하면 영원히 물은 끓지 않는다.”",
	  "“잘 모르는 무식한 사람이 신념을 가지면 무섭습니다.”",
	  "“인생이 짐을 함부로 내려놓지 마라.”",
	  "“인생에 정답은 없어요. 선택만 있을 뿐.”",
	  "“다른 사람의 눈빛이나 태도로 내 행복을 결정할 필요는 없다.”",
	  "“웃음은 최고의 약입니다.”",
	  "“열심히 일하고 헌신하는 것도 중요하지만 잠시라도 시간을 내서 웃고 인생을 즐기는 것을 잊지 마세요.”",
	  "“즐겁게 하면 얼마나 좋겠어요.”",
	  "“행복은 선택이다.”",
	  "“삶은 스스로 만드는 것이다.”",
	  "“포기는 가장 빠른 실패다.”",
	  "“작은 변화가 큰 변화를 만든다.”",
	  "“자신을 믿어라.”",
	  "“실패는 배움의 시작이다.”",
	  "“고난은 성장의 기회다.”",
	  "“시간은 금이다.”",
	  "“도전 없는 성공은 없다.”",
	  "“희망은 절망 속에서도 빛난다.”",
	  "“배움에는 끝이 없다.”",
	  "“사랑은 최고의 힘이다.”",
	  "“긍정적인 생각이 인생을 변화시킨다.”",
	  "“꿈은 이루어진다.”",
	  "“책임을 져라.”",
	  "“인생은 단 한번 뿐이다.”",
	  "“나 자신을 사랑하라.”",
	  "“감사는 행복의 시작이다.”",
	  "“성공은 준비된 자에게 온다.”",
	  "“미래는 오늘의 결과다.”",
	  "“기회는 준비된 자에게 온다.”",
	  "“결심이 모든 것이다.”",
	  "“인내는 쓰지만 그 열매는 달다.”",
	  "“희생 없이는 성취 없다.”",
	  "“나아가는 자가 승리한다.”",
	  "“용기는 두려움을 극복하는 힘이다.”",
	  "“변화는 성장의 첫 단계다.”",
	  "“행동이 변화의 열쇠다.”"
};
Random random = new Random();
int index = random.nextInt(quotes.length);
String randomQuote = quotes[index];
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>오늘의 명언 - TheQuoteBox</title>
  <style>
@font-face {
  font-family: 'MaruBuri';
  src: url('resources/fonts/MaruBuri-Regular.ttf') format('truetype');
  font-weight: 400;
}
@font-face {
  font-family: 'MaruBuri';
  src: url('resources/fonts/MaruBuri-Bold.ttf') format('truetype');
  font-weight: 700;
}
html, body {
  height: 100%;
  margin: 0;
  padding: 0;
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
.logo-link { display:flex; align-items:center; height:100%; }
.logo-image { height:80px; width:auto; display:block; }
.menu { display:flex; gap:2vw; }
.menu a { color:#ffffff; font-size:1.3vw; font-weight:bold; text-decoration:none; }
.menu a:hover { text-decoration:underline; }
.container {
  border: 3px solid #000000;
  padding: 3vw;
  min-height: 100vh;
  box-sizing: border-box;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}
.quote-box {
  font-family: 'MaruBuri', 'Nanum Gothic', 'Noto Sans KR', sans-serif;
  font-size: 4vw;
  font-weight: 700;
  width: 90%;
  background: #ffffff;
  border-radius: 8px;
  color: #000000;
  padding: 30px;
  box-sizing: border-box;
  text-align: center; 
}
.footer {
  border: 3px solid #000000;
  padding: 10px;
  text-align: center;
  font-size: 14px;
  background-color: #000000;
  color: #ffffff;
}
a { text-decoration:none; }
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
  <div class="quote-box" id="quoteBox">
    <%= randomQuote %>
  </div>
  <div style="text-align:center; margin-top: 50px;">
    <img src="resources/copy.png" alt="복사" id="copyButton"
         style="cursor:pointer; width:40px; height:40px; vertical-align:middle;" title="명언 복사">
    <form action="todayQuote.jsp" method="get" style="display:inline-block; margin-left: 15px;">
      <button type="submit" style="font-size: 2.5rem; border: none; background: none; cursor: pointer; vertical-align:middle;" title="다시 뽑기">
        🔁
      </button>
    </form>
  </div>
</div>

<div class="footer">
  Made by 김규환 김민서 이민태
</div>

<script>
document.getElementById('copyButton').addEventListener('click', function() {
  const text = document.getElementById('quoteBox').innerText;
  navigator.clipboard.writeText(text).then(() => {
    alert('명언이 복사되었습니다!');
  }).catch(err => {
    alert('복사 실패: ' + err);
  });
});
</script>
</body>
</html>
