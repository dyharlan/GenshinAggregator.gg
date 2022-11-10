<!DOCTYPE html>
<html>
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="store.css" rel="stylesheet">
        <title>Store Page | GenshinAggregator.gg</title>
    </head>
    <body>
        
            <h1>Select Recharge: </h1>
            <form action="PaymentProcessor" method="POST">
                <div class="recharge">
                    <div class="r1 child">
                        <div class="content"><label for="rb1"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals1.png"><p>60 Genesis Crystals</p></label></div>
                        <div class="img-button"><input id="rb1" type="radio" name="select" value="r1"></div>
                    </div>
                    <div class="r2 child">
                        <div class="content"><label for="rb2"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals2.png"><p>300+30 Genesis Crystals</p></label></div>
                        <div class="img-button"><input id="rb2" type="radio" name="select" value="r2"></div>
                    </div>
                    <div class="r3 child">
                        <div class="content"><label for="rb3"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals3.png"><p>980+110 Genesis Crystals</p></label></div>
                        <div class="img-button"><input id="rb3" type="radio" name="select" value="r3"></div>
                    </div>
                    <div class="r4 child">
                        <div class="content"><label for="rb4"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals4.png"><p>1980+260 Genesis Crystals</p></label></div>
                        <div class="img-button"><input id="rb4" type="radio" name="select" value="r4"></div>
                    </div>
                    <div class="r5 child">
                        <div class="content"><label for="rb5"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals5.png"><p>3280+600 Genesis Crystals</p></label></div>
                        <div class="img-button"><input id="rb5" type="radio" name="select" value="r5"></div>
                    </div>
                    <div class="r6 child">
                        <div class="content"><label for="rb6"><img src="<%= request.getContextPath()%>/assets/StorePage/crystals6.png"><p>6480+1600 Genesis Crystals</p></label></div>
                        <div class="img-button"><input id="rb6" type="radio" name="select" value="r6"></div>
                    </div>
                    <div class="r7 child">
                        <div class="content"><label for="rb7"><img src="<%= request.getContextPath()%>/assets/StorePage/welkin.png"><p>Blessing of the Welkin Moon</p></label></div>
                        <div class="img-button"><input id="rb7" type="radio" name="select" value="r7"></div>
                    </div>
                </div>
                <div class="payment">
                    <h1>Select Payment</h1>
                    <div class="payment-container">
                        <div class="child"><input type="radio" id="payment1" name="payment" value="card"><img src="<%= request.getContextPath()%>/assets/StorePage/card.png"><label for="payment1">Credit Card/Debit Card</label></div>
                        <div class="child"><input type="radio" id="payment2" name="payment" value="gcash"><img src="<%= request.getContextPath()%>/assets/StorePage/gcash.png"><label for="payment2">GCash</label></div>
                    </div>
                </div>
                <div class="details">
                    <h1>Enter UID And Server Details</h1>
                    <input class="child" name="uid" id="uid" type="number" minlength="1" maxlength="9" placeholder="Enter UID (Up to 9 digits)" min="1">
                    <select class="child" name="server" id="server" placeholder>
                        <option value="" disabled selected hidden>Select Server</option>
                        <option value="na">America</option>
                        <option value="eu">Europe</option>
                        <option value="asia">Asia</option>
                        <option value="sar">Taiwan, Hong Kong, Macao</option>
                    </select>
                </div>
                <button type="submit">Next</button>
            </form>
        </div>
    </body>
</html>