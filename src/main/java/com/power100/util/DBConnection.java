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

                // 🌐 Read from Railway environment variables
                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT");
                String db   = System.getenv("MYSQLDATABASE");
                String user = System.getenv("MYSQLUSER");
                String pass = System.getenv("MYSQLPASSWORD");

                // 🟡 Fallback values (agar environment se null aaye)
                if (host == null || host.isEmpty()) host = "mysql.railway.internal";
                if (port == null || port.isEmpty()) port = "3306";
                if (db == null || db.isEmpty())     db = "railway";
                if (user == null || user.isEmpty()) user = "root";
                if (pass == null || pass.isEmpty()) pass = "KRxBCWRejXxXwYdbmHCwgMhSHPywxaUR";

                // 🟢 Debug info (temporary - password mat print karna)
                System.out.println("🔍 DEBUG -> Host: " + host + " | Port: " + port + " | DB: " + db + " | User: " + user);

                // 🔗 JDBC Connection URL
                String url = "jdbc:mysql://" + host + ":" + port + "/" + db
                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&autoReconnect=true";

                // Connect to MySQL
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