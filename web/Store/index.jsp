<%-- 
    Document   : index
    Created on : 28 Apr 2023, 6:59:40 pm
    Author     : dyhar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= getServletContext().getInitParameter("AppName")%> - Celebrating 1 year in the service of Tech Otakus!</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="store.css" rel="stylesheet">
        
    </head>
    <body>
        <!-- This is the header -->
            <nav class="header">
                <ul>
                    <li><img src="<%= request.getContextPath()%>/assets/ConaShop-Logo.png" 
                             alt="ConaShop Logo" 
                             loading="lazy" 
                             width="159"
                             height="35"
                             class="logo"
                             /></li>
                </ul>
                <!-- Link the login button to login.jsp -->
                <% if (session.getAttribute("username") == null) { %>
                <ul class="pull-right">
                    <li><form class="acct-status" method="POST" action="login.jsp">
                            <a class="bx bx-shopping-bag" id="cart-icon" href="cart.jsp"></a>
                            <!-- This is the Log In button -->
                            <input type="submit" value="Log In" name="where">
                        </form></li>
                </ul>
                <% } else {%>
                <ul class="pull-right">
                    <li><form class="acct-status" method="GET" action="Logout">
                            <label for="cart-icon"></label>
                            <a class="bx bx-shopping-bag" id="cart-icon" href="cart.jsp"></a>
                            <!-- This is the Log Out button -->
                            <input type="submit" value="Log Out" name="where">
                        </form></li>
                </ul>
                <% }%>

            </nav>

            <section class="gap"></section>
            
            <div class="wrap">
                <h1>asd</h1>
            </div>
    </body>
    
</html>
