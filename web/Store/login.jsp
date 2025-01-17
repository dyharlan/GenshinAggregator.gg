<%-- 
    Document   : login
    Created on : May 8, 2023, 10:27:16 PM
    Author     : csean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="login.css">
        <link rel="stylesheet" href="navbar.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&display=swap">
        <script defer src="login.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <body>
        <nav class="topnav">
            <a id="img-link" href="<%= request.getContextPath()%>/Store/index.jsp">
            <img src="<%= request.getContextPath()%>/assets/ConaShop-Logo.png" 
                 alt="ConaShop Logo" 
                 loading="lazy" 
                 width="159"
                 height="35"
                 class="logo"
                 />
            </a>
        </nav>
        <main>
                
            <form method="post" action="Login" class="login">
                <h1>Sign In</h1>
                <c:if test="${not empty requestScope.errorCount}">
                    <p>User does not exist.</p>
                </c:if>
                <c:if test="${cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3')}">
                    <c:redirect url = "index.jsp"/>
                </c:if>
                <div class="container input">
                    <label for="username" class="input label">E-mail: </label>
                    <input type="email" class="input" name="email" id="email" placeholder="Enter E-mail." enterkeyhint="go" required>
                </div>
                <div class="container input">
                    <label for="password" class="input label">Password: </label>
                    <input type="password" class="input" name="password" id="password" placeholder="Enter Password" enterkeyhint="go" pattern="(?=[A-Za-z0-9]+$)^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,}).*$" title="At least 8 characters with at least 1 number, 1 uppercase character, and 1 lowercase character" required>
                </div>
                <div class="show-password">
                    <input type="checkbox" class="checkbox" name="show" id="show" onclick="showPassword()">
                    <label for="show" class="checkbox label">Show Password</label>
                </div>
                <input type="submit" value="Log In">
                <a href="Register">New user? Sign up here.</a>          
            </form>    
               
        </main>
    </body>
</html>
