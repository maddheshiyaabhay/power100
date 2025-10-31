<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    try {
        Connection conn = DBConnection.getConnection();
        String sql = "DELETE FROM products WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
        conn.close();
        response.sendRedirect("adminProducts.jsp");
    } catch(Exception e) {
        out.print("Error: "+e.getMessage());
    }
%>