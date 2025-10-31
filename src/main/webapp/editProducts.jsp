<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE id=?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp"/>

<div class="container my-5">
    <h2>Edit Product</h2>
    <form action="updateProduct.jsp" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" value="<%= rs.getString("name") %>" class="form-control">
        </div>
        <div class="mb-3">
            <label>Category</label>
            <input type="text" name="category" value="<%= rs.getString("category") %>" class="form-control">
        </div>
        <div class="mb-3">
            <label>Price</label>
            <input type="number" name="price" value="<%= rs.getDouble("price") %>" class="form-control">
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control"><%= rs.getString("description") %></textarea>
        </div>
        <div class="mb-3">
            <label>Image URL</label>
            <input type="text" name="image_url" value="<%= rs.getString("image_url") %>" class="form-control">
        </div>
        <button type="submit" class="btn btn-warning">Update Product</button>
    </form>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>
<%
    conn.close();
%>