<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<%
  String message = request.getParameter("message");
  String reply = "";

  // Simple AI-style replies (later AI API integrate kar sakte ho)
  if(message.toLowerCase().contains("hello")) {
    reply = "Hi! How can I help you with Power100 products?";
  } else if(message.toLowerCase().contains("price")) {
    reply = "Please check the Products page for latest prices!";
  } else if(message.toLowerCase().contains("cooler")) {
    reply = "Our Coolers are high performance with advanced cooling technology!";
  } else {
    reply = "Thank you for your message. Our support team will get back to you soon!";
  }

  try {
    Connection conn = DBConnection.getConnection();
    PreparedStatement ps = conn.prepareStatement("INSERT INTO chat_messages(user_message, bot_reply) VALUES(?,?)");
    ps.setString(1, message);
    ps.setString(2, reply);
    ps.executeUpdate();
    ps.close(); conn.close();
  } catch(Exception e) {
    out.print("Error: " + e.getMessage());
  }

  response.sendRedirect("chatbot.jsp");
%>