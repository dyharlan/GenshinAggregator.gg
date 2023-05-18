<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="form.css" rel="stylesheet">
        <title>Add a Credit Card</title>
        <script src="form.js" defer></script>
    </head>
    <body>
        <c:if test="${!(cookie.containsKey('let-him-cook1') && cookie.containsKey('let-him-cook2') && cookie.containsKey('let-him-cook3'))}">
            <c:redirect url = "index.jsp"/>
        </c:if>
        <h1>Credit Card Information</h1>
        <form action="CCProcessor" method="POST">
            <div class="section1 child">
                <div class="name">
                    <label for="fn">First Name</label>
                    <input id="fn" type="text" required placeholder="First Name" name="fname">
                </div> 
                <div class="name">
                    <label for="ln">Last Name</label>
                    <input id="ln" type="text" required placeholder="Last Name" name="lname">
                </div>
            </div>
<!--            <div class="section2 child">
                <label for="email">Email Address</label>
                <input id="email" type="email" required placeholder="Email Address" name="email">
            </div>-->
            <div class="section3 child">
                <label for="card">Credit Card Number</label>
                <div class="cc-digits">
<!--                    <input id="card1" type="text"  maxlength="4" placeholder="xxxx" name="card1" oninput="numOnly(this.id);" required>
                    <input id="card2" type="text"  maxlength="4" placeholder="xxxx" name="card2" oninput="numOnly(this.id);" required>
                    <input id="card3" type="text"  maxlength="4" placeholder="xxxx" name="card3" oninput="numOnly(this.id);" required>
                    <input id="card4" type="text"  maxlength="4" placeholder="xxxx" name="card4" oninput="numOnly(this.id);" required>-->
                    <input id="card" type="text" maxlength="19" oninput="numOnly(this.id);" placeholder="xxxx-xxxx-xxxx-xxxx" name="card" pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}" required>
                </div>
            </div>
            <div class="section4 child">
                    <label for="ccValid">Expiry date:</label>
                    <input type="date" id="ccValid" name="ccValid">
                    
            </div>
            
            <div class="section5 child">
                <fieldset>
                    <legend>Credit Card Type:</legend>
                    <input type="radio" id="visa" name="ccType" value="1" required><img src="<%= request.getContextPath()%>/assets/StorePage/visa.png" class="visa"><label for="visa">Visa</label><p>&nbsp;&nbsp;</p>
                    <input type="radio" id="mastercard" name="ccType" value="2" required><img src="<%= request.getContextPath()%>/assets/StorePage/mastercard.png" class="mastercard"><label for="mastercard">Mastercard</label>
                </fieldset>
            </div>
           
            <button type="submit">Add Credit Card</button>
        </form>
    </body>
</html>