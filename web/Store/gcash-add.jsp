<%-- 
    Document   : gcash
    Created on : May 19, 2023, 12:04:12 PM
    Author     : csean
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
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
            <c:if test="${!(cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3'))}">
                <c:redirect url = "index.jsp"/>
            </c:if>
            <form action="GCashProcessor" method="post" class="gcash-ui">
                <h1>Hello World!</h1>
                <h2>Add Number to Merchant</h2>
                <div>
                    <%if(request.getAttribute("gcashExists") != null &&(Boolean) request.getAttribute("gcashExists")){%>
                        <h3>The GCash Number is already in use by this user!</h3>
                    <%}%>
                    <label for="number">Number:</label>
                    <input type="text" name="gcash-number" id="number" maxlength="13" size="13" placeholder="Input your mobile number" required>
                </div>
                <input type="submit" name="Submit">
            </form>
        </main>
    </body>
</html>
