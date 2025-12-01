package com.example.jsp_pj.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/quote_db?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "quote_user";
    private static final String PASSWORD = "q1234";

    // DB 연결 메서드
    public static Connection getConnection() throws SQLException {
        try {
            // MySQL 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC 드라이버 로드 실패");
            e.printStackTrace();
        }

        // DB 연결 반환
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
