<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer List</title>

<!-- Bootstrap 5 CDN -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>

<body>
<div class="container-fluid">
    <div class="row">

       
        <c:import url="Layouts/sideBar.jsp" />

    
        <div class="col-md-10 justify-content-center">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2>Customer List</h2>
            </div>

        
            <div class="table-responsive">
                <table
                    class="table table-striped table-bordered align-middle text-center">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="c" items="${customerList}">
                            <tr>
                                <td>${c.customerId}</td>
                                <td>${c.name}</td>
                                <td>${c.email}</td>
                                <td>${c.phone}</td>
                                <td>${c.address}</td>
                                <td>
                                    <a href="customer?mode=detail&id=${c.customerId}"
                                       class="btn btn-sm btn-info">View</a>

                                    <a href="customer?mode=delete&id=${c.customerId}"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Are you sure to delete this customer?');">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty customerList}">
                            <tr>
                                <td colspan="6">No Customers Found</td>
                            </tr>
                        </c:if>

                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>


<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
