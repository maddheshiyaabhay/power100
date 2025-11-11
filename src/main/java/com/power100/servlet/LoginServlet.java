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

    // ----- Read Railway env vars with local fallbacks -----
    private static String env(String k, String def) {
        String v = System.getenv(k);
        return (v == null || v.isEmpty()) ? def : v;
    }

    private static final String DB_HOST = env("MYSQLHOST", "switchback.proxy.rlwy.net");
    private static final String DB_PORT = env("MYSQLPORT", "35972");
    private static final String DB_NAME = env("MYSQL_DATABASE", "railway");
    private static final String DB_USER = env("MYSQLUSER", "root");
    private static final String DB_PASS = env("MYSQLPASSWORD", "KRxBCWRejXxXwYdbmHCwgMhSHPywxaUR"); // <-- apna Railway password

    // MySQL 8 URL (Railway proxy needs SSL)
    private static final String DB_URL =
            "jdbc:mysql://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME
            + "?allowPublicKeyRetrieval=true&useSSL=true&serverTimezone=UTC&connectTimeout=5000";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Please enter email and password");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                String sql = "SELECT id, fullname, email FROM users WHERE email = ? AND password = ? LIMIT 1";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, email.trim());
                    ps.setString(2, password);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            HttpSession session = req.getSession(true);
                            session.setAttribute("userId", rs.getInt("id"));
                            session.setAttribute("userName", rs.getString("fullname"));
                            session.setAttribute("userEmail", rs.getString("email"));
                            session.setMaxInactiveInterval(30 * 60); // 30 min

                            resp.sendRedirect(req.getContextPath() + "/index.jsp");
                        } else {
                            req.setAttribute("error", "Invalid email or password");
                            req.getRequestDispatcher("/login.jsp").forward(req, resp);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Login error: " + e.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}