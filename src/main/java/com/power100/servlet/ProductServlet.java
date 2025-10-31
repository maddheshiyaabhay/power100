package com.power100.servlet;

import com.power100.util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {

            out.println("<h2>Product List</h2>");
            out.println("<table border='1'><tr><th>ID</th><th>Name</th><th>Price</th><th>Description</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<td>" + rs.getDouble("price") + "</td>");
                out.println("<td>" + rs.getString("description") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}