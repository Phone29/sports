<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Products</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.product-card {
	padding: 20px;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
	text-align: center;
	margin-bottom: 30px;
	transition: transform 0.2s;
}

.product-card:hover {
	transform: translateY(-5px);
}

img.product-img {
	width: 60px;
	height: 60px;
	object-fit: cover;
	border-radius: 8px;
}

.product-title {
	font-size: 1.2rem;
	font-weight: 600;
	margin-bottom: 10px;
}

.product-price {
	font-size: 1.1rem;
	color: #e63946;
	font-weight: 500;
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<div class="container mt-4">
		<h2 class="mb-4">All Products</h2>
		<div class="row">
			<c:forEach var="product" items="${products}">
				<div class="col-md-3">
					<div class="product-card">
						<!-- Image path fix -->
						<c:if test="${product.image != null && product.image != ''}">
                                        <img src="uploads/${product.image}" class="product-img" alt="${product.name}">
                                    </c:if>
						<h5 class="product-title">${product.name}</h5>
						<p class="product-price">$${product.price}</p>
						<a
							href="product?mode=productDetail&productId=${product.productId}"
							class="btn btn-primary btn-sm">View Details</a>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
