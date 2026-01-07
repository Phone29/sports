<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>${p.name} - Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container my-5 bg-white p-5 rounded shadow-sm">
        <div class="row">
            <div class="col-md-6 text-center">
                <img src="uploads/${p.image}" class="img-fluid rounded shadow" style="max-height: 400px;" 
                     onerror="this.src='https://via.placeholder.com/400x400?text=No+Image'">
            </div>
            <div class="col-md-6">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                        <li class="breadcrumb-item active">${p.name}</li>
                    </ol>
                </nav>
                <h1 class="fw-bold display-5">${p.name}</h1>
                <h3 class="text-danger fw-bold my-4">${p.price} MMK</h3>
                <p class="text-muted">In Stock: ${p.quantity} units available</p>
                <hr>
                
                <form action="cart" method="post" class="mt-4">
                    <input type="hidden" name="productId" value="${p.productId}">
                    <input type="hidden" name="mode" value="add">
                    <div class="mb-4">
                        <label class="form-label fw-bold">Quantity</label>
                        <input type="number" name="qty" value="1" min="1" max="${p.quantity}" class="form-control w-25">
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg px-5 py-3 rounded-pill">
                        Add to Cart
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>