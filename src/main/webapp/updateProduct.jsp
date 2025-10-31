<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String category = request.getParameter("category");
    double price = Double.parseDouble(request.getParameter("price"));
    String description = request.getParameter("description");
    String image = request.getParameter("image_url");

    try {
        Connection conn = DBConnection.getConnection();
        String sql = "UPDATE products SET name=?, category=?, price=?, description=?, image_url=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, category);
        ps.setDouble(3, price);
        ps.setString(4, description);
        ps.setString(5, image);
        ps.setInt(6, id);
        ps.executeUpdate();
        conn.close();
        response.sendRedirect("adminProducts.jsp");
    } catch(Exception e) {
        out.print("Error: "+e.getMessage());
    }
%>