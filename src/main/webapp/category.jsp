<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Category Management</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        body { background-color: #f4f6f9; }
        .card { border-radius: 12px; }
        .form-control, .btn { border-radius: 8px; }
        table th { background-color: #0d6efd; color: white; }
    </style>
</head>

<body>
<div class="container-fluid">
    <div class="row">
		<c:import url="Layouts/sideBar.jsp"/>
        <!-- Category Form -->
        <div class="col-md-10 justify-content-center">
            <div class="card shadow-sm mb-4">
                <div class="card-header">
                    <h5 class="mb-0">
                        ${category != null ? "Edit Category" : "Add Category"}
                    </h5>
                </div>

                <div class="card-body">
                    <form action="category?mode=saveCategory" method="post">
                        <input type="hidden" name="id" value="${category.id}">

                        <div class="mb-3">
                            <label class="form-label">Category Name</label>
                            <input type="text"
                                   name="name"
                                   class="form-control"
                                   placeholder="Enter category name"
                                   value="${category != null ? category.name : ''}"
                                   required>
                        </div>

                        <div class="d-flex justify-content-end">
                            <button type="submit" class="btn btn-success">
                                ${category != null ? "Update" : "Save"}
                            </button>
                            <c:if test="${category != null}">
                                <a href="category" class="btn btn-secondary ms-2">Cancel</a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">Category List</h5>
                </div>

                <div class="card-body">
                    <table class="table table-bordered table-hover text-center align-middle">
                        <thead>
                            <tr>
                                <th style="width: 10%">ID</th>
                                <th>Name</th>
                                <th style="width: 25%">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        
                        <c:forEach var="c" items="${categoryList}">
                            <tr>
                                <td>${c.id}</td>
                                <td>${c.name}</td>
                                <td>
                                    <a href="category?mode=edit&id=${c.id}"
                                       class="btn btn-warning btn-sm">Edit</a>

                                    <a href="category?mode=delete&id=${c.id}"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Delete?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty categoryList}">
                            <tr>
                                <td colspan="3" class="text-center text-muted">
                                    No data found
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Category Table -->
        <div class="col-md-10">
            
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

