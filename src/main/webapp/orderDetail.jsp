<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order #<c:out value="${orderId}" /> Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">Order Details - #<c:out value="${orderId}" /></h2>
            <a href="adminDashboard?mode=orderList" class="btn btn-secondary">Back to Orders</a>
        </div>

        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <table class="table table-bordered">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <c:set var="grandTotal" value="0" />
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td>
                                    <img src="uploads/${item.product.image}" width="50" height="50" style="object-fit: cover;">
                                </td>
                                <td>${item.product.name}</td>
                                <td>${item.product.price} MMK</td>
                                <td>${item.quantity}</td>
                                <td class="fw-bold text-danger">${item.subtotal} MMK</td>
                            </tr>
                            <c:set var="grandTotal" value="${grandTotal + item.subtotal}" />
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="4" class="text-end">Grand Total:</th>
                            <th class="text-center text-danger h5">${grandTotal} MMK</th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</body>
</html>