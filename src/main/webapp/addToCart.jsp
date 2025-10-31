<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    Connection conn = (Connection) session.getAttribute("dbConn");

    if (conn == null) {
        out.println("DB Connection not available!");
    } else {
        int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = 1;  // default 1 rakha hai
        int userId = 1;    // abhi ke liye fix user id 1

        try {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)"
            );
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);

            ps.executeUpdate();
            response.sendRedirect("cart.jsp");
        } catch (Exception e) {
            out.println("Error adding to cart: " + e.getMessage());
        }
    }
%>