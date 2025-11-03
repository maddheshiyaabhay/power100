<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%--
  dbConnection.jsp
  - Sets a Connection object in session attribute "dbConn".
  - Uses environment variables if available: JDBC_URL, JDBC_USER, JDBC_PASS
  - Falls back to local dev settings ONLY if env not present.
  - Avoids declaring a top-level local variable named "conn" to prevent duplicate variable compile errors
    when this file is included in multiple JSPs. Local connection variable here is named dbConnLocal.
--%>

<%
    // Clear any previous error marker (so fresh include resets it)
    session.removeAttribute("dbConnError");

    // If session already has a working Connection, reuse it.
    Object existing = session.getAttribute("dbConn");
    boolean haveConnection = false;
    if (existing != null && existing instanceof java.sql.Connection) {
        try {
            if (!((Connection) existing).isClosed()) {
                haveConnection = true;
            } else {
                // closed -> remove
                session.removeAttribute("dbConn");
            }
        } catch (Throwable t) {
            session.removeAttribute("dbConn");
        }
    }

    if (!haveConnection) {
        Connection dbConnLocal = null;
        String err = null;
        try {
            // Try Render/Heroku style env vars first
            String jdbcUrl = System.getenv("JDBC_URL");
            String jdbcUser = System.getenv("JDBC_USER");
            String jdbcPass = System.getenv("JDBC_PASS");

            // If JDBC_URL not set, try Railway style env vars (host/port/db/user/pass)
            if ((jdbcUrl == null || jdbcUrl.trim().isEmpty())) {
                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT");
                String db   = System.getenv("MYSQLDATABASE");
                String user = System.getenv("MYSQLUSER");
                String pass = System.getenv("MYSQLPASSWORD");

                if (host != null && !host.trim().isEmpty()) {
                    if (port == null || port.trim().isEmpty()) port = "3306";
                    if (db == null || db.trim().isEmpty()) db = "railway";
                    jdbcUrl = "jdbc:mysql://" + host.trim() + ":" + port.trim() + "/" + db.trim()
                            + "?useSSL=false&serverTimezone=UTC";
                    jdbcUser = (jdbcUser == null || jdbcUser.trim().isEmpty()) ? user : jdbcUser;
                    jdbcPass = (jdbcPass == null || jdbcPass.trim().isEmpty()) ? pass : jdbcPass;
                }
            }

            // FINAL fallback for local dev ONLY (do NOT push secrets)
            if ((jdbcUrl == null || jdbcUrl.trim().isEmpty())) {
                // local default (only for local testing)
                jdbcUrl  = "jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&serverTimezone=UTC";
                jdbcUser = (jdbcUser == null || jdbcUser.trim().isEmpty()) ? "root" : jdbcUser;
                jdbcPass = (jdbcPass == null) ? "" : DHiyvWtdZKvdUmqkKKLNLCpXTkPPsDCC;
            }

            // Load driver and create connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            dbConnLocal = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);

            // Store in session for reuse by other JSPs (so they read session.getAttribute("dbConn"))
            session.setAttribute("dbConn", dbConnLocal);

        } catch (Throwable e) {
            // keep readable error in session so pages can show friendly message
            err = "DB Connection Error: " + e.getMessage();
            session.setAttribute("dbConnError", err);

            // ensure no broken object left in session
            session.removeAttribute("dbConn");
            try { if (dbConnLocal != null && !dbConnLocal.isClosed()) dbConnLocal.close(); } catch (Throwable ignore) {}
        }
    }
%>