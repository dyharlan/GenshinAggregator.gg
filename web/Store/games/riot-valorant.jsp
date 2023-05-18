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
            <%  
                boolean cookieFound = false;
                String cookieName = "let him cook";
                Cookie[] cookies = request.getCookies();
                
                if (cookies != null) 
                {
                    for (int i=0; i < cookies.length; i++) 
                    {
                        Cookie cookie = cookies[i];
                        if (cookieName.equals(cookie.getName())) 
                        { 
                            cookieFound = true;
                            break;
                        }
                    }
                }
            %>
            <% if (cookieFound == false) { %>
                <a class="split login" href="<%= request.getContextPath() %>/Store/login.jsp">Login</a>
            <% } else {%>
                <a class="split login" href="<%= request.getContextPath() %>/Store/Logout">Logout</a>
            <%}%>
            <a class="bx bx-shopping-bag split" id="cart-icon" href="cart.jsp"></a>
        </nav>
        <main>
            <div class="details">
                <h1>Enter your Riot ID</h1>
                <p><%= request.getAttribute("uidstatus") %></p>
                <input class="child" name="uid" id="uid" oninput="numOnly(this.id);" type="text" minlength="1" maxlength="9" placeholder="Enter your Riot ID" required>
            </div>
            <div class="recharge">
                <!-- for (database) -->
                <div class="r1 child">
                    <div class="content"><label for="rb1"><img src="<%= request.getContextPath()%>/assets/StorePage/valopoints375.png" width="225" height="225"><p class="desc">375 Valorant Points</p><p class="price">₱49</p></label></div>
                    <div class="img-button"><input id="rb1" type="radio" name="select" value="r1" required></div>
                </div>
                <div class="r2 child">
                    <div class="content"><label for="rb2"><img src="<%= request.getContextPath()%>/assets/StorePage/valopoints650.png" width="225" height="225"><p>627+23 Valorant Points</p><p>₱249</p></label></div>
                    <div class="img-button"><input id="rb2" type="radio" name="select" value="r2" required></div>
                </div>
                <div class="r3 child">
                    <div class="content"><label for="rb3"><img src="<%= request.getContextPath()%>/assets/StorePage/valopoints1350.png" width="225" height="225"><p>1256+94 Valorant Points</p><p>₱499</p></label></div>
                    <div class="img-button"><input id="rb3" type="radio" name="select" value="r3" required></div>
                </div>
                <div class="r4 child">
                    <div class="content"><label for="rb4"><img src="<%= request.getContextPath()%>/assets/StorePage/valopoints2100.png" width="225" height="225"><p>1885+215 Valorant Points</p><p>₱749</p></label></div>
                    <div class="img-button"><input id="rb4" type="radio" name="select" value="r4" required></div>
                </div>
                <div class="r5 child">
                    <div class="content"><label for="rb5"><img src="<%= request.getContextPath()%>/assets/StorePage/valopoints3600.png" width="225" height="225"><p>3146+454 Valorant Points</p><p>₱2490</p></label></div>
                    <div class="img-button"><input id="rb5" type="radio" name="select" value="r5" required></div>
                </div>
                 <div class="r6 child">
                    <div class="content"><label for="rb6"><img src="<%= request.getContextPath()%>/assets/StorePage/valopoints7500.png" width="225" height="225"><p>6267+1233 Valorant Points</p><p>₱4990</p></label></div>
                    <div class="img-button"><input id="rb6" type="radio" name="select" value="r6" required></div>
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
                <button type="submit">Pay Now</button>
            </div>

        </main>
    </body>
</html>
