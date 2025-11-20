package com.example.jsp_pj.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/quote_db?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "minseo12280!!";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            System.out.println("DB 연결 실패: " + e.getMessage());
            return null;
        }
    }
}
