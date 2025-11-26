package com.example.jsp_pj.controller;

import com.example.jsp_pj.dao.QuoteDAO;
import com.example.jsp_pj.dto.QuoteDTO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/quote")
public class QuoteController extends HttpServlet {
    /// QuoteDAO 인스턴스 생성 (DB 접근)
    private final QuoteDAO dao = new QuoteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    /// 요청으로부터 카테고리 파라미터를 가져옴
        String category = req.getParameter("category");
        /// DAO를 통해 해당 카테고리의 명언 리스트 조회
        List<QuoteDTO> list = dao.getQuotesByCategory(category);

        /// JSP로 전달하기 위해 request에 데이터 저장
        req.setAttribute("quotes", list);
        RequestDispatcher rd = req.getRequestDispatcher("category.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        /// POST 요청의 한글 인코딩 처리
        req.setCharacterEncoding("UTF-8");

        /// 사용자가 입력한 명언 데이터를 DTO에 담기
        QuoteDTO dto = new QuoteDTO();
        dto.setContent(req.getParameter("content"));
        dto.setAuthor(req.getParameter("author"));
        dto.setCategory(req.getParameter("category"));
        /// DAO를 통해 명언 DB에 저장
        dao.insertQuote(dto);
    /// 저장 후 main.jsp로 리다이렉트
        resp.sendRedirect("main.jsp");
    }
}
