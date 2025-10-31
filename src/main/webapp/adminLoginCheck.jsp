<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<%
String adminName = request.getParameter("adminName");
String adminPass = request.getParameter("adminPass");

try {
  Connection conn = DBConnection.getConnection();
  PreparedStatement ps = conn.prepareStatement("SELECT * FROM admin_users WHERE adminName=? AND adminPass=?");
  ps.setString(1, adminName);
  ps.setString(2, adminPass);
  ResultSet rs = ps.executeQuery();

  if(rs.next()) {
    session.setAttribute("adminName", adminName);
    response.sendRedirect("adminDashboard.jsp");
  } else {
    out.println("<script>alert('Invalid Login!'); window.location='adminLogin.jsp';</script>");
  }
  conn.close();
} catch(Exception e) {
  out.println("Error: " + e.getMessage());
}
%>