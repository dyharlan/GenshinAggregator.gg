<%-- 
    Document   : index
    Created on : Apr 28, 2023, 9:14:44 PM
    Author     : csean
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@page import="Controller.Security"%>
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
        <link rel="stylesheet" href="summary.css">
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

        </nav>
        <main>
            <section>
                <div class="order">
                    <div>
                        <h1>Order Summary</h1>
                    </div>
                    <c:if test="${empty param.select && empty param.uid && !(cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3'))}">
                        <c:redirect url="index.jsp"/>
                    </c:if>
                    <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                       url="jdbc:derby://localhost:1527/ConaShopDB" 
                                       user="cona" password="admin1"/>
                    <sql:query dataSource="${ds}" var="rs">
                        SELECT * FROM INVENTORY WHERE ITEMID = '<%= request.getParameter("select")%>'
                    </sql:query>
                    <c:forEach var="genshin" items="${rs.rows}">
                        <div class="${genshin.ItemID} child">
                            <div class="content"><label><img src="${pageContext.servletContext.contextPath}${genshin.ItemPic}" width="225" height="225"><p class="desc">${genshin.ItemName}</p><p class="price">₱${genshin.ItemValue}</p></label></div>

                            <p>Recipient's ID: <%= request.getParameter("uid")%></p>
                        </div>   
                    </c:forEach>
                    <form action="${pageContext.servletContext.contextPath}/Store/Checkout" method="POST">
                        <input type="hidden" name="itemid" value="<%= request.getParameter("select")%>">
                        <input type="hidden" name="recipient" value="<%= request.getParameter("uid")%>">
                        <div class="payment">
                            
                            <div class="payment-container">
                                <!-- for (database) -->
                                <c:set var="paymentType" value="1"/> 
                                <c:set var="uID" value="${Integer.valueOf(cookie['let-him-cook1'].value)}"/> 
                                <sql:query dataSource="${ds}" var="rs">
                                    SELECT USERPAYMENTMETHODS.USERID, USERPAYMENTMETHODS.PMIDENTIFIER, USERPAYMENTMETHODS.PAYMENTTYPE, CCARDINFO.CCTYPE, CCARDINFO.CCNUMBER FROM USERPAYMENTMETHODS JOIN CCARDINFO USING(PMIDENTIFIER) WHERE PAYMENTTYPE = ? AND USERPAYMENTMETHODS.USERID = ?
                                    <sql:param value="${paymentType}" />   
                                    <sql:param value="${uID}" />   
                                </sql:query>
                                <c:choose>
                                    <c:when test="${rs.rowCount <= 0}">
                                        <c:set var="noPaymentMethods" value="true"/>
                                        <h3>You have no available payment Methods! Go to <a href="${pageContext.servletContext.contextPath}/Store/profile.jsp">Profile</a> to add one.</h3>
                                    </c:when>
                                    <c:otherwise>
                                        <h1>Select Payment Method:</h1>
                                        <% Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));%>
                                        <c:forEach var="payment_info" items="${rs.rows}">
                                            
                                            <c:set var="ccEnc" value="${payment_info.CCNUMBER}"/>
                                            <c:set var="string1" value="<%= sec.decrypt((String) pageContext.getAttribute("ccEnc"))%>"/>
                                            <c:set var="string2" value="${fn:substring(string1, 1 % fn:length(string1), fn:length(string1)-3 % fn:length(string1))}" />

                                            <%
                                                String x = (String) pageContext.getAttribute("string2");
                                                StringBuilder sb = new StringBuilder();
                                                for (int i = 0; i < x.length(); i++) {
                                                    sb.append('*');
                                                }
                                            %>
                                            <c:set var="tmpStr" value="<%= sb.toString()%>"/>
                                            <c:set var="string3" value="${    fn:replace(string1, string2, tmpStr)   }" />
                                            <c:set var="tmpStr2" value="${payment_info.pmidentifier}"/>
                                            <c:if test="${payment_info.CCTYPE == 1}">
                                                <div class="child"><input type="radio" id="visa" name="paymentMethod" value="<%= sec.encrypt((String)pageContext.getAttribute("tmpStr2"))%>" required><img src="<%= request.getContextPath()%>/assets/StorePage/visa.png" class="visa"><label for="visa"><c:out value="${string3}"/></label></div>
                                            </c:if>
                                            <c:if test="${payment_info.CCTYPE == 2}">
                                                <div class="child"><input type="radio" id="mastercard" name="paymentMethod" value="<%= sec.encrypt((String)pageContext.getAttribute("tmpStr2"))%>" required><img src="<%= request.getContextPath()%>/assets/StorePage/mastercard.png" class="mastercard"><label for="mastercard"><c:out value="${string3}"/></label></div>
                                            </c:if>
                                                
                                               
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>


<!--            <div class="child"><input type="radio" id="gcash" name="payment" value="gcash"><label for="gcash"><img src="<%= request.getContextPath()%>/assets/StorePage/gcash.png" class="gcash"></label></div>-->
                            </div>
                        </div>   
                        <div class="captcha">
                            <label for="captcha">Captcha:</label>
                            <br>
                            <img src ="<%= request.getContextPath()%>/Store/captchaImg.png"/>
                            <br>
                             <% if (session.getAttribute("captcha-failure") != null && (((Boolean) session.getAttribute("captcha-failure"))) == true) { %>
                                <p>Wrong answer. Please try again.</p>
                            <% } %>
                            <input type="text" name="answer" id="captcha" class="form-control" placeholder="Enter the captcha" required />
                        </div>  
                        <c:if test="${!noPaymentMethods == true}">
                            <input type="submit" value="Pay Now">    
                        </c:if>
                    </form>
                </div>
                    
            </section>
            
    </body>
</html>
