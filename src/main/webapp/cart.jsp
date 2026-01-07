<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Your Cart - SportX</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">
	<div class="container my-5">
		<h2 class="fw-bold mb-4">Shopping Cart</h2>
		<div class="card shadow-sm border-0">
			<div class="card-body">
				<table class="table align-middle">
					<thead class="table-dark">
						<tr>
							<th>Image</th>
							<th>Product</th>
							<th>Price</th>
							<th>Qty</th>
							<th>Subtotal</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="total" value="0" />
						<c:forEach items="${cartItems}" var="item">
							<tr>
								<td><img src="uploads/${item.product.image}"
									class="img-thumbnail"
									style="width: 80px; height: 80px; object-fit: cover;"
									onerror="this.src='https://via.placeholder.com/80x80?text=No+Image'">
								</td>

								<td class="fw-bold">${item.product.name}</td>
								<td>${item.product.price}MMK</td>

								<td><span class="badge bg-secondary p-2">${item.quantity}</span>
								</td>

								<td class="text-danger fw-bold">${item.subtotal}MMK</td>

								<td><a
									href="cart?mode=remove&productId=${item.product.productId}"
									class="btn btn-sm btn-danger"> <i class="bi bi-trash"></i>
										Remove
								</a></td>
							</tr>
							<c:set var="total" value="${total + item.subtotal}" />
						</c:forEach>
					</tbody>
				</table>
				<div class="text-end mt-4">
					<h3>
						Total: <span class="text-danger">${total} MMK</span>
					</h3>
					<a href="home" class="btn btn-outline-dark">Continue Shopping</a> <a
						href="cart?mode=checkout" class="btn btn-primary btn-lg px-5">Checkout</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>