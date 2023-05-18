<%-- 
    Document   : index
    Created on : Apr 28, 2023, 9:14:44 PM
    Author     : csean
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
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
        <link rel="stylesheet" href="navbar.css"/>
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
            <div class="grid">
                <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                       url="jdbc:derby://localhost:1527/ConaShopDB" 
                                       user="cona" password="admin1"/>
                    <sql:query dataSource="${ds}" var="rs">
                        SELECT * FROM SUPPORTEDGAMES
                    </sql:query>
                    <c:forEach var="games" items="${rs.rows}">
                        <a href="${games.GamePage}">
                        <div class="content">
                            <img src='${games.GameIcon}' lazy class="game-imgs" id="${games.GameID}">
                            <label for="${games.GameID}">${games.GameName}</label>
                        </div>
                    </a>
                    </c:forEach>
            </div>
        </main>
    </body>
</html>
