<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - SportX</title>
<style>
    body {
        background: #222;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: sans-serif;
        margin: 0;
    }
    .form-box {
        width: 500px; /* Login အတွက် နည်းနည်းကျဉ်းလိုက်တာ ပိုလှပါတယ် */
        padding: 40px 0;
        background-image: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('image/signup.jpg');
        background-size: cover;
        background-position: center;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(0,0,0,0.5);
    }
    h2 {
        color: white;
        text-align: center;
        font-size: 40px;
        margin-bottom: 40px;
    }
    .input-group {
        text-align: center;
    }
    input {
        width: 350px;
        height: 50px;
        margin-bottom: 30px;
        border-radius: 25px;
        border: 2px solid orangered;
        padding: 0 20px;
        font-size: 18px;
        background: white;
    }
    button {
        width: 390px;
        height: 55px;
        border-radius: 30px;
        background-color: orangered;
        border: none;
        font-size: 22px;
        font-weight: bold;
        color: white;
        cursor: pointer;
        transition: 0.3s;
    }
    button:hover {
        background-color: #ff4500;
        transform: scale(1.02);
    }
    .links {
        text-align: center;
        margin-top: 20px;
        color: white;
    }
    .links a {
        color: orangered;
        text-decoration: none;
    }
    .error-msg {
        color: #ff4d4d;
        text-align: center;
        margin-bottom: 20px;
    }
</style>
</head>
<body>

<div class="form-box">
    <h2>Login</h2>

    <c:if test="${not empty error}">
        <p class="error-msg">${error}</p>
    </c:if>

    <div class="input-group">
    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
</div>

    <div class="links">
        Don't have an account? <a href="register.jsp">Sign Up</a>
    </div>
</div>

</body>
</html>