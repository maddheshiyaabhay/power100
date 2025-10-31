<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Power100 Home Appliances Pvt. Ltd.</title>
  <style>
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: #f5f7fa;
    }

    /* Navbar */
    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 14px 40px;
      background: linear-gradient(135deg, #141e30, #243b55);
      border-radius: 0 0 18px 18px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.5);
      flex-wrap: wrap;
    }

    /* Logo + Brand */
    .logo {
      display: flex;
      align-items: center;
      font-size: 22px;
      font-weight: 700;
      color: #FFD700;
      text-shadow: 0 0 8px rgba(255,215,0,0.9), 0 0 15px rgba(0,229,255,0.6);
      animation: brand-glow 3s infinite alternate;
    }

    .logo img {
      height: 50px;
      margin-right: 12px;
      border-radius: 8px;
      animation: logo-bounce 3s infinite ease-in-out;
      filter: drop-shadow(0 0 8px rgba(255,255,255,0.6));
    }

    @keyframes logo-bounce {
      0% { transform: rotateY(0deg) scale(1); }
      50% { transform: rotateY(20deg) scale(1.05); }
      100% { transform: rotateY(0deg) scale(1); }
    }

    @keyframes brand-glow {
      from { text-shadow: 0 0 8px #FFD700, 0 0 16px #00e5ff; }
      to   { text-shadow: 0 0 16px #FFD700, 0 0 32px #00e5ff; }
    }

    /* Nav Links Center */
    .nav-links {
      display: flex;
      gap: 24px;
    }

    .nav-links a {
      text-decoration: none;
      color: #e0f7fa;
      font-weight: 500;
      font-size: 16px;
      position: relative;
      transition: 0.3s;
    }

    .nav-links a::after {
      content: "";
      position: absolute;
      left: 0;
      bottom: -4px;
      width: 100%;
      height: 2px;
      background: linear-gradient(90deg, #00e5ff, #FFD700);
      transform: scaleX(0);
      transition: transform 0.3s;
    }

    .nav-links a:hover::after {
      transform: scaleX(1);
    }

    .nav-links a:hover {
      color: #FFD700;
      text-shadow: 0 0 8px #FFD700;
    }

    /* Action Buttons - Right */
    .nav-actions {
      display: flex;
      gap: 12px;
    }

    .nav-actions a {
      padding: 8px 16px;
      border-radius: 12px;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.3s ease;
      color: #fff;
    }

    .cart-btn { background: linear-gradient(135deg, #f7971e, #ffd200); color: #111; }
    .orders-btn { background: linear-gradient(135deg, #00c853, #b2ff59); color: #111; }
    .login-btn { background: linear-gradient(135deg, #2196f3, #00e5ff); }
    .register-btn { background: linear-gradient(135deg, #d500f9, #ff4081); }

    .nav-actions a:hover { filter: brightness(1.15); }

    /* ✅ Responsive Design (Only Added This Section) */
    @media (max-width: 992px) {
      .navbar {
        flex-direction: column;
        text-align: center;
        padding: 12px 20px;
      }

      .logo {
        justify-content: center;
        font-size: 18px;
        margin-bottom: 10px;
        text-align: center;
      }

      .logo img {
        height: 40px;
        margin-right: 8px;
      }

      .nav-links {
        flex-wrap: wrap;
        justify-content: center;
        gap: 12px;
        margin-bottom: 10px;
      }

      .nav-links a {
        font-size: 14px;
      }

      .nav-actions {
        flex-wrap: wrap;
        justify-content: center;
        gap: 10px;
      }

      .nav-actions a {
        padding: 6px 12px;
        font-size: 14px;
      }
    }

    @media (max-width: 480px) {
      .logo { flex-direction: column; font-size: 16px; }
      .logo img { margin: 0 0 6px 0; height: 38px; }
      .nav-links a { font-size: 13px; }
      .nav-actions a { font-size: 13px; padding: 5px 10px; }
    }
  </style>
</head>
<body>

  <!-- Navbar -->
  <div class="navbar">
    <!-- Left: Logo + Brand -->
    <div class="logo">
      <img src="images/logo.png" alt="Power100 Logo">
      Power100 Home Appliances Pvt. Ltd.
    </div>

    <!-- Center: Links -->
    <div class="nav-links">
      <a href="index.jsp">Home</a>
      <a href="about.jsp">About</a>
      <a href="products.jsp">Products</a>
      <a href="manufacturing.jsp">Manufacturing</a>
      <a href="contact.jsp">Contact</a>
    </div>

    <!-- Right: Action Buttons -->
    <div class="nav-actions">
      <a href="cart.jsp" class="cart-btn">🛒 Cart</a>
      <a href="myOrders.jsp" class="orders-btn">📦 My Orders</a>
      <a href="login.jsp" class="login-btn">🔑 Login</a>
      <a href="register.jsp" class="register-btn">📝 Register</a>
    </div>
  </div>

</body>
</html>