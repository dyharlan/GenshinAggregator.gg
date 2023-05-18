<%-- 
    Document   : hsr
    Created on : May 11, 2023, 7:16:00 PM
    Author     : csean
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="navbar.css"/>
        <link href="hsr.css" rel="stylesheet">
        <title>Honkai: Star Rail</title>
        <script>
            function numOnly(id) {
                // Get the element by id
                var element = document.getElementById(id);
                // Use numbers only pattern, from 0 to 9 with \-
                var regex = /[^0-9\-]/gi;
                // Replace other characters that are not in regex pattern
                element.value = element.value.replace(regex, "");
            }
        </script>
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

            <c:choose>
                <c:when test="${cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3')}">
                    <c:set var="param1" value="${Integer.valueOf(cookie['let-him-cook1'].value)}"/> 
                    <c:set var="param2" value="${cookie['let-him-cook2'].value}"/> 
                    <c:set var="param3" value="${cookie['let-him-cook3'].value}"/> 
                    <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                       url="jdbc:derby://localhost:1527/ConaShopDB" 
                                       user="cona" password="admin1"/>
                    <sql:query dataSource="${ds}" var="rs">
                        SELECT PersonInfo.USERID,PersonInfo.FNAME,PersonInfo.LNAME FROM PersonInfo JOIN PersonCredentials USING(UserID) where USERID = ? AND EMAIL = ? AND PASSWORD = ?
                        <sql:param value="${param1}" />  
                        <sql:param value="${param2}" />  
                        <sql:param value="${param3}" />  
                    </sql:query>
                    <c:choose>
                        <c:when test="${rs == null}">
                            <c:set var="cookie" value=""/>
                        </c:when>  
                        <c:otherwise>
                            <c:forEach var="user_info" items="${rs.rows}">
                                <p>${user_info.fname} ${user_info.lname}</p><a class="split login" href="<%= request.getContextPath()%>/Store/Logout">Logout</a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </c:when>
                <c:otherwise>
                    <a class="split login" href="<%= request.getContextPath()%>/Store/Login">Login</a>
                </c:otherwise>
            </c:choose>
            <a class="bx bx-shopping-bag split" id="cart-icon" href="cart.jsp"></a>
        </nav>
        <main>
            <div class="details">
                <h1>Enter UID And Server Details</h1>
                <input class="child" name="uid" id="uid" oninput="numOnly(this.id);" type="text" minlength="1" maxlength="9" placeholder="Enter UID (Up to 9 digits)" required>
                <select class="child" name="server" id="server" required>
                    <option value="" disabled selected hidden>Select Server</option>
                    <option value="na">America</option>
                    <option value="eu">Europe</option>
                    <option value="asia">Asia</option>
                    <option value="sar">Taiwan, Hong Kong, Macao</option>
                </select>

            </div>
            <div class="recharge">
                <!-- for (database) -->
                <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                   url="jdbc:derby://localhost:1527/ConaShopDB" 
                                   user="cona" password="admin1"/>
                <sql:query dataSource="${ds}" var="rs">
                    SELECT * FROM INVENTORY WHERE GameID = 'HV001_GI'
                </sql:query>
                <c:forEach var="genshin" items="${rs.rows}">
                    <div class="${genshin.ItemID} child">
                        <div class="content"><label for="${genshin.ItemID}"><img src="${pageContext.servletContext.contextPath}${genshin.ItemPic}" width="225" height="225"><p class="desc">${genshin.ItemName}</p><p class="price">₱${genshin.ItemValue}</p></label></div>
                        <div class="img-button"><input id="${genshin.ItemID}" type="radio" name="select" value="${genshin.ItemID}" required></div>
                    </div>   
                    </c:forEach>
                </div>
                <p class="solid">        
                <div class="payment">
                    <h1>Select Payment</h1>
                    <div class="payment-container">
                        <!-- for (database) -->
                        <div class="child"><input type="radio" id="visa" name="payment" value="visa" required><img src="<%= request.getContextPath()%>/assets/StorePage/visa.png" class="visa"></div>
                        <div class="child"><input type="radio" id="mastercard" name="payment" value="mastercard" required><img src="<%= request.getContextPath()%>/assets/StorePage/mastercard.png" class="mastercard"></div>
                        <div class="child"><input type="radio" id="gcash" name="payment" value="gcash"><img src="<%= request.getContextPath()%>/assets/StorePage/gcash.png" class="gcash"></div>
                    </div>
                    <button type="submit">Pay Now</button>
                </div>   

        </main>
    </body>
</html>
