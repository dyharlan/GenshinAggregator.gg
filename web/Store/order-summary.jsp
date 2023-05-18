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
        <link rel="stylesheet" href="summary.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&display=swap">
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
            <p class="navbar-text">Celebrating 1 year in the service of Tech Otakus!</p>
         </nav>
        <main>
            
            <form method="post" action="Register" class="register">
            <div class="order">
                <div>
                    <h1>Order Summary</h1>
                </div> 
            
            </div>   
             <div class="captcha">
                <label for="captcha">Captcha:</label>
                <br>
                <img src ="<%= request.getContextPath() %>/Store/captchaImg.png"/>
                <br>
                <input type="text" name="answer" id="captcha" class="form-control" placeholder="Enter the captcha" required />
            </div>   
               
            <input type="submit" value="Pay Now">       
            </form>    
        </main>
    </body>
</html>
