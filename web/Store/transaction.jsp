<%-- 
    Document   : transaction
    Created on : May 19, 2023, 7:56:58 PM
    Author     : csean
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction History</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="navbar.css"/>
        <link rel="stylesheet" href="transaction.css">
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
                                <a class="split login" href="<%= request.getContextPath() %>/Store/Logout">Logout</a>
                                <a class="bx bx-shopping-bag split" id="cart-icon" href="cart.jsp"></a>
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
            <table>
                <tr>
                    <th>Transaction ID</th>
                    <th>Recipient</th>
                    <th>Item Name</th>
                    <th>Payment Type</th>
                    <th>Transaction Date</th>
                    <th>Item Value</th>
                </tr>
                <tr>
                    <td>Sample Text</td>
                    <td>Sample Text</td>
                    <td>Sample Text</td>
                    <td>Sample Text</td>
                    <td>Sample Text</td>
                    <td>Sample Text</td>
                </tr>
            </table>
        </main>
    </body>
</html>
