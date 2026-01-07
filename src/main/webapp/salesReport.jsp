<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Sales Report</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	background-color: #f8f9fa;
}

.sidebar {
	height: 100vh;
	background: #343a40;
	color: #fff;
}
/* sidebar link styling များ */
.sidebar a {
	color: #ddd;
	text-decoration: none;
	display: block;
	padding: 12px 20px;
}

.sidebar a:hover {
	background: #495057;
	color: #fff;
}

.sidebar a.active {
	background: #0d6efd;
	color: #fff;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<c:import url="Layouts/sideBar.jsp" />

			<div class="col-md-9 col-lg-10 p-4">
				<div class="d-flex justify-content-between align-items-center mb-4">
					<h2 class="fw-bold">
						<i class="bi bi-graph-up-arrow"></i> Sales Report
					</h2>
					<div class="text-end">
						<div
							class="card border-0 shadow-sm bg-primary text-white p-2 px-4">
							<small>Grand Total Revenue</small>
							<h4 class="mb-0 fw-bold">${grandTotal}MMK</h4>
						</div>
					</div>
				</div>

				<div class="card border-0 shadow-sm">
					<div class="card-body">
						<table class="table table-hover align-middle">
							<thead class="table-dark">
								<tr>
									<th>Sales Date</th>
									<th class="text-center">Total Orders</th>
									<th class="text-end">Daily Revenue</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty salesData}">
									<tr>
										<td colspan="3" class="text-center py-5 text-muted"><i
											class="bi bi-exclamation-circle fs-2"></i><br> No sales
											data found.</td>
									</tr>
								</c:if>
								<c:forEach items="${salesData}" var="s">
									<tr>
										<td class="fw-bold text-secondary">${s.orderDate}</td>
										<td class="text-center"><span
											class="badge bg-info-subtle text-dark px-3 rounded-pill">
												${s.id} Orders </span></td>
										<td class="text-end fw-bold text-success">${s.totalAmount}
											MMK</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>