package com.power100.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Read from environment variables (Railway)
                String host = System.getenv("MYSQLHOST");
                String port = System.getenv("MYSQLPORT");
                String db   = System.getenv("MYSQLDATABASE");
                String user = System.getenv("MYSQLUSER");
                String pass = System.getenv("MYSQLPASSWORD");

                // Fallback (for local testing)
                if (host == null || host.isEmpty()) host = "mysql.railway.internal";
                if (port == null || port.isEmpty()) port = "3306";
                if (db == null || db.isEmpty())     db   = "railway";
                if (user == null || user.isEmpty()) user = "root";
                if (pass == null || pass.isEmpty()) pass = "KRxBCWRejXxXwYdbmHCwgMhSHPywxaUR";

                String url = "jdbc:mysql://" + host + ":" + port + "/" + db
                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

                connection = DriverManager.getConnection(url, user, pass);
                System.out.println("✅ Database Connected Successfully!");

            } catch (ClassNotFoundException e) {
                System.out.println("❌ MySQL Driver not found!");
                e.printStackTrace();
                throw new RuntimeException(e);
            } catch (SQLException e) {
                System.out.println("❌ Database connection failed!");
                e.printStackTrace();
                throw e;
            }
        }
        return connection;
    }
}