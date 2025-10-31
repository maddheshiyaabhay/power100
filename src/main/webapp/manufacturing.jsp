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
    body {
      font-family: 'Segoe UI', sans-serif;
      background: #f8f9fa;
    }
    .section-title {
      text-align: center;
      margin: 50px 0 30px;
      font-size: 2.2rem;
      font-weight: bold;
      color: #0056b3;
      text-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    .para-box {
      background: #fff;
      padding: 25px;
      border-radius: 12px;
      box-shadow: 0 6px 18px rgba(0,0,0,0.1);
      margin-bottom: 30px;
    }
    .gallery img {
      border-radius: 10px;
      transition: transform 0.3s;
      box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }
    .gallery img:hover {
      transform: scale(1.05);
    }
    .video-frame {
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.3);
      overflow: hidden;
      background: #000;
    }

    /* Hero Banner */
    .manufacturing-hero {
      background: linear-gradient(rgba(0, 72, 173, 0.8), rgba(0, 0, 0, 0.7)),
                  url('images/factory-banner.jpg') no-repeat center center/cover;
      height: 40vh;
      border-bottom: 5px solid #FFD700;
      box-shadow: 0 5px 20px rgba(0,0,0,0.4);
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      color: #fff;
    }
    .manufacturing-hero h1 {
      font-size: 2.5rem;
      font-weight: bold;
      text-shadow: 0 2px 10px rgba(0,0,0,0.6);
    }
    .manufacturing-hero p {
      font-size: 1.2rem;
      margin-top: 10px;
      color: #FFD700;
    }

    /* Timeline */
    .timeline {
      position: relative;
      margin: 50px 0;
      padding-left: 40px;
    }
    .timeline::before {
      content: "";
      position: absolute;
      top: 0;
      bottom: 0;
      left: 20px;
      width: 4px;
      background: linear-gradient(#007bff, #6610f2);
      border-radius: 10px;
    }
    .timeline-item {
      position: relative;
      margin-bottom: 40px;
    }
    .timeline-item::before {
      content: "";
      position: absolute;
      left: -2px;
      top: 0;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      background: #ffd700;
      border: 3px solid #007bff;
    }
    .timeline-item h5 {
      font-weight: bold;
      color: #007bff;
    }
    .timeline-item p {
      margin: 0;
    }
    .hindi {
      font-family: "Noto Sans Devanagari", sans-serif;
      font-size: 0.95rem;
      color: #444;
    }
  </style>
</head>
<body>

<!-- ✅ Navbar Include -->
<jsp:include page="navbar.jsp"/>

<!-- ✅ Hero Banner -->
<div class="manufacturing-hero">
  <div>
    <h1>Our Manufacturing</h1>
    <p>Innovation • Quality • Trust</p>
  </div>
</div>

<div class="container">

  <!-- Title -->
  <h2 class="section-title"><i class="fa-solid fa-industry"></i> Our Manufacturing Excellence</h2>

  <!-- English Paragraph -->
  <div class="para-box">
    <h4 class="text-primary"></h4>
    <p>
      At <b>Power100 Home Appliances Pvt. Ltd.</b>, we operate one of the most advanced manufacturing units in Delhi.
      Our facilities are equipped with modern machinery, automated assembly lines, and a highly skilled workforce.
      Every product — whether it’s a <b>Cooler, Smart TV, or Washing Machine</b> — undergoes rigorous testing to ensure
      quality, durability, and energy efficiency. Our focus is not just on making appliances, but on creating
      <b>innovative, eco-friendly, and affordable solutions</b> for every household in India.
    </p>
  </div>

  <!-- Hindi Paragraph -->
  <div class="para-box">
    <h4 class="text-danger"></h4>
    <p>
      <b>पावर100 होम अप्लायंसेस प्रा. लि.</b> में हमारा मैन्युफैक्चरिंग यूनिट दिल्ली में स्थित है और यह नवीनतम
      मशीनरी और अत्याधुनिक तकनीक से सुसज्जित है। हमारी फैक्ट्री में बने हर <b>कूलर, स्मार्ट टीवी और वॉशिंग मशीन</b>
      को उच्च गुणवत्ता, मजबूती और ऊर्जा दक्षता के लिए परखा जाता है।
      हमारा लक्ष्य केवल उपकरण बनाना नहीं, बल्कि हर घर के लिए <b>नवाचारपूर्ण, पर्यावरण अनुकूल और किफायती समाधान</b> देना है।
    </p>
  </div>

  <!-- Timeline -->
  <h2 class="section-title">⚙ Manufacturing Process</h2>
  <div class="timeline">
    <div class="timeline-item">
      <h5>Step 1: Raw Material Selection</h5>
      <p>We source only the highest quality raw materials to ensure durability and performance in every product.</p>
      <p class="hindi">चरण 1: हम केवल उच्च गुणवत्ता वाले कच्चे माल का चयन करते हैं ताकि हर उत्पाद टिकाऊ और बेहतर प्रदर्शन वाला हो।</p>
    </div>
    <div class="timeline-item">
      <h5>Step 2: Automated Assembly</h5>
      <p>State-of-the-art assembly lines guarantee precision and consistency in every cooler, TV, and washing machine.</p>
      <p class="hindi">चरण 2: अत्याधुनिक असेंबली लाइनें हर कूलर, टीवी और वॉशिंग मशीन में सटीकता और समान गुणवत्ता सुनिश्चित करती हैं।</p>
    </div>
    <div class="timeline-item">
      <h5>Step 3: Quality Testing</h5>
      <p>Each product undergoes multiple rounds of testing for safety, energy efficiency, and long-lasting performance.</p>
      <p class="hindi">चरण 3: हर उत्पाद को सुरक्षा, ऊर्जा दक्षता और लंबे समय तक चलने वाले प्रदर्शन के लिए कई परीक्षणों से गुजारा जाता है।</p>
    </div>
    <div class="timeline-item">
      <h5>Step 4: Packaging & Delivery</h5>
      <p>Products are securely packaged and dispatched across India with a strong focus on timely delivery.</p>
      <p class="hindi">चरण 4: उत्पादों को सुरक्षित रूप से पैक किया जाता है और पूरे भारत में समय पर डिलीवरी सुनिश्चित की जाती है।</p>
    </div>
  </div>

  <!-- Gallery -->
  <h2 class="section-title">📸 Photo Gallery</h2>
  <div class="row gallery">
    <div class="col-md-3 col-6 mb-4">
      <img src="images/factory1.jpg" class="img-fluid" alt="Factory 1">
    </div>
    <div class="col-md-3 col-6 mb-4">
      <img src="images/factory2.jpg" class="img-fluid" alt="Factory 2">
    </div>
    <div class="col-md-3 col-6 mb-4">
      <img src="images/factory3.jpg" class="img-fluid" alt="Factory 3">
    </div>
    <div class="col-md-3 col-6 mb-4">
      <img src="images/factory4.jpg" class="img-fluid" alt="Factory 4">
    </div>
  </div>

  <!-- Videos -->
  <h2 class="section-title">🎥 Manufacturing Videos</h2>
  <div class="row">
    <div class="col-md-6 mb-4">
      <div class="video-frame">
        <video width="100%" height="315" controls>
          <source src="videos/manufacturing1.mp4" type="video/mp4">
          Your browser does not support the video tag.
        </video>
      </div>
    </div>
    <div class="col-md-6 mb-4">
      <div class="video-frame">
        <video width="100%" height="315" controls>
          <source src="videos/manufacturing2.mp4" type="video/mp4">
          Your browser does not support the video tag.
        </video>
      </div>
    </div>
  </div>

</div>

<!-- ✅ Footer Include -->
<jsp:include page="footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>