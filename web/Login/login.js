/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function showPassword() {
    var pass = document.getElementById("password");
    if (pass.type === "password")
        pass.type = "text";
    else
        pass.type = "password";
}
