<%@ page import="java.sql.*" %>
<%
/*
  dbConnection.jsp
  - Uses environment variables set on Render (recommended):
      JDBC_URL, JDBC_USER, JDBC_PASS
  - If not found, falls back to local values for testing only.
*/

String jdbcUrl = System.getenv("JDBC_URL");
String dbUser  = System.getenv("JDBC_USER");
String dbPass  = System.getenv("JDBC_PASS");

// If JDBC_URL not provided, try host/port/db env vars (Railway style)
if (jdbcUrl == null || jdbcUrl.trim().isEmpty()) {
    String host = System.getenv("MYSQLHOST");
    String port = System.getenv("MYSQLPORT");
    String db   = System.getenv("MYSQLDATABASE");
    String user = System.getenv("MYSQLUSER");
    String pass = System.getenv("MYSQLPASSWORD");

    if (host != null && !host.trim().isEmpty()) {
        if (port == null || port.trim().isEmpty()) port = "3306";
        if (db == null || db.trim().isEmpty()) db = "railway";
        jdbcUrl = "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&serverTimezone=UTC";
        dbUser = (dbUser == null || dbUser.trim().isEmpty()) ? user : dbUser;
        dbPass = (dbPass == null || dbPass.trim().isEmpty()) ? pass : dbPass;
    }
}

// FINAL fallback for local dev ONLY (do NOT push secrets)
if (jdbcUrl == null || jdbcUrl.trim().isEmpty()) {
    jdbcUrl = "jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&serverTimezone=UTC";
    dbUser  = (dbUser == null || dbUser.trim().isEmpty()) ? "root" : dbUser;
    dbPass  = (dbPass == null) ? "DHiyvWtdZKvdUmqkKKLNLCpXTkPPsDCC" : dbPass; // only local test
}

out.println("<div style='font-family:Arial,sans-serif;'>");
out.println("<h3>DB Connection Test</h3>");
out.println("<p>Using JDBC URL: <code>" + (jdbcUrl.length() > 200 ? jdbcUrl.substring(0,200) + "..." : jdbcUrl) + "</code></p>");

Connection conn = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
    out.println("<p style='color:green;'>✅ Database Connected Successfully!</p>");
} catch (Throwable e) {
    out.println("<p style='color:red;'>❌ Database Connection Error:</p>");
    out.println("<pre>" + e.getMessage() + "</pre>");
} finally {
    if (conn != null) {
        try { conn.close(); } catch (Exception ignore) {}
    }
}
out.println("</div>");
%>