<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>MySQL 연결 테스트</title>
</head>
<body>
<%
    String url = "jdbc:mysql://localhost:3306/quote_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
    String user = "quote_user";   // 만든 계정
    String password = "q1234";    // 만든 비번

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        out.println("<h2>MySQL 연결 성공!</h2>");

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT DATABASE()");
        if (rs.next()) {
            out.println("<p>현재 DB: " + rs.getString(1) + "</p>");
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<h2>MySQL 연결 실패 😢</h2>");
        out.println("<pre>" + e.getMessage() + "</pre>");

        // 서버 콘솔(Tomcat 로그)에 전체 스택 트레이스 출력
        e.printStackTrace();
    }
%>
</body>
</html>
