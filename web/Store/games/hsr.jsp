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
                <div class="r1 child">
                    <div class="content"><label for="rb1"><img src="<%= request.getContextPath()%>/assets/StorePage/Oneiric60.png" width="225" height="225"><p class="desc">60 Oneiric Shard</p><p class="price">₱49</p></label></div>
                    <div class="img-button"><input id="rb1" type="radio" name="select" value="r1" required></div>
                </div>
                <div class="r2 child">
                    <div class="content"><label for="rb2"><img src="<%= request.getContextPath()%>/assets/StorePage/Oneiric300.png" width="225" height="225"><p>300+300 Oneiric Shard</p><p>₱249</p></label></div>
                    <div class="img-button"><input id="rb2" type="radio" name="select" value="r2" required></div>
                </div>
                <div class="r3 child">
                    <div class="content"><label for="rb3"><img src="<%= request.getContextPath()%>/assets/StorePage/Oneiric980.png" width="225" height="225"><p>980+980 Oneiric Shard</p><p>₱749</p></label></div>
                    <div class="img-button"><input id="rb3" type="radio" name="select" value="r3" required></div>
                </div>
                <div class="r4 child">
                    <div class="content"><label for="rb4"><img src="<%= request.getContextPath()%>/assets/StorePage/Oneiric1980.png" width="225" height="225"><p>1980+1980 Oneiric Shard</p><p>₱1490</p></label></div>
                    <div class="img-button"><input id="rb4" type="radio" name="select" value="r4" required></div>
                </div>
                <div class="r5 child">
                    <div class="content"><label for="rb5"><img src="<%= request.getContextPath()%>/assets/StorePage/Oneiric3280.png" width="225" height="225"><p>3280+3280 Oneiric Shard</p><p>₱2490</p></label></div>
                    <div class="img-button"><input id="rb5" type="radio" name="select" value="r5" required></div>
                </div>
                 <div class="r6 child">
                    <div class="content"><label for="rb6"><img src="<%= request.getContextPath()%>/assets/StorePage/Oneiric6480.png" width="225" height="225"><p>6480+6480 Oneiric Shard</p><p>₱4990</p></label></div>
                    <div class="img-button"><input id="rb6" type="radio" name="select" value="r6" required></div>
                </div>
                <div class="r7 child">
                    <div class="content"><label for="rb7"><img src="<%= request.getContextPath()%>/assets/StorePage/SupplyPass.png" width="225" height="225"><p>Express Supply Pass</p><p>₱249</p></label></div>
                    <div class="img-button"><input id="rb7" type="radio" name="select" value="r7" required></div>
                </div>
            </div>
            <div class="payment">
                <h1>Select Payment</h1>
                <div class="payment-container">
                    <!-- for (database) -->
                        <div class="child"><input type="radio" id="visa" name="payment" value="visa" required><img src="<%= request.getContextPath()%>/assets/StorePage/visa.png" class="visa"></div>
                        <div class="child"><input type="radio" id="mastercard" name="payment" value="mastercard" required><img src="<%= request.getContextPath()%>/assets/StorePage/mastercard.png" class="mastercard"></div>
                        <div class="child"><input type="radio" id="gcash" name="payment" value="gcash"><img src="<%= request.getContextPath()%>/assets/StorePage/gcash.png" class="gcash"></div>
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
                <button type="submit">Next</button>
            </div>
        </main>
    </body>
</html>
