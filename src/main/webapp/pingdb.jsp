<%@ page import="java.sql.*" %>
<%
    // ========= DATABASE PING TEST START =========

    // 👉 Railway MySQL Credentials (Public Networking)
    final String JDBC_URL = "jdbc:mysql://turntable.proxy.rlwy.net:50177/railway"
        + "?useSSL=true"
        + "&requireSSL=true"
        + "&verifyServerCertificate=false"
        + "&allowPublicKeyRetrieval=true"
        + "&serverTimezone=UTC"
        + "&enabledTLSProtocols=TLSv1.2"
        + "&connectTimeout=10000"
        + "&socketTimeout=10000"
        + "&autoReconnect=true";

    final String USER = "root";
    final String PASS = "EqekYOUtDaWViYKHnZTyxPwKjVxCtQrH";

    Connection conn = null;

    try {
        // ✅ Load driver and connect
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, USER, PASS);

        // ✅ Simple Ping Query
        PreparedStatement ps = conn.prepareStatement("SELECT 1");
        ResultSet rs = ps.executeQuery();

        out.println("<html><body style='font-family:sans-serif;'>");
        if (rs.next()) {
            out.println("<h2 style='color:green'>✅ Ping Successful! Database Working Properly.</h2>");
            out.println("<p>Result: " + rs.getInt(1) + "</p>");
        } else {
            out.println("<h2 style='color:orange'>⚠ Connected, but query returned no result.</h2>");
        }
        out.println("<p><b>JDBC URL:</b><br>" jdbc:mysql://turntable.proxy.rlwy.net:50177/railway "</p>");
        out.println("</body></html>");

        rs.close();
        ps.close();
    } catch (Exception e) {
        out.println("<html><body style='font-family:sans-serif;'>");
        out.println("<h2 style='color:red'>❌ Ping Test Failed</h2>");
        out.println("<pre style='background:#fee;padding:10px;border-radius:8px;'>" + e + "</pre>");
        out.println("</body></html>");
    } finally {
        try { if (conn != null && !conn.isClosed()) conn.close(); } catch (Exception ignore) {}
    }

    // ========= DATABASE PING TEST END =========
%>