<%@ page import="java.sql.*, com.power100.util.DBConnection" %>

<%
try {
    // Get connection from DBConnection class
    Connection conn = DBConnection.getConnection();

    // Store connection in session
    session.setAttribute("dbConn", conn);

} catch (Exception e) {
    out.println("<div style='color:red;'>❌ Database Connection Error: " + e.getMessage() + "</div>");
}
%>