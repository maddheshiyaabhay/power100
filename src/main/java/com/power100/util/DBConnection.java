package com.power100.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        try {
            // agar existing connection open hai to wahi return karo
            if (connection != null && !connection.isClosed()) {
                return connection;
            }

            // 🔹 Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 🌐 Read environment variables from Railway (supports both styles)
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String db   = System.getenv("MYSQLDATABASE");
            if (db == null || db.isEmpty()) db = System.getenv("MYSQL_DATABASE");
            String user = System.getenv("MYSQLUSER");
            String pass = System.getenv("MYSQLPASSWORD");

            // 🟡 Fallback values (local test or if Railway vars not found)
            if (host == null || host.isEmpty()) host = "switchback.proxy.rlwy.net";
            if (port == null || port.isEmpty()) port = "35972";
            if (db == null || db.isEmpty())     db = "railway";
            if (user == null || user.isEmpty()) user = "root";
            if (pass == null || pass.isEmpty()) pass = "KRxBCWRejXxXwYdbmHCwgMhSHPywxaUR";

            // 🧠 Debug info (safe — password not printed)
            System.out.println("🔍 DEBUG -> Host=" + host + " | Port=" + port + " | DB=" + db + " | User=" + user);

            // 🔗 JDBC URL (Railway-safe)
            String url = "jdbc:mysql://" + host + ":" + port + "/" + db
                    + "?useSSL=false"
                    + "&allowPublicKeyRetrieval=true"
                    + "&serverTimezone=UTC"
                    + "&characterEncoding=UTF-8"
                    + "&autoReconnect=true"
                    + "&connectTimeout=10000";

            // ✅ Establish connection
            connection = DriverManager.getConnection(url, user, pass);
            System.out.println("✅ Database Connected Successfully!");
            return connection;

        } catch (ClassNotFoundException e) {
            System.err.println("❌ MySQL JDBC Driver not found!");
            throw new SQLException("MySQL Driver missing", e);

        } catch (SQLException e) {
            System.err.println("❌ Database Connection Failed! -> " + e.getMessage());
            throw e;
        }
    }
}