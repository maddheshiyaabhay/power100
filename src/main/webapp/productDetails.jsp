<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%@ include file="dbConnection.jsp" %>
<%@ include file="navbar.jsp" %>

<%
  request.setCharacterEncoding("UTF-8");
  String ctx = request.getContextPath();
  NumberFormat INR = NumberFormat.getCurrencyInstance(new Locale("en","IN"));

  int pid = 0;
  try { pid = Integer.parseInt(request.getParameter("id")); } catch(Exception ignore){}
  if (pid <= 0) { response.sendRedirect(ctx + "/products.jsp"); return; }

  Connection conn = (Connection) session.getAttribute("dbConn");
  String err = null, flash = null;

  String name=null, category=null, description=null, imageUrl=null;
  double price=0, ratingVal=0; int reviewsCount=0;

  if (conn == null) {
      err = "Database connection not found.";
  } else {
      try {
          PreparedStatement ps = conn.prepareStatement(
              "SELECT id,name,category,price,description,image_url,rating,reviews FROM products WHERE id=?");
          ps.setInt(1, pid);
          ResultSet rs = ps.executeQuery();
          if (rs.next()) {
              name = rs.getString("name");
              category = rs.getString("category");
              price = rs.getDouble("price");
              description = rs.getString("description");
              imageUrl = rs.getString("image_url");
              try { ratingVal = rs.getBigDecimal("rating").doubleValue(); } catch(Exception ignore){}
              reviewsCount = rs.getInt("reviews");
          } else {
              err = "Product not found.";
          }
          rs.close(); ps.close();
      } catch(Exception e) { err = "Error loading product: " + e.getMessage(); }
  }

  // Robust image src
  String imgSrc;
  if (imageUrl == null || imageUrl.trim().isEmpty()) {
      imgSrc = ctx + "/images/placeholder.jpg";
  } else if (imageUrl.contains("/")) {
      imgSrc = (imageUrl.startsWith("http")) ? imageUrl : (ctx + "/" + imageUrl);
  } else {
      imgSrc = ctx + "/images/" + imageUrl;
  }

  // Handle new review submit
  if ("POST".equalsIgnoreCase(request.getMethod()) && conn != null && err == null) {
      String customerName = request.getParameter("customer_name");
      String rv = request.getParameter("review");
      String rStr = request.getParameter("rating");
      double rVal = 0;
      try { rVal = Double.parseDouble(rStr); } catch(Exception ignore){}
      if (customerName == null || customerName.trim().isEmpty()) customerName = "Anonymous";

      try {
          PreparedStatement ps = null;
          try {
              ps = conn.prepareStatement(
                "INSERT INTO reviews (product_id, customer_name, rating, review) VALUES (?,?,?,?)");
          } catch(Exception e1) {
              try { ps = conn.prepareStatement(
                "INSERT INTO reviews (product_id, full_name, rating, review) VALUES (?,?,?,?)"); }
              catch(Exception e2) {
                  try { ps = conn.prepareStatement(
                    "INSERT INTO reviews (product_id, fullname, rating, review) VALUES (?,?,?,?)"); }
                  catch(Exception e3) {
                      ps = conn.prepareStatement(
                        "INSERT INTO reviews (product_id, name, rating, review) VALUES (?,?,?,?)");
                  }
              }
          }
          ps.setInt(1, pid);
          ps.setString(2, customerName.trim());
          ps.setDouble(3, rVal);
          ps.setString(4, rv==null?null:rv.trim());
          ps.executeUpdate();
          ps.close();
          flash = "Thanks! Your review was submitted.";
      } catch(Exception ex) { err = "Review insert failed: " + ex.getMessage(); }
  }

  // Load reviews (any column name variants)
  List<Map<String,Object>> reviewList = new ArrayList<Map<String,Object>>();
  if (conn != null && err == null) {
      try {
          PreparedStatement ps = conn.prepareStatement(
            "SELECT * FROM reviews WHERE product_id=? ORDER BY created_at DESC");
          ps.setInt(1, pid);
          ResultSet rs = ps.executeQuery();
          while (rs.next()) {
              Map<String,Object> r = new HashMap<String,Object>();
              String cname = null;
              try { cname = rs.getString("customer_name"); } catch(Exception ignore){}
              if (cname == null) { try { cname = rs.getString("full_name"); } catch(Exception ignore){} }
              if (cname == null) { try { cname = rs.getString("fullname"); } catch(Exception ignore){} }
              if (cname == null) { try { cname = rs.getString("name"); } catch(Exception ignore){} }
              if (cname == null) cname = "Anonymous";

              double rVal = 0; try { rVal = rs.getDouble("rating"); } catch(Exception ignore){}
              String rText = null; try { rText = rs.getString("review"); } catch(Exception ignore){}
              java.sql.Timestamp ts = null; try { ts = rs.getTimestamp("created_at"); } catch(Exception ignore){}

              r.put("customer_name", cname);
              r.put("rating", rVal);
              r.put("review", rText);
              r.put("created_at", ts);
              reviewList.add(r);
          }
          rs.close(); ps.close();
      } catch(Exception ex){ err = "Error loading reviews: " + ex.getMessage(); }
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title><%= (name==null?"Product":name) %> – Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
  body{background:#f7fbff;}
  .page-title{font-weight:800;}
  .stars i{color:#f59e0b;}
  .badge-soft{background:#eef6ff; color:#0d6efd; border:1px solid #cfe3ff; border-radius:999px; padding:.25rem .6rem;}
</style>
</head>
<body>

<div class="container py-4 py-md-5">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <a class="btn btn-outline-secondary btn-sm" href="<%= ctx %>/products.jsp">
      <i class="fa-solid fa-arrow-left-long me-1"></i>Back to Products
    </a>
    <h3 class="page-title mb-0"><i class="fa-solid fa-box-open me-2 text-primary"></i>Product Details</h3>
    <span></span>
  </div>

  <% if (err != null) { %>
    <div class="alert alert-danger"><%= err %></div>
  <% } %>
  <% if (flash != null) { %>
    <div class="alert alert-success"><%= flash %></div>
  <% } %>

  <% if (err == null) { %>
  <div class="row g-4">
    <div class="col-md-5">
      <img src="<%= imgSrc %>" alt="<%= name %>" class="img-fluid rounded shadow-sm"
           onerror="this.onerror=null;this.src='<%= ctx %>/images/placeholder.jpg';">
    </div>
    <div class="col-md-7">
      <div class="d-flex align-items-center gap-2 mb-2">
        <span class="badge-soft"><i class="fa-solid fa-tag me-1"></i><%= category %></span>
      </div>
      <h3 class="mb-2"><%= name %></h3>
      <div class="d-flex align-items-center gap-2 mb-2">
        <div class="stars">
          <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
          <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
          <i class="fa-regular fa-star"></i>
        </div>
        <small class="text-muted"><%= ratingVal %>/5  <%= reviewsCount %> reviews</small>
      </div>
      <p class="text-secondary"><%= description %></p>

      <div class="d-flex align-items-center justify-content-between mt-3">
        <div class="fs-3 fw-bold text-success"><%= INR.format(price) %></div>
        <div class="d-flex gap-2">
          <a class="btn btn-success" href="<%= ctx %>/addToCart.jsp?id=<%= pid %>">
            <i class="fa-solid fa-cart-plus me-1"></i>Add to Cart
          </a>
          <a class="btn btn-primary" href="<%= ctx %>/checkout.jsp?productId=<%= pid %>">
            <i class="fa-solid fa-bolt me-1"></i>Buy Now
          </a>
        </div>
      </div>
    </div>
  </div>

  <hr class="my-4">

  <div class="row g-4">
    <!-- Reviews list -->
    <div class="col-md-7">
      <h5 class="mb-3"><i class="fa-regular fa-comments me-2"></i>Customer Reviews</h5>
      <% if (reviewList.isEmpty()) { %>
        <div class="alert alert-info">No reviews yet. Be the first to review!</div>
      <% } else { %>
        <ul class="list-group">
          <% for (Map<String,Object> r : reviewList) { %>
            <li class="list-group-item">
              <div class="d-flex justify-content-between">
                <strong><%= r.get("customer_name") %></strong>
                <span class="text-warning">
                  <i class="fa-solid fa-star"></i> <%= r.get("rating") %>
                </span>
              </div>
              <div class="small text-muted">
                <%
                  java.sql.Timestamp ts = (java.sql.Timestamp) r.get("created_at");
                  String when = (ts==null) ? "" : new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(ts);
                %>
                <%= when %>
              </div>
              <div><%= r.get("review")==null?"":r.get("review") %></div>
            </li>
          <% } %>
        </ul>
      <% } %>
    </div>

    <!-- Write review -->
    <div class="col-md-5">
      <h5 class="mb-3"><i class="fa-regular fa-pen-to-square me-2"></i>Write a Review</h5>
      <form method="post" action="<%= ctx %>/productDetails.jsp?id=<%= pid %>">
        <div class="mb-2">
          <label class="form-label">Your Name</label>
          <input name="customer_name" class="form-control" placeholder="Your name">
        </div>
        <div class="mb-2">
          <label class="form-label">Rating</label>
          <select name="rating" class="form-select">
            <option value="5">5</option><option value="4.5">4.5</option><option value="4">4</option>
            <option value="3.5">3.5</option><option value="3">3</option><option value="2.5">2.5</option>
            <option value="2">2</option><option value="1.5">1.5</option><option value="1">1</option>
          </select>
        </div>
        <div class="mb-3">
          <label class="form-label">Review</label>
          <textarea name="review" rows="3" class="form-control" placeholder="Write your review..."></textarea>
        </div>
        <button class="btn btn-primary"><i class="fa-solid fa-paper-plane me-1"></i>Submit Review</button>
      </form>
    </div>
  </div>
  <% } %>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>