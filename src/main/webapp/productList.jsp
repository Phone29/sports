<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Product Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body { background: #f5f6fa; }
.card { border-radius: 12px; }
.table-hover tbody tr:hover { background: rgba(0, 0, 0, 0.05); }
img.product-img { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; }
</style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <c:import url="Layouts/sideBar.jsp"/>
        <div class="col-md-10 justify-content-center">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3>Product Management</h3>
                <a href="product?mode=new" class="btn btn-success">+ Add Product</a>
            </div>

            <!-- Search & Filter -->
            <div class="card p-3 mb-4">
                <form class="row g-3" method="get" action="product">
                    <input type="hidden" name="mode" value="list">
                    <div class="col-md-4">
                        <input type="text" name="search" value="${param.search}" class="form-control" placeholder="Search product...">
                    </div>
                    <div class="col-md-4">
                        <select name="cid" class="form-select">
                            <option value="">All Categories</option>
                            <c:forEach items="${categories}" var="c">
                                <option value="${c.id}" ${param.cid==c.id.toString()?'selected':''}>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4 d-flex gap-2">
                        <button class="btn btn-primary w-50">Search</button>
                        <a href="product?mode=list" class="btn btn-secondary w-50">Reset</a>
                    </div>
                </form>
            </div>

            <h3>Product List</h3>
            <table class="table table-bordered table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Image</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.productId}</td>
                            <td>${product.name}</td>
                            <td>
                                <c:forEach items="${categories}" var="c">
                                    <c:if test="${c.id == product.cid}">${c.name}</c:if>
                                </c:forEach>
                            </td>
                            <td>${product.price}</td>
                            <td>${product.quantity}</td>
                            <td>
						    <c:if test="${product.image != null && product.image != ''}">
						        <img src="uploads/${product.image}" class="product-img" alt="${product.name}">
						    </c:if>
						</td>
                            <td>
                                <a href="product?mode=productDetail&productId=${product.productId}" class="btn btn-info btn-sm">View</a>
                                <a href="product?mode=edit&id=${product.productId}" class="btn btn-success btn-sm">Edit</a>
                                <a href="product?mode=delete&id=${product.productId}" class="btn btn-danger btn-sm" onclick="return confirm('Delete?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="7" class="text-center text-muted">No products found</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>







