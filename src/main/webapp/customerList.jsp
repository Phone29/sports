<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
<body>
    <div class="container-fluid">
        <div class="row">
            <c:import url="Layouts/sideBar.jsp" />

            <div class="col-md-9 col-lg-10 content-wrapper p-4">
                <h2 class="mb-4">Customer Management</h2>
                
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th class="text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${users}" var="u">
                                    <tr>
                                        <td>#${u.id}</td>
                                        <td>${u.name}</td>
                                        <td>${u.email}</td>
                                        <td>${u.phone}</td>
                                        <td class="text-center">
                                            <a href="adminDashboard?mode=userDetail&id=${u.id}" 
                                               class="btn btn-sm btn-primary">View Detail</a>
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