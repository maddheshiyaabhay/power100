<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<%
if(session.getAttribute("adminName") == null){
  response.sendRedirect("adminLogin.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard - Power100</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card { border-radius: 15px; }
    .stat-card { transition: .3s; }
    .stat-card:hover { transform: translateY(-5px); box-shadow:0 6px 15px rgba(0,0,0,0.3);}
  </style>
</head>
<body class="bg-light">
<div class="container mt-4">
  <h2>Welcome, <%= session.getAttribute("adminName") %></h2>
  <div class="row mt-4">
    <%
      Connection conn = DBConnection.getConnection();
      Statement st = conn.createStatement();
      ResultSet rs;
      int totalOrders=0,totalProducts=0,totalUsers=0,totalChats=0;

      rs = st.executeQuery("SELECT COUNT(*) FROM orders"); if(rs.next()) totalOrders=rs.getInt(1);
      rs = st.executeQuery("SELECT COUNT(*) FROM products"); if(rs.next()) totalProducts=rs.getInt(1);
      rs = st.executeQuery("SELECT COUNT(*) FROM users"); if(rs.next()) totalUsers=rs.getInt(1);
      rs = st.executeQuery("SELECT COUNT(*) FROM chat_messages"); if(rs.next()) totalChats=rs.getInt(1);
      conn.close();
    %>
    <div class="col-md-3">
      <div class="card stat-card text-center p-3 bg-primary text-white">
        <h4><%= totalOrders %></h4>
        <p>Total Orders</p>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card text-center p-3 bg-success text-white">
        <h4><%= totalProducts %></h4>
        <p>Products</p>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card text-center p-3 bg-warning text-dark">
        <h4><%= totalUsers %></h4>
        <p>Users</p>
      </div>
    </div>
    <div class="col-md-3">
      <div class="card stat-card text-center p-3 bg-danger text-white">
        <h4><%= totalChats %></h4>
        <p>Chats</p>
      </div>
    </div>
  </div>

  <div class="mt-4">
    <a href="adminProducts.jsp" class="btn btn-outline-primary">Manage Products</a>
    <a href="adminOrders.jsp" class="btn btn-outline-success">Manage Orders</a>
    <a href="adminUsers.jsp" class="btn btn-outline-warning">Manage Users</a>
    <a href="adminChats.jsp" class="btn btn-outline-danger">Chat Messages</a>
    <a href="adminLogout.jsp" class="btn btn-dark float-end">Logout</a>
  </div>
</div>
</body>
</html>