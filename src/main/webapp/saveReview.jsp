<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    int productId = Integer.parseInt(request.getParameter("product_id"));
    String fullname = request.getParameter("fullname");
    double rating = Double.parseDouble(request.getParameter("rating"));
    String review = request.getParameter("review");

    try {
        Connection conn = (Connection) session.getAttribute("dbConn");
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO reviews (product_id, fullname, rating, review) VALUES (?,?,?,?)"
        );
        ps.setInt(1, productId);
        ps.setString(2, fullname);
        ps.setDouble(3, rating);
        ps.setString(4, review);
        ps.executeUpdate();

        response.sendRedirect("productDetails.jsp?id=" + productId);
    } catch (Exception e) {
        out.println("Error submitting review: " + e.getMessage());
    }
%>