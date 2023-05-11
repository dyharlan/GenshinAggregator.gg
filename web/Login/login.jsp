<%-- 
    Document   : login
    Created on : May 8, 2023, 10:27:16 PM
    Author     : csean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="login.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&display=swap">
        <script defer src="login.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <body>
        <nav class="topnav">
            <img src="<%= request.getContextPath()%>/assets/ConaShop-Logo.png" 
            alt="ConaShop Logo" 
            loading="lazy" 
            width="159"
            height="35"
            class="logo"
            />

            <a class="bx bx-shopping-bag split" id="cart-icon" href="cart.jsp"></a>
        </nav>
        <main>
            <form method="post" action="" class="login">
                <h1>Sign In</h1>
                <div class="container input">
                    <label for="username" class="input label">Username: </label>
                    <input type="text" class="input" name="username" id="username" placeholder="Enter Username" enterkeyhint="go" required>
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
                <input type="submit" value="Sign up">           
            </form>    
               
        </main>
    </body>
</html>
