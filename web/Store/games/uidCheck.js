/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
var regex = '';


function setRegex() {
    if (document.getElementById("server").value === 'na') {
        document.getElementById("uid").pattern = "^6[0-9]{0,8}$";
        document.getElementById("uid").title = "Please re-enter your UID. NA accounts start with 6"
    } else if (document.getElementById("server").value === 'eu') {
        document.getElementById("uid").pattern = "^7[0-9]{0,8}$";
        document.getElementById("uid").title = "Please re-enter your UID. EU accounts start with 7"
    } else if (document.getElementById("server").value === 'asia') {
        document.getElementById("uid").pattern = "^8[0-9]{0,8}$";
        document.getElementById("uid").title = "Please re-enter your UID. Asia accounts start with 8"
    } else if (document.getElementById("server").value === 'sar') {
        document.getElementById("uid").pattern = "^9[0-9]{0,8}$";
        document.getElementById("uid").title = "Please re-enter your UID. TW/SAR accounts start with 9"
    } else {
        document.getElementById("uid").pattern = "^[0-9]{0,9}$";
        document.getElementById("uid").title = "Please enter a valid server"
    }

}

