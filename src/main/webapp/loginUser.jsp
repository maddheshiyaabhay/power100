<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<%
String email = request.getParameter("email");
String password = request.getParameter("password");

try {
  Connection conn = DBConnection.getConnection();
  PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
  ps.setString(1, email);
  ps.setString(2, password);
  ResultSet rs = ps.executeQuery();

  if(rs.next()){
    session.setAttribute("userId", rs.getInt("id"));
    session.setAttribute("userName", rs.getString("fullName"));
    response.sendRedirect("index.jsp");
  } else {
    out.println("<script>alert('Invalid Email or Password!'); window.location='login.jsp';</script>");
  }
  conn.close();
} catch(Exception e) {
  out.println("Error: " + e.getMessage());
}
%>