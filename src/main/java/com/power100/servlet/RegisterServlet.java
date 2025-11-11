package com.power100.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // --------- IMPORTANT: Replace DB_PASS with the exact password from your Railway screenshot ----------
    // Host/port/db/user filled from your screenshot (common Railway proxy values)
    private static final String DB_URL =
        "jdbc:mysql://switchback-proxy.rly.net:35972/railway?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC&connectTimeout=5000";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "<KRxBCWRejXxXwYdbmHCwgMhSHPywxaUR>"; // <-- REPLACE THIS

    // -----------------------------------------------------------------------------------------------

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        // basic input validation (optional but helpful)
        if (fullname == null || fullname.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h3>Please fill required fields (fullname, email, password).</h3>");
            return;
        }

        try {
            // load driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // connect (this will use the DB_URL/DB_USER/DB_PASS above)
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // ensure table exists? (we assume you created it; see SQL below)
                String sql = "INSERT INTO users (fullname, email, password, phone) VALUES (?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, fullname);
                    ps.setString(2, email);
                    ps.setString(3, password);
                    ps.setString(4, phone);
                    ps.executeUpdate();
                }
            }

            // success -> redirect to login page
            resp.sendRedirect(req.getContextPath() + "/login.jsp");

        } catch (SQLException sqle) {
            // log full stacktrace to server logs (Railway deploy logs will show this)
            sqle.printStackTrace();
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h3>Registration SQL error: " + escapeHtml(sqle.getMessage()) + "</h3>");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h3>JDBC Driver missing: " + escapeHtml(cnfe.getMessage()) + "</h3>");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().println("<h3>Registration error: " + escapeHtml(e.getMessage()) + "</h3>");
        }
    }

    private String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;");
    }
}