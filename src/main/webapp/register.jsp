<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Register - Power100</title>
     <!-- ========== FAVICON (replace with your Power100 small logo) ========== -->
          <!-- Save your favicon file as images/logo.png in project -->
          <link rel="icon" type="image/png" href="images/logo.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #141E30, #243B55);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-box {
            background: rgba(255, 255, 255, 0.08);
            padding: 40px;
            border-radius: 20px;
            backdrop-filter: blur(12px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.6);
            text-align: center;
            width: 380px;
            animation: zoomIn 1s ease-in-out;
        }

        .register-box img {
            width: 120px;
            margin-bottom: 15px;
        }

        .register-box h2 {
            margin-bottom: 20px;
            color: #00FFCC;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .input-group input {
            width: 100%;
            padding: 12px 45px 12px 45px;
            border: none;
            border-radius: 30px;
            outline: none;
            background: rgba(255,255,255,0.15);
            color: white;
            font-size: 15px;
            transition: 0.3s;
            box-shadow: inset 0 0 5px rgba(0,0,0,0.3);
        }

        .input-group input:focus {
            background: rgba(255,255,255,0.25);
            box-shadow: 0 0 10px #00FFCC, 0 0 20px rgba(0,255,204,0.6);
            transform: scale(1.03);
        }

        .input-group i {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            color: #00FFCC;
            font-size: 18px;
        }

        ::placeholder {
            color: rgba(255,255,255,0.7);
        }

        button {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 30px;
            background: linear-gradient(90deg, #00FFCC, #00BFFF);
            color: #000;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: linear-gradient(90deg, #00BFFF, #00FFCC);
            transform: scale(1.05);
            box-shadow: 0 0 15px #00FFCC;
        }

        .extra {
            margin-top: 15px;
            color: white;
            font-size: 14px;
        }

        .extra a {
            color: #00FFCC;
            text-decoration: none;
            font-weight: bold;
        }

        @keyframes zoomIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>
    <div class="register-box">
        <img src="images/logo.png" alt="Power100 Logo">
        <h2>Create Account</h2>
        <form action="RegisterServlet" method="post">
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" name="fullname" placeholder="Full Name" required>
            </div>
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" placeholder="Email" required>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <div class="input-group">
                <i class="fas fa-phone"></i>
                <input type="text" name="phone" placeholder="Phone" required>
            </div>
            <button type="submit">Register</button>
        </form>
        <div class="extra">
            Already have an account? <a href="login.jsp">Login</a>
        </div>
    </div>
</body>
</html>