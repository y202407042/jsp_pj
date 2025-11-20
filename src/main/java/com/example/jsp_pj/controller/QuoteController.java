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

    private final QuoteDAO dao = new QuoteDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String category = req.getParameter("category");
        List<QuoteDTO> list = dao.getQuotesByCategory(category);

        req.setAttribute("quotes", list);
        RequestDispatcher rd = req.getRequestDispatcher("category.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        QuoteDTO dto = new QuoteDTO();
        dto.setContent(req.getParameter("content"));
        dto.setAuthor(req.getParameter("author"));
        dto.setCategory(req.getParameter("category"));

        dao.insertQuote(dto);

        resp.sendRedirect("main.jsp");
    }
}
