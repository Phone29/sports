<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="container my-5">
    <div class="row">
        <div class="col-md-3">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-dark text-white fw-bold">Categories</div>
                <div class="list-group list-group-flush">
                    <a href="shopping" class="list-group-item list-group-item-action ${empty param.category_id ? 'active' : ''}">
                        All Products
                    </a>
                    <c:forEach items="${categories}" var="cat">
                        <a href="shopping?category_id=${cat.id}" 
                           class="list-group-item list-group-item-action ${param.category_id == cat.id ? 'active' : ''}">
                            ${cat.name}
                        </a>
                    </c:forEach>
                </div>
            </div>

            <div class="card shadow-sm border-0">
                <div class="card-body">
                    <form action="shopping" method="get">
                        <input type="text" name="search" class="form-control mb-2" placeholder="Search item..." value="${param.search}">
                        <button class="btn btn-primary w-100" type="submit">Search</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-md-9">
            <h3 class="fw-bold mb-4">Store</h3>
            <div class="row g-4">
                <c:if test="${empty products}">
                    <div class="col-12 text-center py-5">
                        <h4 class="text-muted">No products found.</h4>
                    </div>
                </c:if>

                <c:forEach items="${products}" var="p">
                    <div class="col-md-4">
                        <div class="card h-100 shadow-sm border-0">
                            <img src="uploads/${p.image}" class="card-img-top" style="height:200px; object-fit:cover;" 
                                 onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                            <div class="card-body d-flex flex-column">
                                <h6 class="fw-bold">${p.name}</h6>
                                <p class="text-danger fw-bold mt-auto mb-3">${p.price} MMK</p>
                                <div class="d-grid gap-2">
                                    <a href="product?mode=productDetail&productId=${p.productId}" class="btn btn-sm btn-outline-dark">Detail</a>
                                    <a href="cart?mode=add&productId=${p.productId}" class="btn btn-sm btn-primary">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>