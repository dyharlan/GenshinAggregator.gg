<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="receipt.css" rel="stylesheet">
        <title>Receipt Page | GenshinStore.gg</title>
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
        <div class="receipt">
        <h1>Thank you for your patronage!</h1>
        <hr class="line1">
        <br>
        <p>A copy of your transaction has been sent to your e-mail address: <!--Insert email here from form.html--> <%= request.getAttribute("email") %>.</p>
        <br>
        <hr>
        <br>
        <div class="container">
        <div class="image">
        <img src="<%= request.getContextPath()%>/assets/mora.png">
        </div>
        <section>
            <h2>Transaction Summary:</h2>
            <br>
            <p>Name: <!--Insert First Name and Last name--> <%= request.getAttribute("name") %></p>
            <p>UID: <!--Insert UID the transaction will go to--><%= request.getAttribute("uid") %></p>
            <p>Server: <!--Insert the Server in which the UID belongs to--> <%= request.getAttribute("server")%> </p>
            <p>Selected Order: <!--Insert order like "Blessing of the Welkin Moon"--> <%= request.getAttribute("item") %></p>
            <p>Payment Method: <!--Insert Credit Card (not the number)--> <%= request.getAttribute("creditCard")%></p>
            <p>Transaction Date: <!--Insert YYYY-MM-DD HH:MM:SS (24 hr format)--> <%= getServletContext().getAttribute("currDate")%> <%= getServletContext().getAttribute("currTime")%></p>
            <p>Total Price: ₱<!--Insert price in pesos--> <%= request.getAttribute("amount")%></p>

        </section>

        <input type="submit" value="Print your receipt">
        </div>

    </body>
</html>