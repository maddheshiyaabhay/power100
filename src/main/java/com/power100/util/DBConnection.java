package com.power100.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection connection = null;

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Read from environment variables (Render)
                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT");
                String db   = System.getenv("MYSQLDATABASE");   // IMPORTANT: name must match Render key
                String user = System.getenv("MYSQLUSER");
                String pass = System.getenv("MYSQLPASSWORD");

                // Fallback (only if env not set)
                if (host == null || host.isEmpty()) host = "switchback.proxy.rlwy.net";
                if (port == null || port.isEmpty()) port = "35972";
                if (db == null || db.isEmpty())     db   = "railway";
                if (user == null || user.isEmpty()) user = "root";
                if (pass == null || pass.isEmpty()) pass = "KRxBCWRejXxXwYdbmHCwgMhSHPywxaUR";

                String url = "jdbc:mysql://" + host + ":" + port + "/" + db
                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

                connection = DriverManager.getConnection(url, user, pass);
                System.out.println("✅ Database Connected Successfully!");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver not found!");
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch (SQLException e) {
            System.out.println("❌ Database connection failed!");
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return connection;
    }
}