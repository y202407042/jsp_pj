package com.example.jsp_pj.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    /// MySQL 접속 URL
    private static final String URL = "jdbc:mysql://localhost:3306/quote_db?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "minseo12280!!";

    /// DB 연결을 생성하여 반환하는 메서드
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            /// DB 연결 후 Connection 객체 반환
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) { /// 연결 실패 시 로그 출력
            System.out.println("DB 연결 실패: " + e.getMessage());
            return null;
        }
    }
}
