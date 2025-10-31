package com.power100.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL =
            "jdbc:mysql://localhost:3306/power100db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "power100user";
    private static final String DB_PASS = "p100pass";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "INSERT INTO users (fullname, email, password, phone) VALUES (?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, fullname);
                    ps.setString(2, email);
                    ps.setString(3, password);
                    ps.setString(4, phone);
                    ps.executeUpdate();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h3>Registration error: " + e.getMessage() + "</h3>");
        }
    }
}
