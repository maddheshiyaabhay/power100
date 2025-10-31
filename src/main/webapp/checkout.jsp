<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: #f1f3f6; }
        .checkout-card { border-radius: 15px; background: #fff; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .btn-3d { border-radius: 25px; box-shadow: 0 5px #999; transition: 0.2s; }
        .btn-3d:hover { transform: translateY(-3px); }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp"/>

<div class="container mt-5">
    <h2><i class="fa fa-credit-card text-success"></i> Checkout</h2>
    <div class="checkout-card p-4">
        <form action="placeOrder.jsp" method="post">
            <h4>Shipping Information</h4>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <input type="text" name="fullname" class="form-control" placeholder="Full Name" required>
                </div>
                <div class="col-md-6 mb-3">
                    <input type="text" name="phone" class="form-control" placeholder="Phone Number" required>
                </div>
                <div class="col-md-12 mb-3">
                    <textarea name="address" class="form-control" placeholder="Full Address" required></textarea>
                </div>
                <div class="col-md-4 mb-3">
                    <input type="text" name="city" class="form-control" placeholder="City" required>
                </div>
                <div class="col-md-4 mb-3">
                    <input type="text" name="state" class="form-control" placeholder="State" required>
                </div>
                <div class="col-md-4 mb-3">
                    <input type="text" name="pincode" class="form-control" placeholder="Pincode" required>
                </div>
            </div>

            <h4>Payment Method</h4>
            <div class="mb-3">
                <select class="form-control" name="payment" required>
                    <option value="">--Select Payment--</option>
                    <option value="COD">Cash on Delivery</option>
                    <option value="UPI">UPI</option>
                    <option value="Card">Credit/Debit Card</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success btn-3d w-100">
                <i class="fa fa-check"></i> Place Order
            </button>
        </form>
    </div>
</div>

<jsp:include page="footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>