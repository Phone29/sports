<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up - SportX</title>
    <style>
        body { background: #222; height: 100vh; display: flex; justify-content: center; align-items: center; font-family: sans-serif; margin:0; }
        .form-box { width: 600px; padding: 40px 0; background-image: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)),url('image/signup.jpg'); background-size: cover; background-position: center; border-radius: 10px; }
        h2 { color: white; text-align: center; font-size:40px; margin-bottom: 20px; }
        
        /* Input များအားလုံးကို အလယ်ရောက်အောင် လုပ်ခြင်း */
        .input-container { display: flex; flex-direction: column; align-items: center; }
        
        input, textarea {
            width: 400px;
            height: 50px;
            margin-bottom: 20px;
            border-radius: 18px;
            border: 2px solid orangered;
            font-size: 18px;
            padding: 0 20px;
            box-sizing: border-box;
        }
        
        textarea { height: 80px; padding-top: 10px; font-family: sans-serif; }
        
        button {
            width: 400px;
            height: 55px;
            border-radius: 5px;
            background-color: orangered;
            border: none;
            font-size: 25px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }
        button:hover { background-color: #ff4500; }
        .error-msg { color: #ff4d4d; text-align: center; font-weight: bold; margin-bottom: 15px; }
    </style>
</head>
<body>

<div class="form-box">
    <h2>Sign Up</h2>

    <c:if test="${param.error == 'true'}">
        <p class="error-msg">Register Failed! Email might already exist.</p>
    </c:if>

    <div class="input-container">
        <form action="auth" method="post">
            <input type="hidden" name="mode" value="register">

            <input type="text" name="name" placeholder="Enter Name" required>
            <input type="email" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <input type="text" name="phone" placeholder="Enter Phone" required>
            <textarea name="address" placeholder="Enter Address" required></textarea>
            
            <button type="submit">Register</button>
        </form>

        <p style="color: white; margin-top: 20px;">
            Already have an account? <a href="login.jsp" style="color: orangered; text-decoration: none;">Login</a>
        </p>
    </div>
</div>

</body>
</html>