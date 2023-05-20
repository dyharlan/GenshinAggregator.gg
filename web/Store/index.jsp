<%-- 
    Document   : index
    Created on : Apr 28, 2023, 9:14:44 PM
    Author     : csean
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= getServletContext().getInitParameter("AppName")%> - Celebrating 1 year in the service of Tech Otakus!</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="navbar.css"/>
        <link rel="stylesheet" href="store.css">
        <script defer>
            <%  if (session.getAttribute("registration-success") != null && ((Boolean) session.getAttribute("registration-success")) == true) { %>
                    alert("User registration successful!");
            <%      session.removeAttribute("registration-success"); %>
            <%  } %>
        </script>
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
            <p class="navbar-text">Celebrating 1 year in the service of Tech Otakus!</p>

            <c:choose>
                <c:when test="${cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3')}">
                    <c:set var="param1" value="${Integer.valueOf(cookie['let-him-cook1'].value)}"/> 
                    <c:set var="param2" value="${cookie['let-him-cook2'].value}"/> 
                    <c:set var="param3" value="${cookie['let-him-cook3'].value}"/> 
                    
                    <sql:setDataSource var="ds" driver="${initParam.className}" 
                                       url="${initParam.driverURL}://${initParam.dbHostName}:${initParam.dbPort}/${initParam.dbName}" 
                                       user="${initParam.dbUsername}" password="${initParam.dbPassword}"/>
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
                            <c:forEach var="user_info" items="${rs.rows}">
                                <a class="split login" href="<%= request.getContextPath()%>/Store/Logout">Logout</a>
                                <a class="bx bx-shopping-bag split" id="cart-icon" href="<%=request.getContextPath()%>/Store/transaction.jsp"></a>
                                <a class="navbar-text split name" href="<%= request.getContextPath() %>/Store/profile.jsp">${user_info.fname} ${user_info.lname}</a>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                         
                    
                </c:when>
                <c:otherwise>
                    <a class="split login" href="<%= request.getContextPath() %>/Store/Login">Login</a>
                </c:otherwise>
            </c:choose>
                    
        </nav>
        <main>
            <h1 class="center">Popular Games Right Now!</h1>
            <h2 class="center">We offer the best prices on the market! More games coming soon your way!</h2>
            <div class="grid">
                <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                       url="jdbc:derby://localhost:1527/ConaShopDB" 
                                       user="cona" password="admin1"/>
                    <sql:query dataSource="${ds}" var="rs">
                        SELECT * FROM SUPPORTEDGAMES
                    </sql:query>
                    <c:forEach var="games" items="${rs.rows}">
                        <a href="${pageContext.request.contextPath}/Store/${games.GamePage}" class="games">
                            <div class="content">
                                <img alt="${games.GameName}" src='${games.GameIcon}' lazy class="game-imgs" id="${games.GameID}">
                                <label for="${games.GameID}">${games.GameName}</label>
                            </div>
                        </a>
                    </c:forEach>
            </div>
            
        </main>
    </body>
</html>
