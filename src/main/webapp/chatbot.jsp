<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background:#f8f9fa; }
    .chat-box {
      height: 300px;
      overflow-y: auto;
      border: 1px solid #ddd;
      padding: 10px;
      background: #fff;
      border-radius: 10px;
    }
    .msg-user { background: #0d6efd; color:#fff; padding:8px 12px; border-radius:15px; margin:5px 0; text-align:right; }
    .msg-bot { background: #e9ecef; padding:8px 12px; border-radius:15px; margin:5px 0; text-align:left; }
  </style>
</head>
<body>
<div class="container mt-3">
  <h5 class="text-center"><i class="fa fa-robot"></i> Power100 Assistant</h5>
  <div class="chat-box" id="chatBox">
    <%
      try {
        Connection conn = DBConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM chat_messages ORDER BY created_at ASC");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
          String userMsg = rs.getString("user_message");
          String botReply = rs.getString("bot_reply");
    %>
      <div class="msg-user"><%= userMsg %></div>
      <% if(botReply != null && !botReply.isEmpty()) { %>
        <div class="msg-bot"><%= botReply %></div>
      <% } %>
    <%
        }
        rs.close(); ps.close(); conn.close();
      } catch(Exception e) {
        out.print("<p>Error loading chat: " + e.getMessage() + "</p>");
      }
    %>
  </div>

  <!-- Chat Form -->
  <form action="saveChat.jsp" method="post" class="d-flex mt-3">
    <input type="text" name="message" class="form-control" placeholder="Type your message..." required>
    <button class="btn btn-primary ms-2">Send</button>
  </form>
</div>
</body>
</html>