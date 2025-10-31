<%@ page import="java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<html>
<head>
    <title>Your Cart </title>
    <!-- ========== FAVICON (replace with your Power100 small logo) ========== -->
              <!-- Save your favicon file as images/logo.png in project -->
              <link rel="icon" type="image/png" href="images/logo.png">
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fb; }
        h2 { text-align: center; color: #333; }
        table { width: 80%; margin: auto; border-collapse: collapse; background: white; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th, td { padding: 12px; text-align: center; border: 1px solid #ddd; }
        th { background: #007BFF; color: white; }
        tr:hover { background: #f1f1f1; }
        .btn-remove {
            color: white;
            background: red;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h2>Your Cart </h2>
    <table>
        <tr>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price (Rs)</th>
            <th>Action</th>
        </tr>
        <%
            Connection conn = (Connection) session.getAttribute("dbConn");
            if (conn != null) {
                int userId = 1; // fix user
                try {
                    PreparedStatement ps = conn.prepareStatement(
                        "SELECT c.id, p.name, c.quantity, p.price " +
                        "FROM cart c JOIN products p ON c.product_id = p.id " +
                        "WHERE c.user_id = ?"
                    );
                    ps.setInt(1, userId);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
        %>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getInt("quantity") %></td>
                            <td><%= rs.getDouble("price") %></td>
                            <td>
                                <a class="btn-remove" href="removeFromCart.jsp?id=<%= rs.getInt("id") %>">Remove</a>
                            </td>
                        </tr>
        <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                }
            } else {
                out.println("<tr><td colspan='4'>DB Connection Not Found!</td></tr>");
            }
        %>
    </table>
</body>
</html>