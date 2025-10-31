package com.power100.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL =
            "jdbc:mysql://localhost:3306/power100db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    private static final String DB_USER = "power100user";
    private static final String DB_PASS = "p100pass";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "SELECT id, fullname FROM users WHERE email = ? AND password = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, email);
                    ps.setString(2, password);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            int userId = rs.getInt("id");
                            String fullname = rs.getString("fullname");
                            HttpSession session = req.getSession();
                            session.setAttribute("userId", userId);
                            session.setAttribute("userName", fullname);
                            // login success -> redirect to index or user dashboard
                            resp.sendRedirect(req.getContextPath() + "/index.jsp");
                            return;
                        } else {
                            // invalid credentials
                            req.setAttribute("error", "Invalid email or password");
                            req.getRequestDispatcher("/login.jsp").forward(req, resp);
                            return;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("Login error: " + e.getMessage());
        }
    }
}
