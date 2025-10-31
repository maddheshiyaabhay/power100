<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Power100 Home Appliances Pvt. Ltd.</title>

  <!-- ✅ Favicon (replace with your logo file in images folder) -->
  <link rel="icon" type="image/png" href="images/logo.png">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    body { background: #f8f9fa; }

    .section-title {
      font-weight: bold;
      text-align: center;
      margin: 40px 0 20px;
      font-size: 2rem;
      color: #0056b3;
      text-transform: uppercase;
      text-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .about-card {
      background: #fff;
      border-radius: 15px;
      padding: 25px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.15);
      transition: all 0.3s ease-in-out;
      height: 100%;
    }
    .about-card:hover {
      transform: translateY(-8px) scale(1.02);
      box-shadow: 0 15px 30px rgba(0,0,0,0.25);
    }

    .about-card i {
      font-size: 2.2rem;
      color: #FFD700;
      margin-bottom: 15px;
    }

    .timeline {
      position: relative;
      margin: 40px auto;
      padding: 0;
      list-style: none;
    }
    .timeline::before {
      content: '';
      position: absolute;
      left: 50%;
      width: 4px;
      height: 100%;
      background: #007bff;
      transform: translateX(-50%);
    }
    .timeline-item {
      position: relative;
      width: 50%;
      padding: 20px 40px;
    }
    .timeline-item.left { left: 0; text-align: right; }
    .timeline-item.right { left: 50%; }
    .timeline-item::before {
      content: '';
      position: absolute;
      top: 30px;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      background: #FFD700;
      border: 3px solid #007bff;
    }
    .timeline-item.left::before { right: -10px; }
    .timeline-item.right::before { left: -10px; }
    .timeline-content {
      background: #fff;
      padding: 20px;
      border-radius: 12px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.1);
    }

    .hindi {
      font-family: "Noto Sans Devanagari", sans-serif;
      font-size: 0.95rem;
      color: #444;
    }

    .about-card .social-icons a {
      margin: 0 8px;
      font-size: 1.3rem;
      color: #555;
      transition: 0.3s;
    }
    .about-card .social-icons a:hover {
      color: #007bff;
      transform: scale(1.2);
    }

    /* ✅ MOBILE RESPONSIVE FIXES */
    @media (max-width: 992px) {
      .section-title { font-size: 1.7rem; }
    }

    @media (max-width: 768px) {
      .timeline::before { left: 8px; }
      .timeline-item {
        width: 100%;
        padding-left: 40px;
        padding-right: 0;
        text-align: left !important;
      }
      .timeline-item::before {
        left: 0;
        right: auto;
      }
      .timeline-item.left, .timeline-item.right {
        left: 0;
      }
      .timeline-content {
        margin-left: 20px;
      }
      .about-card {
        margin-bottom: 20px;
      }
    }

    @media (max-width: 480px) {
      .section-title { font-size: 1.4rem; }
      .about-card p { font-size: 0.9rem; }
    }
  </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container">
  <h2 class="section-title">About Power100 Home Appliances Pvt. Ltd.</h2>

  <div class="row mb-5">
    <div class="col-md-10 mx-auto text-center">
      <p class="lead">
        We are a leading manufacturer of <b>Coolers</b>, <b>Smart TVs</b>, and <b>Washing Machines</b> with
        state-of-the-art facilities in Delhi. Power100 is committed to delivering high-quality, affordable,
        and durable appliances that bring comfort to every home in India.
      </p>
      <p class="hindi">
        हम दिल्ली स्थित एक प्रमुख निर्माता हैं जो <b>कूलर</b>, <b>स्मार्ट टीवी</b>, और <b>वॉशिंग मशीन</b> का उत्पादन करते हैं।
        पावर100 का उद्देश्य है कि हर भारतीय परिवार को उच्च गुणवत्ता वाले, किफायती और टिकाऊ उपकरण उपलब्ध कराए जाएं।
      </p>
    </div>
  </div>

  <div class="row text-center g-4 mb-5">
    <div class="col-md-4">
      <div class="about-card">
        <i class="fa fa-bullseye"></i>
        <h5>Our Vision</h5>
        <p>To become a household name by delivering innovation, quality, and trust.</p>
        <p class="hindi">नवाचार, गुणवत्ता और विश्वास के साथ हर घर का हिस्सा बनना।</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="about-card">
        <i class="fa fa-flag"></i>
        <h5>Our Mission</h5>
        <p>To provide reliable appliances at affordable prices with unmatched after-sales service.</p>
        <p class="hindi">विश्वसनीय उपकरण किफायती दामों पर उपलब्ध कराना और बेहतरीन बिक्री के बाद सेवा देना।</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="about-card">
        <i class="fa fa-heart"></i>
        <h5>Our Values</h5>
        <p>Integrity, Customer Satisfaction, and Constant Innovation.</p>
        <p class="hindi">ईमानदारी, ग्राहक संतुष्टि और निरंतर नवाचार।</p>
      </div>
    </div>
  </div>

  <h2 class="section-title">Our Journey</h2>
  <ul class="timeline">
    <li class="timeline-item left">
      <div class="timeline-content">
        <h6>2010 - Foundation</h6>
        <p>Power100 started its journey with innovative coolers in Delhi.</p>
        <p class="hindi">2010 में पावर100 ने दिल्ली से कूलरों के साथ अपनी यात्रा शुरू की।</p>
      </div>
    </li>
    <li class="timeline-item right">
      <div class="timeline-content">
        <h6>2015 - Expansion</h6>
        <p>Introduced Washing Machines and expanded across North India.</p>
        <p class="hindi">2015 में वॉशिंग मशीन लॉन्च की और उत्तर भारत में विस्तार किया।</p>
      </div>
    </li>
    <li class="timeline-item left">
      <div class="timeline-content">
        <h6>2020 - Smart TVs</h6>
        <p>Entered the smart home segment with premium Smart TVs.</p>
        <p class="hindi">2020 में स्मार्ट टीवी लॉन्च कर स्मार्ट होम सेगमेंट में कदम रखा।</p>
      </div>
    </li>
    <li class="timeline-item right">
      <div class="timeline-content">
        <h6>2025 - Trusted Nationwide</h6>
        <p>Power100 is trusted by over <b>10,000+ families across India</b>.</p>
        <p class="hindi">2025 तक, पावर100 पर भारत के <b>10,000+ परिवारों</b> का विश्वास है।</p>
      </div>
    </li>
  </ul>
