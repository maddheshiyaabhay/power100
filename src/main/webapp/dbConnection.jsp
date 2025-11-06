<%@ page import="java.sql.*, com.power100.util.DBConnection" %>
<%
    try {
        // Get connection from DBConnection class
        Connection conn = DBConnection.getConnection();

        if (conn != null && !conn.isClosed()) {
            out.println("<div style='color:green; font-weight:bold;'>✅ Database Connected Successfully!</div>");
        } else {
            out.println("<div style='color:red; font-weight:bold;'>❌ Connection object is null or closed.</div>");
        }

    } catch (Exception e) {
        out.println("<div style='color:red; font-weight:bold;'>❌ Database Connection Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    }
%>