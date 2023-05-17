<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="nl.captcha.* "%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="register.css">
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
            <form method="post" action="Register" class="register">
                <h1>Sign Up</h1>
                <div class="container input">
                <label for="email" class="input label">Email: </label>
                <input type="email" class="input" name="email" id="email" placeholder="Enter Email" enterkeyhint="go" required>
                </div>
                <div class="container input">
                    <label for="fname" class="input label">First Name: </label>
                    <input type="text" class="input" name="fname" id="fname" placeholder="Enter First Name" enterkeyhint="go" required>
                </div>
                <div class="container input">
                    <label for="lname" class="input label">Last Name: </label>
                    <input type="text" class="input" name="lname" id="lname" placeholder="Enter Last Name" enterkeyhint="go" required>
                </div>
                <div class="container input">
                    <label for="password" class="input label">Password: </label>
                    <input type="password" class="input" name="password" id="password" placeholder="Enter Password" enterkeyhint="go" pattern="(?=[A-Za-z0-9]+$)^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,}).*$" title="At least 8 characters with at least 1 number, 1 uppercase character, and 1 lowercase character" required>
                </div>
                <div class="container input">
                      <label for="birthday">Birthday:</label>
                      <input type="date" id="birthday" name="birthday">
                </div>
                <div class="show-password">
                    <input type="checkbox" class="checkbox" name="show" id="show" onclick="showPassword()">
                    <label for="show" class="checkbox label">Show Password</label>
                </div>
                
                <div class="form-group">
                <label for="captcha">Captcha:</label>
                <br>
                <img src ="<%= request.getContextPath() %>/Store/captchaImg.png"/>
                <br>
                <input type="text" name="answer" id="captcha" class="form-control" placeholder="Enter the captcha" required />
                </div>
                
                <input type="submit" value="Sign Up">
            </form>
        </main>
    </body>
</html>