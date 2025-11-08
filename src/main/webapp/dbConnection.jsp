<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>

<%
Connection con = null;
try {
    // 🔗 Connect using Java backend class
    con = DBConnection.getConnection();

    if (con != null && !con.isClosed()) {
        // ✅ Successfully connected (debug message optional)
        System.out.println("✅ [dbConnection.jsp] Database Connected Successfully!");
    } else {
        out.println("<div style='color:red;font-weight:bold;'>❌ Database connection failed (connection is null)</div>");
    }

} catch (Exception e) {
    // ❌ Agar connection me koi error aaye to message dikhao
    out.println("<div style='color:red;font-weight:bold;'>❌ Database connection not found: "
                + e.getMessage() + "</div>");
    e.printStackTrace();
}
%>