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
        <title>Valorant</title>
    </head>
    <body>
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
                 <sql:setDataSource var="ds" driver="${initParam.className}" 
                                       url="${initParam.driverURL}://${initParam.dbHostName}:${initParam.dbPort}/${initParam.dbName}" 
                                       user="${initParam.dbUsername}" password="${initParam.dbPassword}"/>
            <p class="navbar-text">Celebrating 1 year in the service of Tech Otakus!</p>
            <c:choose>
                <c:when test="${cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3')}">
                    <c:set var="param1" value="${Integer.valueOf(cookie['let-him-cook1'].value)}"/> 
                    <c:set var="param2" value="${cookie['let-him-cook2'].value}"/> 
                    <c:set var="param3" value="${cookie['let-him-cook3'].value}"/> 
                    
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
                            <a class="split login" href="<%= request.getContextPath()%>/Store/Login">Login</a>
                        </c:when>    
                        <c:otherwise>
                            <c:set var="isLoggedIn" value="true"/>
                            <c:forEach var="user_info" items="${rs.rows}">
                                <a class="split login" href="<%= request.getContextPath()%>/Store/Logout">Logout</a>
                                <a class="bx bx-shopping-bag split" id="cart-icon" href="<%=request.getContextPath()%>/Store/transaction.jsp"></a>
                                <a class="navbar-text split name" href="<%= request.getContextPath()%>/Store/profile.jsp">${user_info.fname} ${user_info.lname}</a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </c:when>
                <c:otherwise>
                    <c:set var="isLoggedIn" value="false"/>
                    <a class="split login" href="<%= request.getContextPath()%>/Store/Login">Login</a>
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
                        <h1>Enter your Riot ID</h1>
                        <input class="child" name="uid" id="uid" oninput="numOnly(this.id);" type="text" size="18" minlength="3" maxlength="192" placeholder="Enter your Riot ID" pattern=".+#.+" title="(letters, numbers, symbols) # (letters, numbers, symbols)" required>
                    </div>
                    <div class="recharge">
                        <!-- for (database) -->
                        <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                           url="jdbc:derby://localhost:1527/ConaShopDB" 
                                           user="cona" password="admin1"/>
                        <sql:query dataSource="${ds}" var="rs">
                            SELECT * FROM INVENTORY WHERE GameID = 'TRG003_VRT'
                        </sql:query>
                        <c:forEach var="valo" items="${rs.rows}">
                            <div class="${valo.ItemID} child">
                                <div class="content"><label for="${valo.ItemID}"><img src="${pageContext.servletContext.contextPath}${valo.ItemPic}" width="214.02" height="154.2"><p class="desc">${valo.ItemName}</p><p class="price">₱${valo.ItemValue}</p></label></div>
                                <div class="img-button"><input id="${valo.ItemID}" type="radio" name="select" value="${valo.ItemID}" required></div>
                            </div>   
                        </c:forEach>

                    </div>
                    <div class="payment">
                       
                        <c:choose>
                            <c:when test="${isLoggedIn == true}">
                                <button type="submit">Pay Now</button>
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
