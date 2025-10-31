<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f1f3f6; font-family: 'Segoe UI', sans-serif; }
        .order-card {
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 25px;
            transition: 0.3s;
        }
        .order-card:hover { transform: scale(1.01); box-shadow: 0 20px 40px rgba(0,0,0,0.2); }
        .order-header { border-bottom: 2px solid #eee; margin-bottom: 15px; padding-bottom: 10px; }
        .badge-status { font-size: 0.85rem; padding: 6px 12px; }
        .btn-sm { border-radius: 20px; }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container mt-5">
    <h2><i class="fa fa-box text-success"></i> My Orders</h2>

    <%
        Connection conn = null;
        PreparedStatement ps = null, ps2 = null, ps3 = null;
        ResultSet rs = null, rs2 = null, rs3 = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement("SELECT * FROM orders ORDER BY created_at DESC");
            rs = ps.executeQuery();

            boolean hasOrders = false;
            while(rs.next()) {
                hasOrders = true;
                int orderId = rs.getInt("id");
                String status = rs.getString("status");
    %>

    <div class="order-card">
        <!-- Order Header -->
        <div class="order-header d-flex justify-content-between align-items-center">
            <h5>Order #<%= orderId %> </h5>
            <span class="badge
                <%= status.equals("Pending") ? "bg-warning text-dark" :
                    status.equals("Shipped") ? "bg-info text-dark" :
                    status.equals("Delivered") ? "bg-success" :
                    "bg-danger" %> badge-status">
                <%= status %>
            </span>
        </div>

        <!-- Order Info -->
        <p><b>Total:</b> ₹<%= rs.getDouble("total_amount") %></p>
        <p><b>Date:</b> <%= rs.getTimestamp("created_at") %></p>

        <!-- Shipping Address -->
        <%
            ps2 = conn.prepareStatement("SELECT * FROM order_address WHERE order_id=?");
            ps2.setInt(1, orderId);
            rs2 = ps2.executeQuery();
            if(rs2.next()) {
        %>
            <h6><i class="fa fa-map-marker-alt text-danger"></i> Shipping Address</h6>
            <p>
                <b><%= rs2.getString("fullname") %></b> (<%= rs2.getString("phone") %>)<br>
                <%= rs2.getString("address") %>,
                <%= rs2.getString("city") %>,
                <%= rs2.getString("state") %> -
                <%= rs2.getString("pincode") %>
            </p>
        <%
            }
            rs2.close(); ps2.close();
        %>

        <!-- Order Items -->
        <h6><i class="fa fa-list text-primary"></i> Items</h6>
        <ul>
            <%
                ps3 = conn.prepareStatement("SELECT oi.quantity, oi.price, p.name FROM order_items oi JOIN products p ON oi.product_id=p.id WHERE oi.order_id=?");
                ps3.setInt(1, orderId);
                rs3 = ps3.executeQuery();
                while(rs3.next()) {
            %>
                <li><%= rs3.getString("name") %> - <%= rs3.getInt("quantity") %> x ₹<%= rs3.getDouble("price") %></li>
            <%
                }
                rs3.close(); ps3.close();
            %>
        </ul>

        <!-- Action Buttons -->
        <div class="mt-3">
            <form action="trackOrder.jsp" method="get" style="display:inline;">
                <input type="hidden" name="orderId" value="<%= orderId %>">
                <button class="btn btn-info btn-sm"><i class="fa fa-truck"></i> Track Order</button>
            </form>
            <% if(status.equals("Pending")) { %>
                <form action="cancelOrder.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <button class="btn btn-danger btn-sm"><i class="fa fa-times"></i> Cancel Order</button>
                </form>
            <% } %>
        </div>
    </div>

    <%
            }
            if(!hasOrders){
                out.print("<p class='alert alert-warning'>No orders found.</p>");
            }
        } catch(Exception e) {
            out.print("<p>Error: "+e.getMessage()+"</p>");
        } finally {
            if(rs!=null) rs.close();
            if(ps!=null) ps.close();
            if(conn!=null) conn.close();
        }
    %>
</div>

<jsp:include page="footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>