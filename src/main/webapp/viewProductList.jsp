<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Shop Homepage</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f5f6fa;
}

.card {
	border-radius: 12px;
}

img.product-img {
	width: 100%;
	height: 200px;
	object-fit: cover;
}
</style>
</head>
<body>

	<div class="container mt-4">

		<!-- CATEGORY FILTER -->
		<div class="mb-4">
			<h5>Categories</h5>

			<a href="product"
				class="btn btn-sm ${empty param.cid ? 'btn-dark' : 'btn-outline-dark'}">
				All </a>

			<c:forEach var="c" items="${categories}">
				<a href="product?cid=${c.id}"
					class="btn btn-sm
               ${param.cid == c.id ? 'btn-primary' : 'btn-outline-primary'}">
					${c.name} </a>
			</c:forEach>
		</div>

		<!-- PRODUCT LIST -->
		<div class="row">
			<c:forEach var="product" items="${products}">
				<div class="col-md-3 mb-4">
					<div class="card h-100">

						<c:if test="${product.image != null}">
							<img src="uploads/${product.image}" class="product-img">
						</c:if>

						<div class="card-body">
							<h5>${product.name}</h5>
							<p>Price : ${product.price} Ks</p>
							<p>Qty : ${product.quantity}</p>

							<p>
								Category :
								<c:forEach var="c" items="${categories}">
									<c:if test="${c.id == product.cid}">
                                    ${c.name}
                                </c:if>
								</c:forEach>
							</p>

							<a
								href="product?mode=productDetail&productId=${product.productId}"
								class="btn btn-info btn-sm w-100"> View Details </a>
						</div>
					</div>
				</div>
			</c:forEach>

			<c:if test="${empty products}">
				<p class="text-danger">No products available.</p>
			</c:if>
		</div>

	</div>
</body>
</html>
