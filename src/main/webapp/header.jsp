<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Basic SEO + Branding -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Power100 Home Appliances Pvt. Ltd</title>

    <!-- Favicon -->
    <link rel="icon" type="image/png" href="images/logo.png">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <!-- Custom Branding CSS -->
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            background: linear-gradient(90deg, #003366, #0055a5);
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .navbar-brand img {
            height: 50px;
        }
        .navbar-nav .nav-link {
            color: #fff !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .navbar-nav .nav-link:hover {
            color: #ffcc00 !important;
            transform: scale(1.1);
        }
        .nav-icons i {
            font-size: 18px;
            margin-right: 6px;
        }

        /* ✅ Added Responsive Design (Only this part added, no other change) */
        @media (max-width: 992px) {
            .navbar-nav {
                background: #00264d;
                border-radius: 10px;
                padding: 10px 0;
            }
            .navbar-nav .nav-link {
                text-align: center;
                padding: 10px;
                font-size: 15px;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }
            .navbar-nav .nav-link:last-child {
                border-bottom: none;
            }
            .navbar-brand img {
                height: 42px;
            }
            .navbar-toggler {
                border: none;
                font-size: 22px;
            }
        }

        @media (max-width: 480px) {
            .navbar-nav .nav-link {
                font-size: 14px;
                padding: 8px;
            }
            .navbar-brand img {
                height: 38px;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <img src="images/logo.png" alt="Power100">
        </a>
        <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fa-solid fa-house"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp"><i class="fa-solid fa-circle-info"></i> About</a></li>
                <li class="nav-item"><a class="nav-link" href="products.jsp"><i class="fa-solid fa-box"></i> Products</a></li>
                <li class="nav-item"><a class="nav-link" href="manufacturing.jsp"><i class="fa-solid fa-industry"></i> Manufacturing</a></li>
                <li class="nav-item"><a class="nav-link" href="contact.jsp"><i class="fa-solid fa-phone"></i> Contact</a></li>
                <li class="nav-item"><a class="nav-link" href="cart.jsp"><i class="fa-solid fa-cart-shopping"></i> Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="myOrders.jsp"><i class="fa-solid fa-box-open"></i> My Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp"><i class="fa-solid fa-right-to-bracket"></i> Login</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>