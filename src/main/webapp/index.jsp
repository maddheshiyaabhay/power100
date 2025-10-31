<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Power100 Home Appliances Pvt. Ltd.</title>

  <!-- ========== FAVICON (replace with your Power100 small logo) ========== -->
  <!-- Save your favicon file as images/logo.png in project -->
  <link rel="icon" type="image/png" href="images/logo.png">

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap & Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    body { font-family: 'Segoe UI', sans-serif; }

    /* Hero Section */
    .hero-section {
      background: linear-gradient(135deg, #003366, #0072ff);
      height: 90vh;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      color: #fff;
      padding: 0 15px;
    }
    .hero-section h1 {
      font-size: 3.2rem;
      font-weight: 900;
    }
    .hero-section h1 span {
      color: #FFD700; /* yellow highlight */
      text-shadow: 2px 2px 10px rgba(0,0,0,0.6);
    }
    .hero-section p {
      margin-top: 15px;
      font-size: 1.2rem;
    }
    .hero-buttons a {
      display: inline-block;
      margin: 10px;
      padding: 12px 25px;
      border-radius: 30px;
      font-weight: bold;
      font-size: 1.1rem;
      transition: 0.4s;
      box-shadow: 0 5px 15px rgba(0,0,0,0.3);
      text-decoration: none;
    }
    .btn-shop { background: #FFD700; color: #000; }
    .btn-shop:hover { background: #ffae00; color: #fff; transform: scale(1.08); }
    .btn-contact { background: transparent; border: 2px solid #fff; color: #fff; }
    .btn-contact:hover { background: #fff; color: #0072ff; transform: scale(1.08); }

    /* Section Title */
    h2.section-title {
      text-align: center;
      font-weight: bold;
      margin: 60px 0 40px;
      color: #003366;
      position: relative;
    }
    h2.section-title::after {
      content: '';
      display: block;
      width: 100px;
      height: 4px;
      margin: 8px auto 0;
      background: linear-gradient(90deg, #ff0000, #FFD700);
      border-radius: 5px;
    }

    /* Featured Products Carousel */
    .carousel-inner img {
      max-height: 400px;
      object-fit: contain;
      border-radius: 15px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.4);
    }
    .carousel-caption {
      background: rgba(0,0,0,0.6);
      padding: 15px;
      border-radius: 10px;
    }
    .carousel-caption h5 { font-size: 1.4rem; font-weight: bold; color: #FFD700; }
    .btn-view {
      background: #FFD700; color: #000; padding: 6px 15px;
      border-radius: 20px; font-weight: 600; transition: 0.3s;
    }
    .btn-view:hover { background: #ff9800; color: #fff; transform: scale(1.05); }

    /* Why Choose Power100 */
    .feature-card {
      padding: 30px;
      text-align: center;
      background: #fff;
      border-radius: 15px;
      transition: 0.3s;
      border: 2px solid transparent;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .feature-card i {
      font-size: 2rem;
      background: #0072ff;
      color: #fff;
      padding: 15px;
      border-radius: 50%;
      margin-bottom: 15px;
      transition: 0.3s;
    }
    .feature-card:hover {
      transform: translateY(-12px) scale(1.03);
      border: 2px solid #ff0000;
      box-shadow: 0 15px 30px rgba(0,0,0,0.2);
    }
    .feature-card:hover i {
      background: #FFD700;
      color: #000;
    }
    /* Testimonial Cards */
    .testimonial-card {
      max-width: 700px;
      border-radius: 20px;
      background: linear-gradient(145deg,#ffffff,#f7f7f7);
      transition: 0.3s;
    }
    .testimonial-card:hover {
      transform: translateY(-5px) scale(1.02);
      box-shadow: 0 12px 25px rgba(0,0,0,0.2);
    }

    /* Progress bar */
    .progress-container {
      position: relative;
      width: 100%;
      height: 5px;
      background: #ddd;
      border-radius: 3px;
      overflow: hidden;
    }
    .progress-bar-fill {
      width: 0%;
      height: 100%;
      background: linear-gradient(90deg, #ff0000, #FFD700);
      animation: fillProgress 4s linear infinite;
    }
    @keyframes fillProgress {
      from { width: 0%; }
      to { width: 100%; }
    }

    /* ========== MOBILE RESPONSIVE TWEAKS ========== */
    @media (max-width: 992px) {
      .hero-section { height: 65vh; }
      .hero-section h1 { font-size: 2.6rem; }
    }
    @media (max-width: 768px) {
      .hero-section { height: auto; padding: 60px 12px; }
      .hero-section h1 { font-size: 2rem; line-height: 1.3; }
      .hero-section p { font-size: 1rem; }
      .hero-buttons a { font-size: 1rem; padding: 10px 20px; }
      .carousel-inner img { max-height: 250px; }
      .feature-card { padding: 20px; }
      .testimonial-card { width: 95%; margin: 0 auto; }
      .carousel-caption { font-size: 0.9rem; padding: 10px; }
    }

    /* small cosmetic */
    .container { max-width: 1200px; }
  </style>
</head>
<body>

  <!-- Navbar (kept as include, ensure navbar.jsp exists in same folder) -->
  <jsp:include page="navbar.jsp"/>

  <!-- Hero Section -->
  <div class="hero-section">
    <div>
      <h1>Stay Cool with <span>Power100</span></h1>
      <p>Trusted by 10,000+ Happy Families Across India</p>
      <div class="hero-buttons">
        <a href="products.jsp" class="btn-shop">🛒 Shop Now</a>
        <a href="contact.jsp" class="btn-contact">📞 Contact Us</a>
      </div>
    </div>
  </div>

  <!-- Featured Products -->
  <h2 class="section-title">✨ Featured Products</h2>
  <div id="featuredCarousel" class="carousel slide container" data-bs-ride="carousel">
    <div class="carousel-inner">

      <div class="carousel-item active text-center">
        <img src="images/cooler1.jpg" class="d-block w-100" alt="Cooler">
        <div class="carousel-caption">
          <h5>STRONG COOLER</h5>
          <p>₹11,880 | High performance cooler</p>
          <a href="productDetails.jsp?id=1" class="btn-view">View Details</a>
        </div>
      </div>

      <div class="carousel-item text-center">
        <img src="images/wash1.jpg" class="d-block w-100" alt="Washing Machine">
        <div class="carousel-caption">
          <h5>GRIHASTI WASHING MACHINE 6.5kg</h5>
          <p>₹15,500 | Smart washing machine</p>
          <a href="productDetails.jsp?id=2" class="btn-view">View Details</a>
        </div>
      </div>

      <div class="carousel-item text-center">
        <img src="images/tv1.jpg" class="d-block w-100" alt="Smart TV">
        <div class="carousel-caption">
          <h5>32" SMART FL VC+BT</h5>
          <p>₹16,900 | HD Smart TV</p>
          <a href="productDetails.jsp?id=3" class="btn-view">View Details</a>
        </div>
      </div>

    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#featuredCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#featuredCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>

  <!-- Why Choose Power100 -->
  <h2 class="section-title">💡 Why Choose Power100?</h2>
  <div class="container">
    <div class="row g-4">
      <div class="col-md-4">
        <div class="feature-card">
          <i class="fas fa-headset"></i>
          <h5>24x7 Support</h5>
          <p>Always available customer service for your comfort.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <i class="fas fa-tags"></i>
          <h5>Affordable Prices</h5>
          <p>Top-notch products with unbeatable pricing.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <i class="fas fa-users"></i>
          <h5>10,000+ Families</h5>
          <p>Trusted by happy customers all across India.</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Customer Testimonials -->
  <h2 class="section-title">🌟 What Our Customers Say</h2>
  <div id="testimonialCarousel" class="carousel slide container" data-bs-ride="carousel">
    <div class="carousel-inner">

      <!-- Review 1 -->
      <div class="carousel-item active">
        <div class="d-flex justify-content-center">
          <div class="card shadow-lg p-4 text-center testimonial-card">
            <img src="images/user1.jpg" alt="Customer" class="rounded-circle mx-auto mb-3" width="80" height="80" style="object-fit:cover;">
            <div class="mb-2 text-warning">⭐⭐⭐⭐⭐</div>
            <p class="fst-italic">"Power100 cooler ne meri garmi ki problem solve kar di. Bahut hi affordable aur powerful hai. Highly recommend!"</p>
            <h6 class="fw-bold text-primary">Rahul Sharma</h6>
            <small class="text-muted">Delhi</small>
          </div>
        </div>
      </div>

      <!-- Review 2 -->
      <div class="carousel-item">
        <div class="d-flex justify-content-center">
          <div class="card shadow-lg p-4 text-center testimonial-card">
            <img src="images/user2.jpg" alt="Customer" class="rounded-circle mx-auto mb-3" width="80" height="80" style="object-fit:cover;">
            <div class="mb-2 text-warning">⭐⭐⭐⭐☆</div>
            <p class="fst-italic">"Maine Power100 washing machine li aur bahut hi smooth aur smart features mile. Value for money!"</p>
            <h6 class="fw-bold text-success">Neha Verma</h6>
            <small class="text-muted">Lucknow</small>
          </div>
        </div>
      </div>

      <!-- Review 3 -->
      <div class="carousel-item">
        <div class="d-flex justify-content-center">
          <div class="card shadow-lg p-4 text-center testimonial-card">
            <img src="images/user3.jpg" alt="Customer" class="rounded-circle mx-auto mb-3" width="80" height="80" style="object-fit:cover;">
            <div class="mb-2 text-warning">⭐⭐⭐⭐⭐</div>
            <p class="fst-italic">"Smart TV experience mast hai. Display quality aur sound dono premium level ke hain. Power100 rocks!"</p>
            <h6 class="fw-bold text-danger">Amit Kumar</h6>
            <small class="text-muted">Mumbai</small>
          </div>
        </div>
      </div>

    </div>

    <!-- Controls -->
    <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>

    <!-- Progress bar -->
    <div class="progress-container mt-3">
      <div class="progress-bar-fill"></div>
    </div>
  </div>

  <!-- Footer -->
  <jsp:include page="footer.jsp"/>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    // testimonial carousel auto and progress reset
    const testimonialCarousel = document.querySelector('#testimonialCarousel');
    if (testimonialCarousel) {
      new bootstrap.Carousel(testimonialCarousel, { interval: 4000, ride: 'carousel' });
      testimonialCarousel.addEventListener('slid.bs.carousel', () => {
        const bar = document.querySelector('.progress-bar-fill');
        bar.style.animation = 'none';
        bar.offsetHeight;
        bar.style.animation = 'fillProgress 4s linear infinite';
      });
    }

    // featured carousel auto
    const myCarousel = document.querySelector('#featuredCarousel');
    if (myCarousel) {
      new bootstrap.Carousel(myCarousel, { interval: 3000, ride: 'carousel' });
    }
  </script>

</body>
</html>