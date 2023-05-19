<%-- 
    Document   : gcash
    Created on : May 19, 2023, 12:04:12 PM
    Author     : csean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add GCash</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="gcash.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&display=swap">
        <script defer src="gcash.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <body>
        <nav class="topnav">
            <img src="<%= request.getContextPath()%>/assets/StorePage/gcashalter.png" 
                 alt="GCash Logo" 
                 loading="lazy" 
                 width="144"
                 height="47.85"
                 class="logo"
                 />
        </nav>
        <main> 
            <form class="gcash-ui">
                <h1>Hello World!</h1>
                <h2>Add Number to Merchant</h2>
                <input type="text">
                <input type="submit">
            </form>
        </main>
    </body>
</html>
