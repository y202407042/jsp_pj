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
    // MySQL 연결 정보 설정
    String url = "jdbc:mysql://localhost:3306/quote_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul";
    String user = "quote_user";   // DB 사용자 계정
    String password = "q1234";    // DB 사용자 비밀번호

    try {
        // MySQL JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // DB 연결 생성
        Connection conn = DriverManager.getConnection(url, user, password);

        // 연결 성공 메시지 출력
        System.out.println("<h2>MySQL 연결 성공! ✅</h2>");

        // 현재 연결된 데이터베이스 이름 확인
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT DATABASE()");
        if (rs.next()) {
            System.out.println("<p>현재 DB: <strong>" + rs.getString(1) + "</strong></p>");
        }

        // 리소스 정리 (ResultSet → Statement → Connection)
        rs.close();
        stmt.close();
        conn.close();
        
    } catch (ClassNotFoundException e) {
        // JDBC 드라이버 클래스 로드 실패
        System.out.println("<h2>MySQL JDBC 드라이버 로드 실패 😢</h2>");
        System.out.println("<p>mysql-connector-java.jar 파일이 classpath에 없습니다.</p>");
        e.printStackTrace();
        
    } catch (SQLException e) {
        // DB 연결/쿼리 실행 실패
        System.out.println("<h2>MySQL 연결 실패 😢</h2>");
        System.out.println("<p>오류: " + e.getMessage() + "</p>");
        e.printStackTrace(); // Tomcat 콘솔에 상세 로그 출력
        
    } catch (Exception e) {
        // 기타 예외
        System.out.println("<h2>예상치 못한 오류 발생 😢</h2>");
        System.out.println("<pre>" + e.getMessage() + "</pre>");
        e.printStackTrace();
    }
%>
</body>
</html>
