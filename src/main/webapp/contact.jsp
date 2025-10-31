<%@ page import="java.sql.*" %>
<%@ page import="com.power100.util.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Power100 Home Appliances Pvt. Ltd.</title>
   <!-- ========== FAVICON (replace with your Power100 small logo) ========== -->
      <!-- Save your favicon file as images/logo.png in project -->
      <link rel="icon" type="image/png" href="images/logo.png">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body { background:#f9f9f9; font-family:'Segoe UI',sans-serif; }
    .contact-section { padding:60px 20px; }
    .card-custom {
      background:#fff;
      border-radius:15px;
      padding:25px;
      box-shadow:0 6px 20px rgba(0,0,0,0.2);
    }
    .card-custom h5 { color:#0056b3; margin-bottom:15px; }
    .map-frame {
      border-radius:12px;
      overflow:hidden;
      box-shadow:0 5px 15px rgba(0,0,0,0.3);
    }
    .btn-custom {
      background:linear-gradient(45deg,#007bff,#6610f2);
      color:#fff;
      border-radius:8px;
      transition:0.3s;
    }
    .btn-custom:hover {
      background:linear-gradient(45deg,#6610f2,#007bff);
      transform:scale(1.05);
    }
    /* ✅ Floating WhatsApp Button */
    .whatsapp-float {
      position: fixed;
      bottom: 20px;
      left: 20px;
      background: #25D366;
      color: #fff;
      border-radius: 50%;
      padding: 16px 18px;
      font-size: 1.6rem;
      box-shadow: 0 6px 18px rgba(0,0,0,0.4);
      z-index: 999;
      transition: 0.3s;
    }
    .whatsapp-float:hover { background:#20b955; transform:scale(1.1); }
    /* ✅ Floating Email Button */
    .email-float {
      position: fixed;
      bottom: 90px;
      left: 20px;
      background: #ff5722;
      color: #fff;
      border-radius: 50%;
      padding: 16px 18px;
      font-size: 1.6rem;
      box-shadow: 0 6px 18px rgba(0,0,0,0.4);
      z-index: 999;
      transition: 0.3s;
    }
    .email-float:hover { background:#e64a19; transform:scale(1.1); }
  </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container contact-section">
  <div class="row g-4">

    <!-- ✅ Contact Form -->
    <div class="col-md-6">
      <div class="card-custom">
        <h5><i class="fa fa-envelope"></i> Send us a Message</h5>
        <form method="post" action="contact.jsp">
          <div class="mb-3">
            <label>Full Name</label>
            <input type="text" name="fullname" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
          </div>
          <div class="mb-3">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control">
          </div>
          <div class="mb-3">
            <label>Message</label>
            <textarea name="message" rows="4" class="form-control" required></textarea>
          </div>
          <button type="submit" class="btn btn-custom w-100">Send Message</button>
        </form>
      </div>
    </div>

    <!-- ✅ Company Info + Map -->
    <div class="col-md-6">
      <div class="card-custom mb-4">
        <h5><i class="fa fa-building"></i> Power100 Home Appliances Pvt. Ltd.</h5>
        <p><i class="fa fa-map-marker-alt"></i> C-3, Sec-2, DSIDC Bawana Industrial Area, Delhi - 110039</p>
        <p><i class="fa fa-phone"></i> 8081782444 | 9236504990</p>
        <p><i class="fa fa-envelope"></i> power100hundred@gmail.com</p>
      </div>
      <div class="map-frame">
        <iframe
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3504.9422995045616!2d77.04807407499924!3d28.689065775630237!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d0516c7f3cfb7%3A0x5dfb134b9c0f5ed!2sDSIDC%20Bawana%20Industrial%20Area%2C%20Delhi!5e0!3m2!1sen!2sin!4v1700000000000"
          width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy">
        </iframe>
      </div>
    </div>

  </div>
</div>

<jsp:include page="footer.jsp"/>



<!-- ✅ Floating Email -->
<a href="mailto:power100hundred@gmail.com" class="email-float"><i class="fa fa-envelope"></i></a>

</body>
</html>

<%
  // ✅ Backend logic
  String fullname = request.getParameter("fullname");
  String email = request.getParameter("email");
  String phone = request.getParameter("phone");
  String message = request.getParameter("message");

  if(fullname != null && email != null && message != null){
      try{
          Connection conn = DBConnection.getConnection();
          PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO contact_messages(fullname,email,phone,message) VALUES(?,?,?,?)"
          );
          ps.setString(1, fullname);
          ps.setString(2, email);
          ps.setString(3, phone);
          ps.setString(4, message);
          ps.executeUpdate();
          conn.close();
          out.println("<script>alert('✅ Thank you! Your message has been sent.');</script>");
      }catch(Exception e){
          out.println("<script>alert('❌ Error: "+e.getMessage()+"');</script>");
      }
  }
%>