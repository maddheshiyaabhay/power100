<%@ page import="java.sql.*" %>
<%
    String productId = request.getParameter("product_id");
    String name = request.getParameter("customer_name");
    String rating = request.getParameter("rating");
    String review = request.getParameter("review");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/power100db", "root", "12345");

        PreparedStatement ps = con.prepareStatement("INSERT INTO reviews (product_id, customer_name, rating, review) VALUES (?, ?, ?, ?)");
        ps.setInt(1, Integer.parseInt(productId));
        ps.setString(2, name);
        ps.setDouble(3, Double.parseDouble(rating));
        ps.setString(4, review);

        ps.executeUpdate();
        con.close();

        response.sendRedirect("productDetails.jsp?id=" + productId);
    } catch(Exception e) {
        out.println("Error saving review: " + e.getMessage());
    }
%>