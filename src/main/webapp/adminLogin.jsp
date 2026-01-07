<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>

<style>
body {
    background: #222;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: sans-serif;
}
.form-box {
    width: 600px;
    height: 400px;
    background-image: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)),url('image/signup.jpg');
    background-size: cover;
    background-position: center;
    margin: auto;
}
input, button {
    width: 400px;
    height: 45px;
    margin-bottom: 30px;
    display: block;
    margin-left: auto;
    margin-right: auto;
}
button {
    width: 400px;
    height: 50px;
    border-radius: 5px;
    background-color: orangered;
    border-color: orangered;
    text-decoration: none;
    font-size:25px;
    font-weight:bold;
    color:white;
}
h2 {
    color: white;
    text-align: center;
    font-size:40px;
    margin-top: 50px;
}
</style>
</head>

<body>
<div class="form-box">
    <h2>Admin Login</h2>

    <c:if test="${not empty message}">
        <p style="color:red;text-align:center;">${message}</p>
    </c:if>

    <form action="adminDashboard?mode=admin" method="post">
        <input type="hidden" name="action" value="adminLogin">
        <input type="email" id="email" name="email" placeholder="Enter Email" required>
        <input type="password" id="password" name="password" placeholder="Enter Password" required>
        <button type="submit">Login</button>
    </form> 
</div>
</body>
</html>
