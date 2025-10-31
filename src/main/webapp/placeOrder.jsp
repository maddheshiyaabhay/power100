<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<%@ page import="java.util.*" %>

<%
    String fullname = request.getParameter("fullname");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String pincode = request.getParameter("pincode");
    String payment = request.getParameter("payment"); // future use

    Connection conn = null;
    PreparedStatement ps = null, ps2 = null, ps3 = null, ps4 = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();
        conn.setAutoCommit(false);

        // ⚡ User fix: Static user_id = 1 (jab tak login system nahi banate)
        int userId = 1;

        // 1️⃣ Calculate total amount from cart
        double subtotal = 0.0;
        ps = conn.prepareStatement("SELECT c.product_id, c.quantity, p.price FROM cart c JOIN products p ON c.product_id = p.id WHERE c.user_id=?");
        ps.setInt(1, userId);
        rs = ps.executeQuery();
        while (rs.next()) {
            subtotal += rs.getInt("quantity") * rs.getDouble("price");
        }
        rs.close(); ps.close();

        double total = subtotal * 1.05; // tax 5%

        // 2️⃣ Insert into orders
        ps2 = conn.prepareStatement("INSERT INTO orders(user_id, total_amount, status) VALUES (?,?,?)", Statement.RETURN_GENERATED_KEYS);
        ps2.setInt(1, userId);
        ps2.setDouble(2, total);
        ps2.setString(3, "pending");
        ps2.executeUpdate();

        rs = ps2.getGeneratedKeys();
        int orderId = 0;
        if (rs.next()) {
            orderId = rs.getInt(1);
        }
        rs.close(); ps2.close();

        // 3️⃣ Insert order items
        ps3 = conn.prepareStatement("SELECT c.product_id, c.quantity, p.price FROM cart c JOIN products p ON c.product_id=p.id WHERE c.user_id=?");
        ps3.setInt(1, userId);
        rs = ps3.executeQuery();
        ps4 = conn.prepareStatement("INSERT INTO order_items(order_id, product_id, quantity, price) VALUES (?,?,?,?)");
        while (rs.next()) {
            ps4.setInt(1, orderId);
            ps4.setInt(2, rs.getInt("product_id"));
            ps4.setInt(3, rs.getInt("quantity"));
            ps4.setDouble(4, rs.getDouble("price"));
            ps4.executeUpdate();
        }
        rs.close(); ps3.close(); ps4.close();

        // 4️⃣ Insert address
        ps = conn.prepareStatement("INSERT INTO order_address(order_id, fullname, phone, address, city, state, pincode) VALUES (?,?,?,?,?,?,?)");
        ps.setInt(1, orderId);
        ps.setString(2, fullname);
        ps.setString(3, phone);
        ps.setString(4, address);
        ps.setString(5, city);
        ps.setString(6, state);
        ps.setString(7, pincode);
        ps.executeUpdate();
        ps.close();

        // 5️⃣ Empty cart
        ps = conn.prepareStatement("DELETE FROM cart WHERE user_id=?");
        ps.setInt(1, userId);
        ps.executeUpdate();
        ps.close();

        conn.commit();
        response.sendRedirect("myOrders.jsp?success=1");

    } catch (Exception e) {
        if (conn != null) conn.rollback();
        out.print("<p>Error placing order: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (ps2 != null) ps2.close();
        if (ps3 != null) ps3.close();
        if (ps4 != null) ps4.close();
        if (conn != null) conn.close();
    }
%>