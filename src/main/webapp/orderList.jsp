<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { height: 100vh; background: #343a40; color: #fff; }
        /* sidebar styling များကို ဤနေရာတွင် ထည့်ပါ သို့မဟုတ် include လုပ်ပါ */
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <c:import url="Layouts/sideBar.jsp" />

            <div class="col-md-9 col-lg-10 p-4">
                <h2 class="mb-4 fw-bold"><i class="bi bi-cart-check"></i> Order Management</h2>

                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer Name</th>
                                    <th>Total Amount</th>
                                    <th>Order Date</th>
                                    <th>Status</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="o">
                                    <tr>
                                        <td>#${o.id}</td>
                                        <td>${o.customerName}</td>
                                        <td class="fw-bold">${o.totalAmount} MMK</td>
                                        <td>${o.orderDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status == 'Pending'}">
                                                    <span class="badge bg-warning text-dark">${o.status}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">${o.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <a href="adminDashboard?mode=orderDetail&id=${o.id}" 
                                               class="btn btn-sm btn-info text-white">
                                               <i class="bi bi-eye"></i> Details
                                            </a>
                                        </td>
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