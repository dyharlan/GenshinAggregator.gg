<%-- 
    Document   : index
    Created on : Apr 28, 2023, 9:14:44 PM
    Author     : csean
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
        <nav class="topnav">
            <img src="<%= request.getContextPath()%>/assets/ConaShop-Logo.png" 
            alt="ConaShop Logo" 
            loading="lazy" 
            width="159"
            height="35"
            class="logo"
            />
            <form class="acct-status split" method="POST" action="login.jsp" class="login"> <!-- The nature of css dictates that whatever element is encountered first will receive the styles accordingly from the stylesheet, this also means that log in will be the rightmost element, followed by the shopping bag -->
                <!-- This is the Log In button -->
                <input type="submit" value="Log In" name="where">
            </form>
            <a class="bx bx-shopping-bag split" id="cart-icon" href="cart.jsp"></a>
            
        </nav>
        <div class="grid">
            <%--<% while(true) { %>--%>
                <a href="test.jsp">
                    <div class="content">
                        <img src='https://th.bing.com/th/id/OIP.sbbK4hibITDZPvkCo8h9CQAAAA?pid=ImgDet&rs=1' lazy class="game-imgs" name="">
                        <label for="">Honkai Star Rail</label>
                    </div>
                </a>
                <a href="test.jsp">
                    <div class="content">
                        <img src='https://th.bing.com/th/id/OIP.sbbK4hibITDZPvkCo8h9CQAAAA?pid=ImgDet&rs=1' lazy class="game-imgs" name="">
                        <label for="">Honkai Star Rail</label>
                    </div>
                </a>
                <a href="test.jsp">
                    <div class="content">
                        <img src='https://th.bing.com/th/id/OIP.sbbK4hibITDZPvkCo8h9CQAAAA?pid=ImgDet&rs=1' lazy class="game-imgs" name="">
                        <label for="">Honkai Star Rail</label>
                    </div>
                </a>
                <a href="test.jsp">
                    <div class="content">
                        <img src='https://th.bing.com/th/id/OIP.sbbK4hibITDZPvkCo8h9CQAAAA?pid=ImgDet&rs=1' lazy class="game-imgs" name="">
                        <label for="">Honkai Star Rail</label>
                    </div>
                </a>
            <%--<% } %>--%>
        </div>
    </body>
</html>
