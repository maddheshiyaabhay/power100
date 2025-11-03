<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%@ include file="dbConnection.jsp" %>
<%@ include file="navbar.jsp" %>


<%
    request.setCharacterEncoding("UTF-8");
    String ctx = request.getContextPath();

    // Query params
    String q       = request.getParameter("q");       // search
    String cat     = request.getParameter("cat");     // category
    String minStr  = request.getParameter("min");     // min price
    String maxStr  = request.getParameter("max");     // max price
    String sort    = request.getParameter("sort");    // sort key

    Double minPrice = null, maxPrice = null;
    try { if (minStr != null && !minStr.trim().isEmpty()) minPrice = Double.parseDouble(minStr.trim()); } catch(Exception ignore){}
    try { if (maxStr != null && !maxStr.trim().isEmpty()) maxPrice = Double.parseDouble(maxStr.trim()); } catch(Exception ignore){}

    // Build SQL (PreparedStatement) safely
    StringBuilder sql = new StringBuilder(
        "SELECT id, name, category, price, description, image_url, rating, reviews FROM products WHERE 1=1"
    );
    List<Object> params = new ArrayList<Object>();

    if (q != null && !q.trim().isEmpty()) {
        sql.append(" AND (name LIKE ? OR category LIKE ? OR description LIKE ?)");
        String like = "%" + q.trim() + "%";
        params.add(like); params.add(like); params.add(like);
    }
    if (cat != null && !cat.trim().isEmpty()) {
        sql.append(" AND category = ?");
        params.add(cat.trim());
    }
    if (minPrice != null) { sql.append(" AND price >= ?"); params.add(minPrice); }
    if (maxPrice != null) { sql.append(" AND price <= ?"); params.add(maxPrice); }

    if ("price_asc".equalsIgnoreCase(sort)) {
        sql.append(" ORDER BY price ASC");
    } else if ("price_desc".equalsIgnoreCase(sort)) {
        sql.append(" ORDER BY price DESC");
    } else if ("rating_desc".equalsIgnoreCase(sort)) {
        sql.append(" ORDER BY rating DESC, reviews DESC");
    } else {
        sql.append(" ORDER BY name ASC");
    }

    // SAFER: fetch connection from session attribute put there by dbConnection.jsp
    Connection conn = null;
    String errorMsg = null;
    Object dbObj = session.getAttribute("dbConn");
    if (dbObj != null && dbObj instanceof java.sql.Connection) {
        conn = (Connection) dbObj;
    } else {
        // If dbConnection.jsp failed to create connection it stored error there
        Object eMsg = session.getAttribute("dbConnError");
        if (eMsg != null) {
            errorMsg = String.valueOf(eMsg);
        } else {
            errorMsg = "Database connection not found. (Check dbConnection.jsp)";
        }
    }

    List<Map<String,Object>> items = new ArrayList<Map<String,Object>>();

    if (conn == null) {
        // leave items empty and show error later
    } else {
        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            for (int i=0;i<params.size();i++) {
                Object v = params.get(i);
                if (v instanceof Double) ps.setDouble(i+1, (Double)v);
                else ps.setString(i+1, String.valueOf(v));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String,Object> row = new HashMap<String,Object>();
                row.put("id",          rs.getInt("id"));
                row.put("name",        rs.getString("name"));
                row.put("category",    rs.getString("category"));
                row.put("price",       rs.getDouble("price"));
                row.put("description", rs.getString("description"));
                row.put("image_url",   rs.getString("image_url"));
                row.put("rating",      rs.getBigDecimal("rating"));   // DECIMAL(2,1)
                row.put("reviews",     rs.getInt("reviews"));
                items.add(row);
            }
            rs.close(); ps.close();
        } catch (Exception e) {
            errorMsg = "Error loading products: " + e.getMessage();
        }
    }

    NumberFormat INR = NumberFormat.getCurrencyInstance(new Locale("en","IN"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Our Premium Products</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
  body{background:radial-gradient(1200px circle at 20% 0%, #eef6ff 0, #f7fbff 35%, #ffffff 70%);
       font-family:"Segoe UI",system-ui,Roboto,Arial,sans-serif;}
  .page-title{font-weight:800; letter-spacing:.5px; display:flex; align-items:center; gap:.6rem;}
  .page-title i{background:#0d6efd;color:#fff;padding:.6rem;border-radius:12px;box-shadow:0 8px 20px rgba(13,110,253,.25);}
  .filter-bar{backdrop-filter:blur(8px); background:rgba(255,255,255,.85); border:1px solid #e0eef7;
              border-radius:14px; box-shadow:0 10px 24px rgba(15,23,42,.05); padding:.8rem;}
  .filter-bar .form-control,.filter-bar .form-select{border-radius:12px;}
  .filter-bar .btn{border-radius:12px;}

  .grid{display:grid; grid-template-columns:repeat(3,1fr); gap:1.25rem;}
  @media (min-width:1400px){ .grid{grid-template-columns:repeat(4,1fr);} }
  @media (max-width:991px){ .grid{grid-template-columns:1fr; gap:1rem;} }

  .p-card{border:0;border-radius:18px;overflow:hidden;background:#fff;box-shadow:0 18px 40px rgba(2,36,80,.10);
          transition:transform .18s ease, box-shadow .18s ease;}
  .p-card:hover{transform:translateY(-4px) rotateX(1deg); box-shadow:0 22px 60px rgba(2,36,80,.18);}
  .p-img-wrap{position:relative; overflow:hidden; height:220px; background:#f3f6fb;}
  .p-img{width:100%; height:100%; object-fit:cover; display:block;}
  .chip{position:absolute; top:12px; left:12px; background:rgba(13,110,253,.9); color:#fff;
        font-size:.75rem; padding:.25rem .55rem; border-radius:999px;}

  .p-name{font-weight:700; margin-bottom:.25rem;}
  .p-desc{color:#5b7083; font-size:.925rem; min-height:44px;}
  .price{color:#059e4b; font-weight:800;}
  .stars i{color:#f59e0b;}
  .empty-state{border:2px dashed #dbeafe; border-radius:16px; padding:2rem; color:#64748b;background:#f8fbff;}
</style>
</head>
<body>

<div class="container py-4 py-md-5">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2 class="page-title mb-0"><i class="fa-solid fa-gift"></i> Our Premium Products</h2>
    <span class="badge bg-light text-dark border"><i class="fa-solid fa-boxes-stacked me-1"></i><%= items.size() %> items</span>
  </div>

  <!-- Single row filter -->
  <form class="filter-bar mb-4" method="get" action="<%= ctx %>/products.jsp">
    <div class="row g-2 align-items-center">
      <div class="col-12 col-lg-4">
        <div class="input-group">
          <span class="input-group-text"><i class="fa-solid fa-magnifying-glass"></i></span>
          <input name="q" value="<%= (q==null?"":q) %>" class="form-control" placeholder="Search products (Cooler, TV, Washing...)" />
        </div>
      </div>
      <div class="col-6 col-lg-2">
        <select name="cat" class="form-select">
          <option value="">All Categories</option>
          <option value="TV" <%= "TV".equals(cat)?"selected":"" %>>TV</option>
          <option value="Cooler" <%= "Cooler".equals(cat)?"selected":"" %>>Cooler</option>
          <option value="Washing Machine" <%= "Washing Machine".equals(cat)?"selected":"" %>>Washing Machine</option>
        </select>
      </div>
      <div class="col-3 col-lg-2">
        <div class="input-group">
          <span class="input-group-text">Min </span>
          <input name="min" value="<%= (minStr==null?"":minStr) %>" class="form-control" inputmode="decimal">
        </div>
      </div>
      <div class="col-3 col-lg-2">
        <div class="input-group">
          <span class="input-group-text">Max </span>
          <input name="max" value="<%= (maxStr==null?"":maxStr) %>" class="form-control" inputmode="decimal">
        </div>
      </div>
      <div class="col-6 col-lg-1">
        <select name="sort" class="form-select">
          <option value="">Sort: Name</option>
          <option value="price_asc"  <%= "price_asc".equals(sort) ?"selected":"" %>>Price Low</option>
          <option value="price_desc" <%= "price_desc".equals(sort)?"selected":"" %>>Price High</option>
          <option value="rating_desc"<%= "rating_desc".equals(sort)?"selected":"" %>>Top Rated</option>
        </select>
      </div>
      <div class="col-6 col-lg-1 d-grid">
        <button class="btn btn-primary"><i class="fa-solid fa-filter me-1"></i> Apply</button>
      </div>
    </div>
  </form>

  <% if (errorMsg != null) { %>
    <div class="alert alert-danger"><%= errorMsg %></div>
  <% } %>

  <% if (items.isEmpty() && errorMsg == null) { %>
    <div class="empty-state text-center">
      <i class="fa-regular fa-face-frown-open fa-2x mb-2"></i>
      <div class="fw-bold mb-1">No products found</div>
      Try clearing filters or search with a different keyword.
    </div>
  <% } %>

  <div class="grid">
    <% for (Map<String,Object> it : items) {
        int    id       = (Integer) it.get("id");
        String name     = String.valueOf(it.get("name"));
        String category = String.valueOf(it.get("category"));
        double price    = (Double) it.get("price");
        String desc     = String.valueOf(it.get("description"));

        String imageUrl = String.valueOf(it.get("image_url"));
        String imgSrc;
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            imgSrc = ctx + "/images/placeholder.jpg";
        } else if (imageUrl.contains("/")) {
            imgSrc = (imageUrl.startsWith("http")) ? imageUrl : (ctx + "/" + imageUrl);
        } else {
            imgSrc = ctx + "/images/" + imageUrl;
        }

        String rating = String.valueOf(it.get("rating"));
        int    reviews= (Integer) it.get("reviews");
    %>
      <div class="card p-card">
        <div class="p-img-wrap">
          <img class="p-img" src="<%= imgSrc %>" alt="<%= name %>"
               onerror="this.onerror=null;this.src='<%= ctx %>/images/placeholder.jpg';">
          <span class="chip"><i class="fa-solid fa-tag me-1"></i><%= category %></span>
        </div>
        <div class="card-body">
          <h5 class="p-name mb-1"><%= name %></h5>
          <span class="stars d-flex align-items-center gap-2 mb-2">
            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
            <i class="fa-regular fa-star"></i>
            <small class="text-muted"><%= rating %>/5  <%= reviews %> reviews</small>
          </span>
          <p class="p-desc mb-3"><%= desc %></p>

          <div class="d-flex justify-content-between align-items-center">
            <div class="price"><%= INR.format(price) %></div>
            <div class="d-flex gap-2">
              <a class="btn btn-outline-secondary btn-sm"
                 href="<%= ctx %>/productDetails.jsp?id=<%= id %>">
                 <i class="fa-solid fa-eye me-1"></i> View
              </a>
              <a class="btn btn-success btn-sm"
                 href="<%= ctx %>/addToCart.jsp?id=<%= id %>">
                 <i class="fa-solid fa-cart-plus me-1"></i> Cart
              </a>
            </div>
          </div>
        </div>
      </div>
    <% } %>
  </div>
</div>

<%@ include file="footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>