<%@ page import="java.sql.*" %>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/power100db",
        "root",
        "12345"   // apna MySQL password
    );

    // Connection ko session me store kar diya
    session.setAttribute("dbConn", conn);

} catch (Exception e) {
    out.println("<div style='color:red;'>Database Connection Error: " + e.getMessage() + "</div>");
}
%>