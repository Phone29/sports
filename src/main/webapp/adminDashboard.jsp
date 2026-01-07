<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Admin Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	background-color: #f0f2f5;
	font-family: 'Segoe UI', sans-serif;
}

.stat-card {
	border: none;
	border-radius: 12px;
	transition: 0.3s;
}

.stat-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1) !important;
}

.icon-shape {
	width: 48px;
	height: 48px;
	border-radius: 10px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<c:import url="Layouts/sideBar.jsp" />

			<div class="col-md-9 col-lg-10 p-4">
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h2 class="fw-bold">Dashboard Overview</h2>
					<div class="text-muted">
						<i class="bi bi-clock"></i> Last Update:
						<%=new java.util.Date().toString().substring(0, 16)%></div>
				</div>

				<div class="row g-4 mb-5">
					<div class="col-md-3">
						<div class="card stat-card shadow-sm p-3 bg-primary text-white">
							<div class="d-flex align-items-center">
								<div class="icon-shape bg-white text-primary me-3">
									<i class="bi bi-currency-dollar"></i>
								</div>
								<div>
									<h6 class="mb-0 opacity-75 small">Total Revenue</h6>
									<h4 class="fw-bold mb-0">${totalRevenue}</h4>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card stat-card shadow-sm p-3 bg-white">
							<div class="d-flex align-items-center">
								<div class="icon-shape bg-info-subtle text-info me-3">
									<i class="bi bi-box"></i>
								</div>
								<div>
									<h6 class="mb-0 text-muted small">Products</h6>
									<h4 class="fw-bold mb-0">${totalProducts}</h4>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card stat-card shadow-sm p-3 bg-white">
							<div class="d-flex align-items-center">
								<div class="icon-shape bg-success-subtle text-success me-3">
									<i class="bi bi-cart"></i>
								</div>
								<div>
									<h6 class="mb-0 text-muted small">Total Orders</h6>
									<h4 class="fw-bold mb-0">${totalOrders}</h4>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-3">
						<div class="card stat-card shadow-sm p-3 bg-white">
							<div class="d-flex align-items-center">
								<div class="icon-shape bg-danger-subtle text-danger me-3">
									<i class="bi bi-people"></i>
								</div>
								<div>
									<h6 class="mb-0 text-muted small">Customers</h6>
									<h4 class="fw-bold mb-0">${totalCustomers}</h4>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="card border-0 shadow-sm rounded-3">
					<div
						class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
						<h5 class="mb-0 fw-bold text-dark">Recent Orders</h5>
						<a href="adminDashboard?mode=orderList"
							class="btn btn-sm btn-link text-decoration-none">View All
							Orders</a>
					</div>
					<div class="card-body p-0">
						<div class="table-responsive">
							<table class="table table-hover align-middle mb-0">
								<thead class="table-light">
									<tr>
										<th class="ps-4">ID</th>
										<th>Customer</th>
										<th>Date</th>
										<th>Amount</th>
										<th>Status</th>
										<th class="text-center">Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${recentOrders}" var="o">
										<tr>
											<td class="ps-4">#${o.id}</td>
											<td>${o.customerName}</td>
											<td class="small text-muted">${o.orderDate}</td>
											<td class="fw-bold text-dark">${o.totalAmount}MMK</td>
											<td><span
												class="badge ${o.status == 'Pending' ? 'bg-warning' : 'bg-success'} rounded-pill">
													${o.status} </span></td>
											<td class="text-center"><a
												href="adminDashboard?mode=orderDetail&id=${o.id}"
												class="btn btn-sm btn-outline-secondary">View</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
</html>