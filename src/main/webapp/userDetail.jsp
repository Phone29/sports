<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile - ${u.name}</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	background-color: #f5f6fa;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.sidebar {
	height: 100vh;
	background: #343a40;
	color: #fff;
}

.sidebar a {
	color: #ddd;
	text-decoration: none;
	display: block;
	padding: 12px 20px;
	border-bottom: 1px solid #495057;
}

.sidebar a:hover {
	background: #495057;
	color: #fff;
}

.profile-header {
	background: linear-gradient(135deg, #1a1a1a 0%, #343a40 100%);
	height: 150px;
	border-radius: 12px 12px 0 0;
}

.profile-img-container {
	margin-top: -75px;
}

.profile-img {
	width: 150px;
	height: 150px;
	object-fit: cover;
	border: 5px solid #fff;
	background-color: #fff;
}

.info-card {
	border-radius: 12px;
	border: none;
	transition: 0.3s;
}

.info-label {
	color: #6c757d;
	font-weight: 600;
	font-size: 0.9rem;
	text-transform: uppercase;
}

.info-value {
	color: #2d3436;
	font-weight: 500;
	font-size: 1.1rem;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<c:import url="Layouts/sideBar.jsp" />

			<div class="col-md-9 col-lg-10 p-4">
				<div class="d-flex align-items-center mb-4">
					<a href="adminDashboard?mode=customerList"
						class="btn btn-outline-dark me-3"> <i class="bi bi-arrow-left"></i>
						Back
					</a>
					<h3 class="mb-0 fw-bold">Customer Details</h3>
				</div>

				<div class="card info-card shadow-sm mb-4">
					<div class="profile-header"></div>
					<div class="card-body text-center profile-img-container">
						<img
							src="https://ui-avatars.com/api/?name=${u.name}&background=random&size=150&font-size=0.33"
							class="rounded-circle profile-img shadow-sm mb-3"
							alt="User Avatar">
						<h2 class="fw-bold">${u.name}</h2>
						<p class="text-muted">
							<i class="bi bi-geo-alt-fill"></i> ${u.address}
						</p>
					</div>
				</div>

				<div class="row g-4">
					<div class="col-md-6">
						<div class="card info-card shadow-sm h-100">
							<div class="card-body p-4">
								<h5 class="fw-bold mb-4 border-bottom pb-2">Contact
									Information</h5>
								<div class="mb-3">
									<div class="info-label">Email Address</div>
									<div class="info-value">
										<i class="bi bi-envelope-at me-2 text-primary"></i> ${u.email}
									</div>
								</div>
								<div class="mb-3">
									<div class="info-label">Phone Number</div>
									<div class="info-value">
										<i class="bi bi-telephone me-2 text-success"></i> ${u.phone}
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-6">
						<div class="card info-card shadow-sm h-100">
							<div class="card-body p-4">
								<h5 class="fw-bold mb-4 border-bottom pb-2">Account Details</h5>
								<div class="mb-3">
									<div class="info-label">User ID</div>
									<div class="info-value">#${u.id}</div>
								</div>
								<div class="mb-3">
									<div class="info-label">Residential Address</div>
									<div class="info-value">
										<i class="bi bi-house-door me-2 text-warning"></i>
										${u.address}
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>



			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>