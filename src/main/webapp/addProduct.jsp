<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Product Form</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0">
                <c:choose>
                    <c:when test="${product != null}">Edit Product</c:when>
                    <c:otherwise>Add New Product</c:otherwise>
                </c:choose>
            </h3>
        </div>
        <div class="card-body">
            <form action="product" method="post" enctype="multipart/form-data">
                <c:if test="${product != null}">
                    <input type="hidden" name="productId" value="${product.productId}">
                </c:if>

                <div class="mb-3">
                    <label class="form-label">Product Name</label>
                    <input type="text" name="name" value="${product.name}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Price (Ks)</label>
                    <input type="number" step="0.01" name="price" value="${product.price}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Quantity</label>
                    <input type="number" name="quantity" value="${product.quantity}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category</label>
                    <select name="cid" class="form-select" required>
                        <option value="">Select Category</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.id}" <c:if test="${product != null && product.cid == c.id}">selected</c:if>>${c.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Product Image</label>
                    <input type="file" name="image" class="form-control">
                    <c:if test="${product != null && product.image != null && product.image != ''}">
            <img src="uploads/${product.image}" 
                 alt="${product.name}" 
                 class="img-thumbnail mt-2" 
                 style="width:100px;">
        </c:if>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success">
                        <c:choose>
                            <c:when test="${product != null}">Update</c:when>
                            <c:otherwise>Save</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="product?mode=list" class="btn btn-secondary">Back to List</a>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
