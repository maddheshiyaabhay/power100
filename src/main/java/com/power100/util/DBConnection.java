public class DBConnection {
    public static Connection getConnection() {
        try {
            String host = System.getenv("MYSQLHOST");      // या MYSQL_HOST जैसा तू Railway में डालेगा
            String port = System.getenv("MYSQLPORT");
            String db   = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String pass = System.getenv("MYSQLPASSWORD");

            if (host == null || port == null) {
                // fallback (development) — optional
                host = "localhost";
                port = "3306";
                db = "power100";
            }

            String url = "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}