</div>

<h2 class="section-title">Meet Our Team</h2>
<div id="teamCarousel" class="carousel slide container mb-5" data-bs-ride="carousel">
  <div class="carousel-inner">

    <div class="carousel-item active">
      <div class="d-flex justify-content-center">
        <div class="about-card text-center p-4 shadow-lg" style="max-width:700px; border-radius:20px;">
          <img src="images/team1.jpg" alt="Founder" class="rounded-circle mb-3 shadow" style="width:120px; height:120px; object-fit:cover;">
          <h5 class="fw-bold text-primary">Aman Maddheshiya</h5>
          <p class="text-muted">Founder & CEO</p>
          <p>Visionary leader behind Power100. <span class="hindi">पावर100 के संस्थापक — नवाचार पर केंद्रित।</span></p>
          <div class="social-icons">
            <a href="#"><i class="fab fa-linkedin"></i></a>
            <a href="#"><i class="fab fa-facebook"></i></a>
          </div>
        </div>
      </div>
    </div>

    <div class="carousel-item">
      <div class="d-flex justify-content-center">
        <div class="about-card text-center p-4 shadow-lg" style="max-width:700px; border-radius:20px;">
          <img src="images/team2.jpg" alt="Manager" class="rounded-circle mb-3 shadow" style="width:120px; height:120px; object-fit:cover;">
          <h5 class="fw-bold text-success">Ravi Kumar</h5>
          <p class="text-muted">Operations Manager</p>
          <p>Handles manufacturing & supply chain. <span class="hindi">समय पर डिलीवरी सुनिश्चित करते हैं।</span></p>
          <div class="social-icons">
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-twitter"></i></a>
          </div>
        </div>
      </div>
    </div>

    <div class="carousel-item">
      <div class="d-flex justify-content-center">
        <div class="about-card text-center p-4 shadow-lg" style="max-width:700px; border-radius:20px;">
          <img src="images/team3.jpg" alt="Support Head" class="rounded-circle mb-3 shadow" style="width:120px; height:120px; object-fit:cover;">
          <h5 class="fw-bold text-danger">Pooja Sharma</h5>
          <p class="text-muted">Customer Support Head</p>
          <p>Leads 24x7 support team. <span class="hindi">बेहतरीन आफ्टर-सेल्स सेवा सुनिश्चित करती हैं।</span></p>
          <div class="social-icons">
            <a href="#"><i class="fab fa-whatsapp"></i></a>
            <a href="#"><i class="fab fa-facebook"></i></a>
          </div>
        </div>
      </div>
    </div>

  </div>

  <button class="carousel-control-prev" type="button" data-bs-target="#teamCarousel" data-bs-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#teamCarousel" data-bs-slide="next">
    <span class="carousel-control-next-icon"></span>
  </button>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const teamCarousel = document.querySelector('#teamCarousel');
  new bootstrap.Carousel(teamCarousel, { interval: 4000, ride: 'carousel' });
</script>

<jsp:include page="footer.jsp"/>
</body>
</html>