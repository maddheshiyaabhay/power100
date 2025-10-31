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
    <title>Admin - Manage Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background:#f8f9fa; font-family:'Segoe UI',sans-serif; }
        .admin-box { background:#fff; padding:20px; border-radius:12px; box-shadow:0 6px 15px rgba(0,0,0,0.15); }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container my-5">
    <h2 class="mb-4">⚙ Admin Panel - Manage Products</h2>

    <!-- Add New Product Button -->
    <a href="addProduct.jsp" class="btn btn-success mb-3">➕ Add New Product</a>

    <div class="admin-box">
        <table class="table table-bordered align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Rating</th>
                    <th>Reviews</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Connection conn = DBConnection.getConnection();
                    String sql = "SELECT * FROM products ORDER BY id DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();

                    while(rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("category") %></td>
                    <td>₹<%= rs.getDouble("price") %></td>
                    <td>⭐ <%= rs.getDouble("rating") %></td>
                    <td><%= rs.getInt("reviews") %></td>
                    <td>
                        <a href="editProduct.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-warning">✏ Edit</a>
                        <a href="deleteProduct.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">🗑 Delete</a>
                    </td>
                </tr>
            <%
                    }
                    conn.close();
                } catch(Exception e) {
                    out.print("<tr><td colspan='7' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>