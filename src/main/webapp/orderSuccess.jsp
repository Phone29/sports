<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.success-container {
	text-align: center;
	background: #fff;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.success-icon {
	color: #28a745;
	font-size: 80px;
	margin-bottom: 20px;
}

.success-message {
	font-size: 24px;
	color: #333;
	margin-bottom: 20px;
}

.back-link {
	font-size: 18px;
	color: #007bff;
	text-decoration: none;
}

.back-link:hover {
	text-decoration: underline;
}
</style>
</head>
<body>
	<div class="container text-center my-5">
		<div class="card p-5 shadow border-0">
			<h1 class="text-success">Order Placed Successfully!</h1>
			<p>Thank you for your purchase. Your order is being processed.</p>
			<a href="home" class="btn btn-primary mt-3">Back to Home</a>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
