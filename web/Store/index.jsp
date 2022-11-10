<!DOCTYPE html>
<html>
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="store.css" rel="stylesheet">
        <title>Store Page | GenshinStore.gg</title>
        <%
            if(request.getAttribute("uidstatus") == null)
                request.setAttribute("uidstatus", "");
        %>
    </head>
    <body>
        <h1>Select Recharge: </h1>
        <br>
        <form action="PaymentProcessor" method="POST">
            <div class="recharge">
                <div class="r1 child">
                    <div class="content"><label for="rb1"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals1.png"><p>60 Genesis Crystals</p><p>₱49</p></label></div>
                    <div class="img-button"><input id="rb1" type="radio" name="select" value="r1" required></div>
                </div>
                <div class="r2 child">
                    <div class="content"><label for="rb2"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals2.png"><p>300+30 Genesis Crystals</p><p>₱249</p></label></div>
                    <div class="img-button"><input id="rb2" type="radio" name="select" value="r2" required></div>
                </div>
                <div class="r3 child">
                    <div class="content"><label for="rb3"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals3.png"><p>980+110 Genesis Crystals</p><p>₱749</p></label></div>
                    <div class="img-button"><input id="rb3" type="radio" name="select" value="r3" required></div>
                </div>
                <div class="r4 child">
                    <div class="content"><label for="rb4"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals4.png"><p>1980+260 Genesis Crystals</p><p>₱1490</p></label></div>
                    <div class="img-button"><input id="rb4" type="radio" name="select" value="r4" required></div>
                </div>
                <div class="r5 child">
                    <div class="content"><label for="rb5"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals5.png"><p>3280+600 Genesis Crystals</p><p>₱2490</p></label></div>
                    <div class="img-button"><input id="rb5" type="radio" name="select" value="r5" required></div>
                </div>
                <div class="r6 child">
                    <div class="content"><label for="rb6"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals6.png"><p>6480+1600 Genesis Crystals</p><p>₱4990</p></label></div>
                    <div class="img-button"><input id="rb6" type="radio" name="select" value="r6" required></div>
                </div>
                <div class="r7 child">
                    <div class="content"><label for="rb7"><img src="<%= request.getContextPath()%>/assets/StorePage/welkin.png"><p>Blessing of the Welkin Moon</p><p>₱249</p></label></div>
                    <div class="img-button"><input id="rb7" type="radio" name="select" value="r7" required></div>
                </div>
            </div>
            <br>
            <div class="payment">
                <h1>Select Payment</h1>
                <br>
                <div class="payment-container">
                    <div class="child"><input type="radio" id="visa" name="payment" value="visa"><img src="<%= request.getContextPath()%>/assets/StorePage/visa.png"><label for="visa">Visa</label></div>
                    <div class="child"><input type="radio" id="mastercard" name="payment" value="mastercard"><img src="<%= request.getContextPath()%>/assets/StorePage/mastercard.png"><label for="mastercard">MasterCard</label></div>
                </div>
            </div>
            <br>
            <div class="details">
                <h1>Enter UID And Server Details</h1>
                <br>
                <p><%= request.getAttribute("uidstatus") %></p>
                <input class="child" name="uid" id="uid" type="number" min="1" max="999999999" placeholder="Enter UID (Up to 9 digits)" required>
                <select class="child" name="server" id="server" required>
                    <option value="" disabled selected hidden>Select Server</option>
                    <option value="na">America</option>
                    <option value="eu">Europe</option>
                    <option value="asia">Asia</option>
                    <option value="sar">Taiwan, Hong Kong, Macao</option>
                </select>
            </div>
            <br>
            <button type="submit">Next</button>
        </form>
    </body>
</html>