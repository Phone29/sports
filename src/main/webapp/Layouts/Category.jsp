<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manage Categories</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm p-4">
        <h3 class="mb-3">Add New Category</h3>
        <form action="${pageContext.request.contextPath}/category" method="post">>
            <div class="mb-3">
                <label class="form-label">Category Name</label>
                <input type="text" class="form-control" value="${category !=null ? category.name : ''}" placeholder="Enter category name" required />
            </div>
            <button type="submit" class="btn btn-primary">Save Category</button>
        </form>
    </div>

    <div class="card shadow-sm p-4 mt-4">
        <h4 class="mb-3">Category List</h4>
        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Category Name</th>
                    <th>Actions</th>
                </tr>            
            </thead>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
