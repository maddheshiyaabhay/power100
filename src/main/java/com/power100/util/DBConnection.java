package com.power100.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                // Load MySQL JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // 🌐 Railway variables
                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT");
                String db   = System.getenv("MYSQLDATABASE");
                String user = System.getenv("MYSQLUSER");
                String pass = System.getenv("MYSQLPASSWORD");

                // 🟡 Fallback values (agar Railway variables na mile)
                if (host == null || host.isEmpty()) host = "switchback.proxy.rlwy.net";
                if (port == null || port.isEmpty()) port = "35972";
                if (db == null || db.isEmpty())     db = "power100db";
                if (user == null || user.isEmpty()) user = "root";
                if (pass == null || pass.isEmpty()) pass = "KRxBCWRejXxXwYdbmHCwgMhSHPywxaUR";

                // 🟢 Debug info (optional)
                System.out.println("🔍 DEBUG -> Connecting to " + host + ":" + port + "/" + db);

                // 🔗 JDBC URL
                String url = "jdbc:mysql://" + host + ":" + port + "/" + db
                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&autoReconnect=true";

                // Connect
                connection = DriverManager.getConnection(url, user, pass);
                System.out.println("✅ Database Connected Successfully!");

            } catch (ClassNotFoundException e) {
                System.out.println("❌ MySQL JDBC Driver not found!");
                e.printStackTrace();
                throw new RuntimeException(e);
            } catch (SQLException e) {
                System.out.println("❌ Database Connection Failed!");
                e.printStackTrace();
                throw e;
            }
        }
        return connection;
    }
}