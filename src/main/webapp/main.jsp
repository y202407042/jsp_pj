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
    body { margin:0; padding:0; font-family: Arial, sans-serif; background:#ffffff; color:#000000; }
    .header { border:3px solid #000000; padding:20px; font-size:32px; font-weight:bold; position:relative; }
    .menu { position:absolute; top:20px; right:80px; font-size:1.3vw; display:flex; gap:2vw; }
    .container { border:3px solid #000000; padding:3vw; min-height:70vh; box-sizing:border-box; }
    .category-box { width:48%; height:200px; background:#000000; color:#ffffff; margin:1%; float:left; font-size:2vw; display:flex; justify-content:center; align-items:center; cursor:pointer; border-radius:8px; box-sizing:border-box; }
    .quote-box { clear:both; width:90%; height:15vh; background:#ffffff; margin:5vh auto; border-radius:8px; display:flex; justify-content:center; align-items:center; font-size:2vw; font-weight:bold; color:#000000; }
    .footer { border:3px solid #000000; padding:10px; text-align:center; font-size:14px; }
    a { text-decoration:none; color:black; }
  </style>
</head>
<body>
<div class="header">
  <a href="/jsp_pj/main.jsp"><img src="/jsp_pj/resources/logo.png" alt="TheQuoteBox" style="height:50px; cursor:pointer;"></a>
  <div class="menu">
    <a href="todayQuote.jsp">오늘의 명언</a>
    <a href="createQuote.jsp">명언 만들기</a>
  </div>
</div>

<div class="container">
  <a href="category.jsp?type=love"><div class="category-box">사랑</div></a>
  <a href="category.jsp?type=philosophy"><div class="category-box">철학</div></a>
  <a href="category.jsp?type=motivation"><div class="category-box">동기부여</div></a>
  <a href="category.jsp?type=life"><div class="category-box">삶</div></a>

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