<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>

<%
/*
  dbConnection.jsp
  - Uses environment vars (recommended on Railway/Render):
      JDBC_URL, JDBC_USER, JDBC_PASS
  - Falls back to local values for testing only (do not commit secrets)
*/

// read from environment (Railway/Render: you MUST set these in project variables)
String jdbcUrl  = System.getenv("JDBC_URL");
String jdbcUser = System.getenv("JDBC_USER");
String jdbcPass = System.getenv("JDBC_PASS");

// LOCAL fallback for testing only (if env not set). Replace DB name / host/port as needed.
// For testing locally you can change password here to "12345" temporarily (but don't commit).
if (jdbcUrl == null || jdbcUrl.trim().isEmpty()) {
    // Example local fallback:
    jdbcUrl  = "jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&serverTimezone=UTC";
    jdbcUser = (jdbcUser == null || jdbcUser.trim().isEmpty()) ? "root" : jdbcUser;
    jdbcPass = (jdbcPass == null || jdbcPass.trim().isEmpty()) ? "DHiyvWtdZKvdUmqkKKLNLCpXTkPPsDCC" : jdbcPass;
}

// get connection from session (reuse if already created)
Connection dbConn = null;
try {
    Object attr = session.getAttribute("dbConn");
    if (attr instanceof Connection) {
        dbConn = (Connection) attr;
        try {
            if (dbConn.isClosed()) dbConn = null;
        } catch (Exception ignore) { dbConn = null; }
    }

    if (dbConn == null) {
        // load driver (newer mysql driver class)
        Class.forName("com.mysql.cj.jdbc.Driver");
        dbConn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);

        // store in session for reuse across JSPs (so you don't re-open many connections)
        session.setAttribute("dbConn", dbConn);
    }
} catch (Exception e) {
    // show friendly error so you can debug on Render/Railway logs or browser during dev
    out.println("<div style='color:#c00; font-family: monospace; white-space: pre-wrap;'>");
    out.println("DB Connection Error: " + e.getClass().getName() + " - " + e.getMessage());
    out.println("</div>");
    // Also print full stack if you need (comment out on production)
    // e.printStackTrace(new java.io.PrintWriter(out));
}
%>