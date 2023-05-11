<%-- 
    Document   : hsr
    Created on : May 11, 2023, 7:16:00 PM
    Author     : csean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="navbar.css"/>
        <link href="hsr.css" rel="stylesheet">
        <title>Honkai: Star Rail</title>
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
            <form class="acct-status split" method="POST" action="<%= request.getContextPath() %>/Login/login.jsp" class="login"> <!-- The nature of css dictates that whatever element is encountered first will receive the styles accordingly from the stylesheet, this also means that log in will be the rightmost element, followed by the shopping bag -->
                <!-- This is the Log In button -->
                <input class="login" type="submit" value="Log In" name="where">
            </form>
            <a class="bx bx-shopping-bag split" id="cart-icon" href="cart.jsp"></a>
            
        </nav>
        <main>
            <div class="recharge">
                <!-- for (database) -->
                    <div class="content"><label for="rb1"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals1.png"><p class="desc">60 Genesis Crystals</p><p class="price">₱49</p></label></div>
                    <div class="img-button"><input id="rb1" type="radio" name="select" value="r1" required></div>
            </div>
            <div class="payment">
                <h1>Select Payment</h1>
                <div class="payment-container">
                    <!-- for (database) -->
                        <div class="child"><input type="radio" id="visa" name="payment" value="visa" required><img src="<%= request.getContextPath()%>/assets/StorePage/visa.png"><label for="visa">Visa</label></div>
                        <div class="child"><input type="radio" id="mastercard" name="payment" value="mastercard" required><img src="<%= request.getContextPath()%>/assets/StorePage/mastercard.png"><label for="mastercard">MasterCard</label></div>
                </div>
            </div>
            <div class="details">
                <h1>Enter UID And Server Details</h1>
                <p><%= request.getAttribute("uidstatus") %></p>
                <input class="child" name="uid" id="uid" oninput="numOnly(this.id);" type="text" minlength="1" maxlength="9" placeholder="Enter UID (Up to 9 digits)" required>
                <select class="child" name="server" id="server" required>
                    <option value="" disabled selected hidden>Select Server</option>
                    <option value="na">America</option>
                    <option value="eu">Europe</option>
                    <option value="asia">Asia</option>
                    <option value="sar">Taiwan, Hong Kong, Macao</option>
                </select>
            </div>
            <button type="submit">Next</button>
        </main>
    </body>
</html>
