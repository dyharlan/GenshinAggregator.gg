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
                    <form>
                        <input type="hidden" name="itemid" value="<%= request.getParameter("select")%>">
                        <input type="hidden" name="recipient" value="<%= request.getParameter("uid")%>">
                        <div class="captcha">
                            <label for="captcha">Captcha:</label>
                            <br>
                            <img src ="<%= request.getContextPath()%>/Store/captchaImg.png"/>
                            <br>
                            <input type="text" name="answer" id="captcha" class="form-control" placeholder="Enter the captcha" required />
                        </div>  
                        <input type="submit" value="Pay Now">    
                    </form>
            </section>
            
            </div>    
    </body>
</html>
