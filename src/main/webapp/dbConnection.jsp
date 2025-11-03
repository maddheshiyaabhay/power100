<%@ page import="java.sql.*" %>
<%
/*
  dbConnection.jsp
  - Reads DB details from environment variables:
      JDBC_URL, JDBC_USER, JDBC_PASS
  - If not present, tries Railway-style host/port/database env vars:
      MYSQLHOST, MYSQLPORT, MYSQLDATABASE, MYSQLUSER, MYSQLPASSWORD
  - Falls back to local values only for local testing.
  - Re-uses session-stored Connection if already created to avoid duplicate declarations.
*/

Connection conn = null;

// 1) try reusing connection from session (if already created)
Object sconn = session.getAttribute("dbConn");
if (sconn != null && sconn instanceof Connection) {
    try {
        Connection tmp = (Connection) sconn;
        if (!tmp.isClosed() && tmp.isValid(2)) {
            conn = tmp;
        } else {
            // remove invalid connection
            session.removeAttribute("dbConn");
            conn = null;
        }
    } catch (Exception ignore) {
        session.removeAttribute("dbConn");
        conn = null;
    }
}

if (conn == null) {
    // 2) read environment variables
    String jdbcUrl = System.getenv("JDBC_URL");
    String dbUser  = System.getenv("JDBC_USER");
    String dbPass  = System.getenv("JDBC_PASS");

    // 3) If full JDBC_URL not provided, try Railway-style pieces
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
            if (dbUser == null || dbUser.trim().isEmpty()) dbUser = user;
            if (dbPass == null || dbPass.trim().isEmpty()) dbPass = pass;
        }
    }

    // 4) final fallback for local dev ONLY
    if (jdbcUrl == null || jdbcUrl.trim().isEmpty()) {
        jdbcUrl = "jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&serverTimezone=UTC";
        dbUser  = (dbUser == null || dbUser.trim().isEmpty()) ? "root" : dbUser;
        dbPass  = (dbPass == null) ? "DHiyvWtdZKvdUmqkKKLNLCpXTkPPsDCC" : dbPass; // local test only
    }

    // 5) try to create connection and store in session
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
        // store in session for re-use (note: avoid long-lived connections in prod)
        session.setAttribute("dbConn", conn);
    } catch (Throwable e) {
        // print helpful error (no secrets)
        out.println("<div style='font-family:Arial,Helvetica,sans-serif;'>");
        out.println("<h3 style='color:red;'>❌ Database Connection Error</h3>");
        String msg = e.getMessage();
        if (msg == null) msg = "Unknown error";
        // show only first line to avoid leaking sensitive info
        int idx = msg.indexOf('\n');
        if (idx > 0) msg = msg.substring(0, idx);
        out.println("<pre>" + org.apache.commons.text.StringEscapeUtils.escapeHtml4(msg) + "</pre>");
        out.println("</div>");
        return; // stop further processing
    }
}

// If we have a connection here, show success
out.println("<div style='font-family:Arial,Helvetica,sans-serif;'>");
if (conn != null) {
    out.println("<p style='color:green;'>✅ Database connection is ready (session stored).</p>");
    // show part of jdbc url (without credentials) for debug
    try {
        String metaUrl = conn.getMetaData().getURL();
        out.println("<p>Using: <code>" + org.apache.commons.text.StringEscapeUtils.escapeHtml4(metaUrl) + "</code></p>");
    } catch (Exception ignore) {}
} else {
    out.println("<p style='color:orange;'>⚠ Connection not established.</p>");
}
out.println("</div>");
%>