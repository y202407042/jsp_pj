package com.example.jsp_pj.dao;

import com.example.jsp_pj.dto.QuoteDTO;
import com.example.jsp_pj.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QuoteDAO {
    public List<QuoteDTO> getQuotesByCategory(String category) {
        List<QuoteDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM quotes WHERE category = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();

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

    public int insertQuote(QuoteDTO dto) {
        String sql = "INSERT INTO quotes(content, author, category) VALUES(?,?,?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getContent());
            pstmt.setString(2, dto.getAuthor());
            pstmt.setString(3, dto.getCategory());

            return pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("명언 등록 오류: " + e.getMessage());
            return 0;
        }
    }
}
