<%-- 
    Document   : profile
    Created on : May 18, 2023, 4:23:56 PM
    Author     : csean
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@page import="Controller.Security"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="profile.css">
        <link rel="stylesheet" href="navbar.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&display=swap">
        <script defer src="profile.js"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
            <p1 class="navbar-text">Celebrating 1 year in the service of Tech Otakus!</p1>
        </nav>
        <main>
            <c:choose>
                <c:when test="${!(cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3'))}">
                    <c:redirect url = "index.jsp"/>
                </c:when>
                <c:when test="${cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3')}">
                    <c:set var="param1" value="${Integer.valueOf(cookie['let-him-cook1'].value)}"/> 
                    <c:set var="param2" value="${cookie['let-him-cook2'].value}"/> 
                    <c:set var="param3" value="${cookie['let-him-cook3'].value}"/> 
                    <sql:setDataSource var="ds" driver="org.apache.derby.jdbc.ClientDriver" 
                                       url="jdbc:derby://localhost:1527/ConaShopDB" 
                                       user="cona" password="admin1"/>
                    <sql:query dataSource="${ds}" var="rs">
                        SELECT PersonInfo.USERID,PersonInfo.FNAME,PersonInfo.LNAME,PersonInfo.DOB FROM PersonInfo JOIN PersonCredentials USING(UserID) where USERID = ? AND EMAIL = ? AND PASSWORD = ?
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
                             
                         </c:when>  
                        <c:otherwise>
                            <c:set var="isLoggedIn" value="true"/>
                            <c:forEach var="user_info" items="${rs.rows}">
                                
                                <h1>Profile Page</h1>
                                <p>First Name: ${user_info.fname}</p>
                                <p>Last Name: ${user_info.lname}</p>
                                <p>Date of Birth: ${user_info.DOB}</p>

                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </c:when>
            </c:choose>
            <!-- Trigger/Open The Modal -->
            <h2>Available Payment Methods</h2>
            <c:choose>
                <c:when test="${!isLoggedIn == true}">
                    <c:redirect url = "index.jsp"/>
                </c:when>
                <c:when test="${isLoggedIn == true}">
                    <c:set var="paymentType" value="1"/> 
                    <c:set var="uID" value="${Integer.valueOf(cookie['let-him-cook1'].value)}"/> 
                   
                    <sql:query dataSource="${ds}" var="rs">
                        SELECT USERPAYMENTMETHODS.USERID, USERPAYMENTMETHODS.PMIDENTIFIER, USERPAYMENTMETHODS.PAYMENTTYPE, CCARDINFO.CCTYPE, CCARDINFO.CCNUMBER FROM USERPAYMENTMETHODS JOIN CCARDINFO USING(PMIDENTIFIER) WHERE PAYMENTTYPE = ? AND USERPAYMENTMETHODS.USERID = ?
                        <sql:param value="${paymentType}" />   
                        <sql:param value="${uID}" />   
                    </sql:query>
                    <% Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));%>
                    <c:forEach var="cc_info" items="${rs.rows}">            
                        <c:set var="ccEnc" value="${cc_info.CCNUMBER}"/>
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
                        <c:set var="tmpStr2" value="${cc_info.pmidentifier}"/>
                        <c:if test="${cc_info.CCTYPE == 1}">
                            <form action="PaymentManager" method="post">
                                <input type="hidden" name="pmIdentifier" value="<%= sec.encrypt((String)pageContext.getAttribute("tmpStr2"))%>"/>
                                <img class="visa" lazy alt="Visa" src="${pageContext.servletContext.contextPath}/assets/StorePage/visa.png"/>
                                <h3>Visa</h3><p><c:out value="${string3}"/></p>
                                <input type="submit" value="Delete">
                            </form>
                        </c:if>
                        <c:if test="${cc_info.CCTYPE == 2}">
                            <form action="PaymentManager" method="post">
                                <input type="hidden" name="pmIdentifier" value="<%= sec.encrypt((String)pageContext.getAttribute("tmpStr2"))%>"/>
                                <img class="mastercard" lazy alt="Mastercard" src="${pageContext.servletContext.contextPath}/assets/StorePage/mastercard.png"/>
                                <h3>MasterCard</h3><p><c:out value="${string3}"/></p>
                                <input type="submit" value="Delete">
                            </form>
                        </c:if>
                            
                            

                    </c:forEach>
                </c:when>
            </c:choose>
            <button id="payment-btn">Add Payment Method</button>
            <!-- The Modal -->
            <div id="modal-container" class="modal">

                <!-- Modal content -->
                <div class="modal-content">
                    <div class="modal-header">
                        <span class="close">&times;</span>
                        <h2>Select Payment Method</h2>
                    </div>
                    <div class="modal-body">
                        <a href="${pageContext.request.contextPath}/Store/gcash-add.jsp" class="modal-btn">GCash</a>
                        <a href="${pageContext.request.contextPath}/Store/cc-add.jsp" class="modal-btn">Credit Card</a>
                    </div>
                </div>
  
            </div>
        </main>
    </body>
</html>
