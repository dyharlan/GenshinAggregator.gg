<%-- 
    Document   : profile
    Created on : May 18, 2023, 4:23:56 PM
    Author     : csean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="profile.css">
        <link rel="stylesheet" href="navbar.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&display=swap">
        <script defer src="profile.js"></script>
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
        </nav>
        <main>
            <h1>Profile Page</h1>
            <p>First Name: </p>
            <p>Last Name: </p>
            <p>Date of Birth: </p>
            <!-- Trigger/Open The Modal -->
            <button id="payment-btn">Payment Info</button>
            <!-- The Modal -->
            <div id="modal-container" class="modal">

                <!-- Modal content -->
                <div class="modal-content">
                    <div class="modal-header">
                        <span class="close">&times;</span>
                        <h2>Select Payment Method</h2>
                    </div>
                    <div class="modal-body">
                        <p>GCash</p>
                        <p>Credit Card</p>
                    </div>
                </div>

            </div>
        </main>
    </body>
</html>
