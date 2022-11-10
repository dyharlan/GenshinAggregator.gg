<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="receipt.css" rel="stylesheet">
        <title>Receipt Page | GenshinStore.gg</title>
    </head>
    <body>
        
        <h1>Thank you for your patronage!</h1>
        <br>
        <p>A copy of your transaction has been sent to your e-mail address: <!--Insert email here from form.html--> <%= request.getAttribute("email") %>.</p>
        <br>
        <hr>
        <br>
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
    </body>
</html>