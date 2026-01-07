<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
        body {
            background-color: #f5f6fa;
        }
        .sidebar {
            height: 100vh;
            background: #343a40;
            color: #fff;
        }
        .sidebar a {
            color: #ddd;
            text-decoration: none;
            display: block;
            padding: 12px 20px;
        }
        .sidebar a:hover {
            background: #495057;
            color: #fff;
        }
        .content-wrapper {
            padding: 25px;
        }
        .card {
            border-radius: 12px;
        }
    </style>
    
    
    
    	<div class="col-md-3 col-lg-2 sidebar p-0">
            <h4 class="text-center py-3 border-bottom">Welcome To Admin Panel</h4>
            <a href="adminDashboard?mode=admin">Dashboard</a>
            <a href="category">Categories</a>
            <a href="product?mode=productList">Products</a>
            <a href="adminDashboard?mode=orderList">Orders</a>
            <a href="adminDashboard?mode=customerList">Customers</a>
            <a href="adminDashboard?mode=salesReport">View Sales Reports</a>
            <a href="logout">Logout</a>
        </div>