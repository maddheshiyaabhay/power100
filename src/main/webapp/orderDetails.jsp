<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Order Details - Power100</title>
   <!-- ========== FAVICON (replace with your Power100 small logo) ========== -->
        <!-- Save your favicon file as images/logo.png in project -->
        <link rel="icon" type="image/png" href="images/logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container mt-5">
  <h2><i class="fa fa-receipt"></i> Order Details</h2>
  <hr>

  <%
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    Connection conn=null; PreparedStatement ps=null,ps2=null,ps3=null;
    ResultSet rs=null,rs2=null,rs3=null;

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/power100db","root","root");

      ps = conn.prepareStatement("SELECT * FROM orders WHERE id=?");
      ps.setInt(1,orderId);
      rs = ps.executeQuery();
      if(rs.next()){
  %>
    <div class="card mb-4 shadow">
      <div class="card-header bg-primary text-white">Order #<%=orderId%></div>
      <div class="card-body">
        <p><b>Status:</b> <%=rs.getString("status")%></p>
        <p><b>Total Amount:</b> ₹<%=rs.getDouble("total_amount")%></p>
        <p><b>Order Date:</b> <%=rs.getTimestamp("created_at")%></p>
        <a href="invoice.jsp?orderId=<%=orderId%>" class="btn btn-success">
          <i class="fa fa-file-pdf"></i> Download Invoice (PDF)
        </a>
      </div>
    </div>

    <h4>Products</h4>
    <table class="table table-bordered">
      <thead class="table-dark">
        <tr><th>Product</th><th>Qty</th><th>Price</th></tr>
      </thead>
      <tbody>
      <%
        ps2 = conn.prepareStatement("SELECT p.name, oi.quantity, oi.price FROM order_items oi JOIN products p ON oi.product_id=p.id WHERE oi.order_id=?");
        ps2.setInt(1,orderId); rs2 = ps2.executeQuery();
        while(rs2.next()){
      %>
        <tr>
          <td><%=rs2.getString("name")%></td>
          <td><%=rs2.getInt("quantity")%></td>
          <td>₹<%=rs2.getDouble("price")%></td>
        </tr>
      <% } %>
      </tbody>
    </table>

    <h4>Shipping Address</h4>
    <%
      ps3 = conn.prepareStatement("SELECT * FROM order_address WHERE order_id=?");
      ps3.setInt(1,orderId); rs3 = ps3.executeQuery();
      if(rs3.next()){
    %>
      <p><b>Name:</b> <%=rs3.getString("fullname")%></p>
      <p><b>Phone:</b> <%=rs3.getString("phone")%></p>
      <p><b>Address:</b> <%=rs3.getString("address")%>, <%=rs3.getString("city")%>, <%=rs3.getString("state")%> - <%=rs3.getString("pincode")%></p>
    <% } %>

  <% } else { out.println("<div class='alert alert-danger'>Order not found!</div>"); }
    } catch(Exception e){ out.println(e); }
    finally{ if(rs!=null)rs.close(); if(ps!=null)ps.close(); if(conn!=null)conn.close(); }
  %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>