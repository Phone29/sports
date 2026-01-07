<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SportX - Sports Accessories Store</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
<style>
    body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
    .navbar { background-color: #1a1a1a; }
    .hero-section {
        background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
            url('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=1350&q=80');
        background-size: cover; background-position: center; color: white; padding: 100px 0; text-align: center;
    }
    .card:hover { transform: translateY(-5px); transition: 0.3s; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1); }
    .btn-primary { background-color: #ff4d05; border: none; }
    .btn-primary:hover { background-color: #e64404; }
    
    .category-card { transition: 0.3s; border: 2px solid transparent !important; }
    .category-card:hover { border-color: #ff4d05 !important; transform: scale(1.05); }
    .active-category { background-color: #ff4d05 !important; color: white !important; }
    
    .product-card img { height: 200px; object-fit: cover; }
</style>
<link rel="stylesheet" href="CSS/pyinduoduo.css">
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="home">SPORT<span class="text-warning">X</span></a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <form action="home" method="get" class="d-flex mx-auto col-md-5 my-2 my-lg-0">
                    <input class="form-control me-2 rounded-pill" type="search" name="search" 
                           placeholder="Search products..." value="${param.search}">
                    <button class="btn btn-outline-warning rounded-pill" type="submit">Search</button>
                </form>

                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link active" href="home">Home</a></li>
					<li class="nav-item"><a class="nav-link active" href="#categories">Categories</a></li>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <c:if test="${sessionScope.user.role == 'admin'}">
                                <li class="nav-item"><a class="nav-link text-warning fw-bold" href="product">Admin Panel</a></li>
                            </c:if>
                            <a href="cart?mode=view" class="btn btn-outline-dark">
    <i class="bi bi-cart4"></i> Cart 
    <span class="badge bg-danger rounded-pill">
        <c:out value="${sessionScope.cart != null ? sessionScope.cart.size() : 0}" />
    </span>
</a>
                            <li class="nav-item"><span class="nav-link text-white-50 px-3 small">Hi, ${sessionScope.user.name}</span></li>
                            <li class="nav-item"><a class="nav-link btn btn-sm btn-danger ms-2 px-3 text-white" href="login?mode=logout">Logout</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="login">Login</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-section">
        <div class="container">
            <h1 class="display-3 fw-bold">Level Up Your Game</h1>
            <p class="lead">Premium quality sports accessories for every athlete.</p>
            <a href="#shop" class="btn btn-primary btn-lg mt-3 px-5 py-3">Shop Now</a>
        </div>
    </header>

    <section id="categories" class="container my-5">
        <h3 class="fw-bold mb-4 text-center">Browse by Category</h3>
        
        <div class="text-center mb-4">
            <a href="home" class="btn btn-sm ${empty param.category_id ? 'btn-primary' : 'btn-outline-dark'}">All Products</a>
        </div>

        <div class="row text-center justify-content-center">
            <c:forEach items="${categories}" var="cat">
                <div class="col-6 col-md-2 mb-4">
                    <div class="p-3 border rounded shadow-sm category-card ${param.category_id == cat.id ? 'active-category' : 'bg-white'}"
                        style="cursor: pointer;"
                        onclick="location.href='home?category_id=${cat.id}'">
                        <h6 class="fw-bold text-uppercase small mb-0">${cat.name}</h6>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <section id="shop" class="container my-5">
        <h2 class="text-center mb-5 fw-bold">
            <c:choose>
                <c:when test="${not empty param.search}">Search Results for "${param.search}"</c:when>
                <c:when test="${not empty param.category_id}">Filtered Result</c:when>
                <c:otherwise>Featured Accessories</c:otherwise>
            </c:choose>
        </h2>

        <div class="row g-4">
            <c:if test="${empty products}">
                <div class="col-12 text-center py-5">
                    <p class="text-muted h5">No products found matching your criteria.</p>
                    <a href="home" class="btn btn-link">View all products</a>
                </div>
            </c:if>

            <c:forEach items="${products}" var="p">
                <div class="col-md-3">
                    <div class="card h-100 shadow-sm product-card border-0">
                        <img src="uploads/${p.image}" class="card-img-top" 
                             onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-bold h6">${p.name}</h5>
                            <p class="card-text text-muted small mb-2">Available: ${p.quantity}</p>
                            <div class="mt-auto">
                                <span class="h5 mb-3 d-block text-danger fw-bold">${p.price} MMK</span>
                                <div class="d-grid gap-2 d-md-flex justify-content-md-between">
                                    <a href="product-detail?productId=${p.productId}" class="btn btn-sm btn-outline-dark flex-grow-1">Detail</a>
                                    <a href="cart?mode=add&productId=${p.productId}" class="btn btn-sm btn-primary flex-grow-1">Add to Cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
    
    <section>
		<div class="con1">
			<div class="t1">
				<div class="t2">
					<div class="t22">
						<img src="image/deli.avif" alt="" width="75%" height="150px">
						<h2 id="hf">Free Shipping Method</h2>
						<p>
							Fast & Free Delivery Right to Your Doorstep!<br>Shop Now and
							Get Free Shipping on Every Item!<br>Free Shipping Available
							for All Products Nationwide.<br>Your Favorite Items,
							Delivered Free of Charge!
						</p>
					</div>
				</div>
				<div class="t2">
					<div class="t22">
						<img src="image/secure_payment.png" alt="" width="60%"
							height="150px">
						<h2 id="hf">Secure Payment System</h2>
						<p>
							Fast & Free Delivery Right to Your Doorstep!<br>Shop Now and
							Get Free Shipping on Every Item!<br>Free Shipping Available
							for All Products Nationwide.<br>Your Favorite Items,
							Delivered Free of Charge!
						</p>
					</div>
				</div>
				<div class="t2">
					<div class="t22">
						<img src="image/deli.avif" alt="" width="75%" height="150px">
						<h2 id="hf">Free Shipping Method</h2>
						<p>
							Fast & Free Delivery Right to Your Doorstep!<br>Shop Now and
							Get Free Shipping on Every Item!<br>Free Shipping Available
							for All Products Nationwide.<br>Your Favorite Items,
							Delivered Free of Charge!
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<br>
	<br>
	<section>
		<div class="conmen">
			<div class="f1">
				<div class="f2">
					<img src="image/player1.png" alt="" width="100%" height="550px">
				</div>
				<div class="f3">
					<h2>Find The Best Product from Our Shop</h2>
					<p>Designers who are interesten creating state ofthe.</p>
					<button id="btnShop">Shop Now</button>
					<br> <br> <br> <img src="image/menshirt2.jpg" alt=""
						id="imgmen" widt="100%" height="200px">
				</div>
			</div>
		</div>
	</section>
	<br>

	<section>
		<div class="con3">
			<div class="fi1"></div>
		</div>
	</section>
	<br>
	<br>
	<br>
	<section>
		<div class="pr1">
			<div class="photo">
				<img src="image/fml.jpg" alt="" width="520px" height="350px">
			</div>
			<div class="place">
				<h1>
					#1 Place To Find The <br> Perfect Property
				</h1>
				<p>
					Tempor erat elitr rebum at clita. Diam dolor diam ipsum sit. Aliqu
					diam <br> amet diam et eos. Clita erat ipsum et lorem et sit,
					sed stet lorem sit clita <br> duo justo magna dolore erat amet
				</p>
				<i class="fa-solid fa-check icon"></i> Tempor erat elitr rebum at
				clita <br> <br> <i class="fa-solid fa-check icon"></i>
				Aliqu diam amet diam et eos <br> <br> <i
					class="fa-solid fa-check icon"></i> Clita duo justo magna dolore
				erat amet <br> <br>
				<button id="btnRead">Read More</button>
			</div>
		</div>
	</section>

    <footer class="bg-dark text-white text-center py-5 mt-5">
        <div class="container">
            <p class="mb-0">&copy; 2025 SportX Accessories Store. Your ultimate sports partner.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>