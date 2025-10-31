<%
    if(session.getAttribute("adminUser") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#f8f9fa; font-family:'Segoe UI',sans-serif; }
        .admin-box { background:#fff; padding:20px; border-radius:12px; box-shadow:0 6px 15px rgba(0,0,0,0.15); }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container my-5">
    <h2 class="mb-4">⚙ Admin Panel - Manage Orders</h2>
    <div class="admin-box">
        <table class="table table-bordered align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Order ID</th>
                    <th>User ID</th>
                    <th>Total Amount</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Change Status</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Connection conn = DBConnection.getConnection();
                    String sql = "SELECT * FROM orders ORDER BY order_date DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    boolean hasOrders = false;
                    while(rs.next()) {
                        hasOrders = true;
                        int orderId = rs.getInt("id");
                        int userId = rs.getInt("user_id");
                        double totalAmount = rs.getDouble("total_amount");
                        String status = rs.getString("status");
                        Timestamp orderDate = rs.getTimestamp("order_date");
            %>
                <tr>
                    <td><%= orderId %></td>
                    <td><%= userId %></td>
                    <td>₹<%= totalAmount %></td>
                    <td><%= orderDate %></td>
                    <td><span class="badge bg-<%= status.equals("Pending")?"warning":status.equals("Shipped")?"info":"success" %>"><%= status %></span></td>
                    <td>
                        <form action="updateOrderStatus.jsp" method="post" class="d-flex">
                            <input type="hidden" name="order_id" value="<%= orderId %>">
                            <select name="status" class="form-select form-select-sm me-2">
                                <option value="Pending" <%= status.equals("Pending")?"selected":"" %>>Pending</option>
                                <option value="Shipped" <%= status.equals("Shipped")?"selected":"" %>>Shipped</option>
                                <option value="Delivered" <%= status.equals("Delivered")?"selected":"" %>>Delivered</option>
                            </select>
                            <button type="submit" class="btn btn-sm btn-primary">Update</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                    if(!hasOrders) {
                        out.print("<tr><td colspan='6' class='text-center text-muted'>No orders found</td></tr>");
                    }
                    conn.close();
                } catch(Exception e) {
                    out.print("<tr><td colspan='6' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>