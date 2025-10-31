package com.power100.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/power100db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "12345"; // jo tumne Workbench me set kiya hai

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // MySQL 8 ke liye correct driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}