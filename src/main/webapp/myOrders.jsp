<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<html>
<head>
    <title>My Orders</title>
      <!-- ========== FAVICON (replace with your Power100 small logo) ========== -->
           <!-- Save your favicon file as images/logo.png in project -->
           <link rel="icon" type="image/png" href="images/logo.png">
    <!-- ✅ Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <!-- ✅ Latest FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            font-family: 'Segoe UI', sans-serif;
        }
        h2 {
            color: #007bff;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
            font-weight: 700;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        .table th {
            background: #007bff;
            color: white;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 1px;
        }
        .table td {
            vertical-align: middle;
            font-size: 15px;
        }
        .btn-invoice {
            background: #ff4757;
            color: #fff;
            border-radius: 20px;
            padding: 6px 14px;
            font-size: 14px;
            transition: 0.3s;
        }
        .btn-invoice:hover {
            background: #e84118;
            transform: scale(1.05);
        }
        .icon {
            color: #007bff;
            margin-right: 5px;
        }
    </style>
</head>
<body class="container mt-5">

    <div class="card p-4">
        <h2><i class="fa-solid fa-box icon"></i>My Orders</h2>
        <hr>

        <table class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th><i class="fa-solid fa-user"></i> Customer Name</th>
                    <th><i class="fa-solid fa-list"></i> Items</th>
                    <th><i class="fa-solid fa-indian-rupee-sign"></i> Total Amount</th>
                    <th><i class="fa-solid fa-calendar-days"></i> Order Date</th>
                    <th><i class="fa-solid fa-file-pdf"></i> Invoice</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection conn = DBConnection.getConnection();

                        String query = "SELECT o.id, o.total_amount, o.order_date, u.fullname " +
                                       "FROM orders o " +
                                       "JOIN users u ON o.user_id = u.id";

                        PreparedStatement ps = conn.prepareStatement(query);
                        ResultSet rs = ps.executeQuery();
                        int count = 1;

                        while (rs.next()) {
                %>
                            <tr>
                                <td><%= count++ %></td>
                                <td><%= rs.getString("fullname") %></td>
                                <td>3 Items</td> <!-- Future: join order_items for real count -->
                                <td>₹ <%= rs.getDouble("total_amount") %></td>
                                <td><%= rs.getTimestamp("order_date") %></td>
                                <td>
                                    <a href="downloadInvoice?orderId=<%= rs.getInt("id") %>"
                                       class="btn btn-invoice">
                                       <i class="fa-solid fa-download"></i> Download
                                    </a>
                                </td>
                            </tr>
                <%
                        }

                        rs.close();
                        ps.close();
                        conn.close();

                    } catch (Exception e) {
                        out.print("<tr><td colspan='6' class='text-danger'>Error fetching orders: " + e.getMessage() + "</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- ✅ Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>