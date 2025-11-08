<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>

<%
/*
  This file creates (or reuses) a single JDBC Connection using DBConnection.java
  and exposes it exactly where your pages expect it:
    - session attribute "dbConn"       -> java.sql.Connection
    - session attribute "dbConnError"  -> String (only when fail)
  DO NOT close this connection here; your util class manages the lifecycle.
*/
Connection con = null;
try {
    con = DBConnection.getConnection();     // reuse/open from util
    session.setAttribute("dbConn", con);    // <-- products.jsp reads this
    session.removeAttribute("dbConnError"); // clear old error if any

    // Optional debug in server logs (not shown to users)
    System.out.println("✅ [dbConnection.jsp] Connection ready");
} catch (Exception ex) {
    // Store error for pages that read it
    session.setAttribute("dbConn", null);
    session.setAttribute("dbConnError", ex.getMessage());

    // Same user-visible message your pages already show
    out.println("<div style='color:#b91c1c;background:#fee2e2;border:1px solid #fecaca;"
      + "padding:8px 12px;border-radius:8px;font-weight:600;'>"
      + "Database connection not found (Check dbConnection.jsp)"
      + "</div>");

    // Log full stack for debugging
    ex.printStackTrace();
}
%>