<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<%
    int orderId = Integer.parseInt(request.getParameter("order_id"));
    String status = request.getParameter("status");

    try {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE orders SET status=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, orderId);
        ps.executeUpdate();
        conn.close();

        // ✅ Wapas admin page par bhej do
        response.sendRedirect("adminOrders.jsp");

    } catch(Exception e) {
        out.print("<p style='color:red;'>Error: "+e.getMessage()+"</p>");
    }
%>