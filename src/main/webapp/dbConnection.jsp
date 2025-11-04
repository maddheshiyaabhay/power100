<%@ page contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%
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

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    try (Connection conn = DriverManager.getConnection(JDBC_URL, USER, PASS)) {
        out.write("DB CONNECTED");
    }
} catch (Throwable e) {
    e.printStackTrace(new java.io.PrintWriter(out));
}
%>