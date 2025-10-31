<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<%
String fullName = request.getParameter("fullName");
String email = request.getParameter("email");
String password = request.getParameter("password");
String phone = request.getParameter("phone");

try {
  Connection conn = DBConnection.getConnection();
  PreparedStatement ps = conn.prepareStatement("INSERT INTO users(fullName,email,password,phone) VALUES(?,?,?,?)");
  ps.setString(1, fullName);
  ps.setString(2, email);
  ps.setString(3, password);
  ps.setString(4, phone);
  ps.executeUpdate();
  conn.close();
  out.println("<script>alert('Registration Successful! Please Login'); window.location='login.jsp';</script>");
} catch(Exception e) {
  out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='register.jsp';</script>");
}
%>