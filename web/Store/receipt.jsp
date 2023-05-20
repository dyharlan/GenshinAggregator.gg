<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="receipt.css" rel="stylesheet">
        <link href="navbar.css" rel="stylesheet">
        <title>Receipt Page | GenshinStore.gg</title>
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
        </nav>
        <main>
            <c:if test="${empty sessionScope.transactionID || sessionScope.transactionID == null}">
                <c:redirect url="index.jsp"/>
            </c:if>
            <div class="receipt">
                <sql:setDataSource var="ds" driver="${initParam.className}" 
                                       url="${initParam.driverURL}://${initParam.dbHostName}:${initParam.dbPort}/${initParam.dbName}" 
                                       user="${initParam.dbUsername}" password="${initParam.dbPassword}"/>
                <sql:query dataSource="${ds}" var="rs">
                        select usertransactions.transactionid,personCredentials.EMAIL,personinfo.FNAME, personinfo.LNAME,transactioninfo.itemrecipient,transactioninfo.itemid,inventory.itemname,usertransactions.paymenttype,paymentmethods.paymentname,usertransactions.transactiondate,inventory.itemvalue from personcredentials join personinfo using(userid) join usertransactions using(userid) join paymentmethods using(paymenttype) join transactioninfo using(transactionid) join inventory using(itemid) WHERE TRANSACTIONID = ?
                        <sql:param value="${sessionScope.transactionID}" />  
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
                                
                                request.getSession().setAttribute("transactionID", null);
                                session.invalidate();
                        %>
                        <c:redirect url="Store/index.jsp"/>
                    </c:when> 
                        
                        <c:otherwise>
                            <c:forEach var="transaction_info" items="${rs.rows}">
                                <h1>Thank you for your patronage!</h1>
                                <hr class="line1">
                                <br>
                                <p>A copy of your transaction has been sent to your e-mail address: <!--Insert email here from form.html--> ${transaction_info.email}.</p>
                                <br>
                                <hr>
                                <br>
                                <div class="container">
                                    <div class="image">
                                        <img src="<%= request.getContextPath()%>/assets/mora.png">
                                    </div>
                                    <section>
                                        <h2>Transaction Summary:</h2>
                                        <br>
                                        <p>Client Name: <!--Insert First Name and Last name--> ${transaction_info.fname} ${transaction_info.lname}</p>
                                        <p>Recipient: <!--Insert UID the transaction will go to-->${transaction_info.itemrecipient}</p>
                                        <p>Selected Order: <!--Insert order like "Blessing of the Welkin Moon"--> ${transaction_info.itemname}</p>
                                        <p>Payment Method: <!--Insert Credit Card (not the number)--> ${transaction_info.paymentname}</p>
                                        <p>Transaction Date: <!--Insert YYYY-MM-DD HH:MM:SS (24 hr format)--> ${transaction_info.transactiondate}</p>
                                        <p>Total Price: ₱<!--Insert price in pesos--> ${transaction_info.itemvalue}</p>

                                    </section>
                                    <form action="<%=request.getContextPath()%>/Store/Receipt.pdf" target="_blank">
                                        <button type="submit">Print your receipt</button>
                                    </form>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                           
                </c:choose>
                
            </div>
        </main>
    </body>
</html>