package com.example.jsp_pj.dao;

import com.example.jsp_pj.dto.QuoteDTO;
import com.example.jsp_pj.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuoteDAO {
    // 주어진 카테고리에 해당하는 명언 목록을 DB에서 조회
    public List<QuoteDTO> getQuotesByCategory(String category) {
        List<QuoteDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM quotes WHERE category = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            // SQL 실행 후 결과(ResultSet) 받기
            ResultSet rs = pstmt.executeQuery();
            // 결과를 하나씩 꺼내서 DTO 객체로 만들어 리스트에 추가
            while (rs.next()) {
                list.add(new QuoteDTO(
                        rs.getInt("id"),
                        rs.getString("content"),
                        rs.getString("author"),
                        rs.getString("category")
                ));
            }
        } catch (Exception e) {
            System.out.println("카테고리 조회 오류: " + e.getMessage());
        }
        return list;
    }

    // 명언을 DB에 등록하는 메서드
    public int insertQuote(QuoteDTO dto) {
        String sql = "INSERT INTO quotes(content, author, category) VALUES(?,?,?)";
        // DB 연결 및 SQL 준비
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
        // 각각 content, author, category 값을 SQL에 바인딩
            pstmt.setString(1, dto.getContent());
            pstmt.setString(2, dto.getAuthor());
            pstmt.setString(3, dto.getCategory());
    // INSERT 실행 후 영향받은 행 수 반환(1이면 성공)
            return pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("명언 등록 오류: " + e.getMessage());
            return 0;
        }
    }
}
