<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    Connection conn = (Connection) session.getAttribute("dbConn");
    if (conn != null) {
        int cartId = Integer.parseInt(request.getParameter("id"));
        try {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM cart WHERE id=?");
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (Exception e) {
            out.println("Error removing: " + e.getMessage());
        }
    }
    response.sendRedirect("cart.jsp");
%>