<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Login - Power100</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark d-flex align-items-center justify-content-center" style="height:100vh;">
  <div class="card shadow-lg p-4" style="width:400px;">
    <h3 class="text-center text-primary">Admin Login</h3>
    <form action="adminLoginCheck.jsp" method="post">
      <div class="mb-3">
        <label class="form-label">Username</label>
        <input type="text" name="adminName" class="form-control" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" name="adminPass" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>
  </div>
</body>
</html>