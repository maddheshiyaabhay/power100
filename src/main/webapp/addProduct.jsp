<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp"/>

<div class="container my-5">
    <h2>Add New Product</h2>
    <form action="saveProduct.jsp" method="post">
        <div class="mb-3">
            <label>Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Category</label>
            <select name="category" class="form-control">
                <option>Cooler</option>
                <option>Smart TV</option>
                <option>Washing Machine</option>
            </select>
        </div>
        <div class="mb-3">
            <label>Price</label>
            <input type="number" name="price" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control"></textarea>
        </div>
        <div class="mb-3">
            <label>Image URL</label>
            <input type="text" name="image_url" class="form-control">
        </div>
        <button type="submit" class="btn btn-success">Save Product</button>
    </form>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>