<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // --- Session clear karo ---
    session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout - Power100</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
    <style>
        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #1f1c2c, #928dab);
            font-family: 'Segoe UI', sans-serif;
        }

        .logout-card {
            width: 400px;
            padding: 30px;
            border-radius: 20px;
            backdrop-filter: blur(15px);
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            text-align: center;
            color: #fff;
            animation: zoomIn 0.6s ease-out;
        }

        .logout-card h2 {
            font-weight: bold;
            margin-top: 15px;
        }

        .logout-card p {
            font-size: 1.1rem;
            margin-bottom: 20px;
        }

        /* 🎨 Button Style */
        .btn-home {
            display: inline-block;
            padding: 10px 25px;
            border-radius: 30px;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            background: linear-gradient(135deg, #ff512f, #dd2476);
            text-decoration: none;
            box-shadow: 0 6px 15px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 10px 20px rgba(0,0,0,0.4);
        }

        @keyframes zoomIn {
            from { transform: scale(0.7); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body>

<div class="logout-card">
    <!-- ✅ Animation -->
    <lottie-player src="https://assets9.lottiefiles.com/packages/lf20_jbrw3hcz.json"
                   background="transparent" speed="1"
                   style="width: 150px; height: 150px; margin:auto;" autoplay>
    </lottie-player>

    <h2>Logout Successful 🎉</h2>
    <p>You have been securely logged out.</p>
    <p>Redirecting to Home...</p>

    <!-- 🔘 Button -->
    <a href="index.jsp" class="btn-home">Go to Home</a>
</div>

<!-- ⏳ Auto redirect after 3 seconds -->
<script>
    setTimeout(function(){
        window.location.href = "index.jsp";
    }, 3000);
</script>

</body>
</html>