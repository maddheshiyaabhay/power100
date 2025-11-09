<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="footer">
  <div class="footer-container">

    <!-- Company Info -->
    <div class="footer-section company">
      <img src="images/power100logo.png" alt="Power100 Logo" class="footer-logo">
      <h3>Power100 Home Appliances Pvt. Ltd.</h3>
      <p>Delivering <b>Smart TVs, Coolers & Washing Machines</b> with premium quality and trust.</p>
      <p><strong>📍 Address:</strong>Pratappur Kamaicha Chanda Lambhua Sultanpur (U.P)-222303</p>
      <p><strong>📞 Phone:</strong> 8081782444, 9236504990</p>
      <p><strong>📧 Email:</strong> power100hundred@gmail.com</p>
    </div>

    <!-- Quick Links -->
    <div class="footer-section links">
      <h4>Quick Links</h4>
      <ul>
        <li><a href="index.jsp">Home</a></li>
        <li><a href="about.jsp">About</a></li>
        <li><a href="products.jsp">Products</a></li>
        <li><a href="manufacturing.jsp">Manufacturing</a></li>
        <li><a href="contact.jsp">Contact</a></li>
      </ul>
    </div>

    <!-- Why Power100 -->
    <div class="footer-section why">
      <h4>Why Choose Power100?</h4>
      <ul>
        <li>⭐ 15+ Years of Experience</li>
        <li>🏠 10,000+ Happy Families</li>
        <li>✅ ISO Certified Quality</li>
        <li>⚡ High Performance & Durability</li>
      </ul>
    </div>

    <!-- Social + Map -->
    <div class="footer-section connect">
      <h4>Connect With Us</h4>
      <div class="social-icons">
        <a href="#"><i class="fab fa-facebook-f"></i></a>
        <a href="#"><i class="fab fa-instagram"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
        <a href="#"><i class="fab fa-whatsapp"></i></a>
      </div>
      <h4>📍 Location</h4>
      <!-- FIXED Google Map Embed -->
      <iframe
        src="https://www.google.com/maps?q=PratappurKamaicha%20Chanda%20Lambhua%20Sultanpur%20U.P&output=embed"
        width="100%" height="180" style="border:0; border-radius:10px;" allowfullscreen loading="lazy"></iframe>
    </div>
  </div>

  <!-- Bottom Bar -->
  <div class="footer-bottom">
    <p>© 2025 <strong>Power100 Home Appliances Pvt. Ltd.</strong> | All Rights Reserved</p>
  </div>
</footer>

<!-- Floating WhatsApp -->
<a href="https://wa.me/918081784244" class="whatsapp-float" target="_blank">
  <i class="fab fa-whatsapp"></i>
</a>

<!-- Back to Top -->
<button onclick="topFunction()" id="backToTop" title="Go to top">↑</button>

<!-- Chatbot Floating -->
<div id="chatbot-icon" onclick="toggleChatbot()">💬</div>
<div id="chatbot-box">
  <div class="chat-header">🤖 Power100 Assistant <span onclick="toggleChatbot()">✖</span></div>
  <div class="chat-body" id="chatBody">
    <p><strong>Bot:</strong> Hi 👋, welcome to Power100! How can I help you today?</p>
  </div>
  <div class="chat-input">
    <input type="text" id="chatMessage" placeholder="Type your message...">
    <button onclick="sendMessage()">Send</button>
  </div>
</div>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ===== FOOTER ===== */
.footer {
  background: linear-gradient(135deg, #141E30, #243B55);
  color: white;
  padding: 50px 20px 20px;
  font-family: 'Segoe UI', sans-serif;
}
.footer-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  max-width: 1200px;
  margin: auto;
}
.footer h3, .footer h4 { color: #FFD700; margin-bottom: 12px; }
.footer p, .footer li, .footer a { font-size: 14px; color: #ddd; }
.footer a:hover { color: #FFD700; }
.footer ul { list-style: none; padding: 0; }
.footer-section li { margin-bottom: 8px; }
.footer-logo { width: 130px; margin-bottom: 10px; animation: floatLogo 3s infinite ease-in-out; }
@keyframes floatLogo { 0%{transform:translateY(0);} 50%{transform:translateY(-8px);} 100%{transform:translateY(0);} }
.social-icons a { font-size: 20px; margin-right: 15px; color: white; transition: 0.3s; }
.social-icons a:hover { color: #25D366; }
.footer-bottom { text-align: center; margin-top: 20px; font-size: 13px; border-top: 1px solid #333; padding-top: 10px; }

/* ===== FLOATING BUTTONS ===== */
.whatsapp-float {
  position: fixed;
  width: 55px;
  height: 55px;
  bottom: 80px;
  right: 20px;
  background: #25d366;
  color: white;
  border-radius: 50%;
  text-align: center;
  font-size: 28px;
  z-index: 100;
  box-shadow: 0 3px 10px rgba(0,0,0,0.3);
}
.whatsapp-float i { margin-top: 13px; }
#backToTop {
  display: none;
  position: fixed;
  bottom: 20px;
  right: 20px;
  font-size: 18px;
  border: none;
  background: #FFD700;
  padding: 10px 15px;
  border-radius: 50%;
  cursor: pointer;
  z-index: 99;
}
#backToTop:hover { background: #ff9800; }

/* ===== CHATBOT ===== */
#chatbot-icon {
  position: fixed;
  bottom: 150px;
  right: 20px;
  background: #243B55;
  color: white;
  font-size: 22px;
  padding: 12px;
  border-radius: 50%;
  cursor: pointer;
  box-shadow: 0 3px 10px rgba(0,0,0,0.3);
  animation: pulse 1.5s infinite;
}
@keyframes pulse { 0%{transform:scale(1);} 50%{transform:scale(1.1);} 100%{transform:scale(1);} }

#chatbot-box {
  display: none;
  position: fixed;
  bottom: 80px;
  right: 20px;
  width: 320px;
  height: 400px;
  background: rgba(255,255,255,0.95);
  backdrop-filter: blur(10px);
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0px 4px 12px rgba(0,0,0,0.3);
  animation: fadeIn 0.3s ease-in-out;
}
@keyframes fadeIn { from{opacity:0; transform:scale(0.9);} to{opacity:1; transform:scale(1);} }

.chat-header {
  background: #243B55;
  color: white;
  padding: 12px;
  display: flex;
  justify-content: space-between;
  font-weight: bold;
}
.chat-body { padding: 10px; height: 280px; overflow-y: auto; font-size: 14px; color: #333; }
.chat-input { display: flex; border-top: 1px solid #ddd; }
.chat-input input { flex: 1; padding: 10px; border: none; outline: none; }
.chat-input button { padding: 10px; background: #243B55; color: white; border: none; cursor: pointer; }
</style>

<script>
// Back to Top
let mybutton = document.getElementById("backToTop");
window.onscroll = function() {
  if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}

// Chatbot
function toggleChatbot() {
  var box = document.getElementById("chatbot-box");
  box.style.display = (box.style.display === "block") ? "none" : "block";
}
function sendMessage() {
  var input = document.getElementById("chatMessage");
  var chatBody = document.getElementById("chatBody");
  if (input.value.trim() !== "") {
    chatBody.innerHTML += "<p><strong>You:</strong> " + input.value + "</p>";
    setTimeout(() => {
      chatBody.innerHTML += "<p><strong>Bot:</strong> Got it ✅ We will get back to you shortly!</p>";
      chatBody.scrollTop = chatBody.scrollHeight;
    }, 800);
    input.value = "";
  }
}
</script>