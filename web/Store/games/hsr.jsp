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
        <link rel="stylesheet" href="<%=request.getContextPath()%>/Store/navbar.css"/>
        <link rel="stylesheet" href="game-content.css">
        <title>Honkai: Star Rail</title>
        <script src="uidCheck.js"></script>
    </head>
    <body>
        <sql:setDataSource var="ds" driver="${initParam.className}" 
                                       url="${initParam.driverURL}://${initParam.dbHostName}:${initParam.dbPort}/${initParam.dbName}" 
                                       user="${initParam.dbUsername}" password="${initParam.dbPassword}"/>
        <nav class="topnav">
            <a id="img-link" href="<%= request.getContextPath()%>/Store/index.jsp">
            <img src="<%= request.getContextPath()%>/assets/ConaShop-Logo.png" 
                 alt="ConaShop Logo" 
                 loading="lazy" 
                 width="159"
                 height="35"
                 class="logo"
                 />
            </a>
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
                        <c:when test="${rs.rowCount <= 0}">
                             <%
                                Cookie[] cookies = request.getCookies();
                                if (cookies != null) {
                                    for (Cookie cookie : cookies) {
                                       
                                        cookie.setMaxAge(0);
                                        cookie.setValue("");
                                        response.addCookie(cookie);

                                    }
                                }
                                
                                request.getSession().setAttribute("paymentInfo", null);
                                session.invalidate();
                            %>
                             <a class="split login" href="<%= request.getContextPath() %>/Store/Login">Login</a>
                         </c:when>   
                        <c:otherwise>
                             <c:set var="isLoggedIn" value="true"/>
                            <c:forEach var="user_info" items="${rs.rows}">
                                <a class="split login" href="<%= request.getContextPath() %>/Store/Logout">Logout</a>
                                <a class="bx bx-shopping-bag split" id="cart-icon" href="<%=request.getContextPath()%>/Store/transaction.jsp"></a>
                                <a class="navbar-text split name" href="<%= request.getContextPath() %>/Store/profile.jsp">${user_info.fname} ${user_info.lname}</a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    
                </c:when>
                <c:otherwise>
                     <c:set var="isLoggedIn" value="false"/>
                    <a class="split login" href="<%= request.getContextPath() %>/Store/Login">Login</a>
                </c:otherwise>
            </c:choose>

            
        </nav>
        <main>
            <c:choose>
                <c:when test="${isLoggedIn == true}">
                    <form id="pay" action="<%=request.getContextPath()%>/Store/order-summary.jsp" method="POST" class="content-form">
                </c:when>
                <c:otherwise>
                    <div class="content-form">
                </c:otherwise>
            </c:choose>
                <div class="details">
                    <h1>Enter UID And Server Details</h1>
                    <input class="child" enterkeyhint="go" name="uid" id="uid" type="text" size="26" minlength="1" maxlength="9" placeholder="Enter UID (Up to 9 digits)" pattern="" title="" required>
                    <select class="child" name="server" id="server" required>
                        <option value="" disabled selected hidden>Select Server</option>
                        <option value="na">America</option>
                        <option value="eu">Europe</option>
                        <option value="asia">Asia</option>
                        <option value="sar">Taiwan, Hong Kong, Macao</option>
                    </select>
                </div>
                <div class="recharge">
                    <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                       url="jdbc:derby://localhost:1527/ConaShopDB" 
                                       user="cona" password="admin1"/>
                    <sql:query dataSource="${ds}" var="rs">
                        SELECT * FROM INVENTORY WHERE GameID = 'HV002_HSR'
                    </sql:query>
                    <c:forEach var="hsr" items="${rs.rows}">
                        <div class="${hsr.ItemID} child">
                            <div class="content"><label for="${hsr.ItemID}"><img src="${pageContext.servletContext.contextPath}${hsr.ItemPic}" width="225" height="225"><p class="desc">${hsr.ItemName}</p><p class="price">₱${hsr.ItemValue}</p></label></div>
                            <div class="img-button"><input id="${hsr.ItemID}" type="radio" name="select" value="${hsr.ItemID}" required></div>
                        </div>   
                    </c:forEach>
                </div>
                <div class="payment">
                  
                    <c:choose>
                        <c:when test="${isLoggedIn == true}">
                            <button type="submit" onclick="setRegex()">Proceed To Checkout</button>
                        </c:when>
                        <c:otherwise>
                            <h2>Please Login to Continue.</h2>
                        </c:otherwise>
                    </c:choose>
                </div>
            <c:choose>
                <c:when test="${isLoggedIn == true}">
                    </form>
                </c:when>
                <c:otherwise>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </body>
</html>
