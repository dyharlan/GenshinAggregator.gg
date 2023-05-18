/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */

function numOnly(id) {
    // Get the element by id
    var element = document.getElementById(id);
    // Use numbers only pattern, from 0 to 9 with \-
    var regex = /[^0-9\-]/gi;
    // Replace other characters that are not in regex pattern
    element.value = element.value.replace(regex, "");
}

function $(x) { //use this function only when not using a "template literal"
    return document.getElementById(x);
}

$("card").addEventListener("input",function(){
    let foo = this.value.split("-").join(""); // remove hyphens
    if (foo.length > 0) {
      foo = foo.match(new RegExp('.{1,4}', 'g')).join("-");
    }
    this.value = foo;
});

function dashFunction() { 
    //JQuery
//    var foo = $(this).val().split("-").join(""); // remove hyphens
//    if (foo.length > 0) {
//      foo = foo.match(new RegExp('.{1,4}', 'g')).join("-");
//    }
//    $(this).val(foo);
    
    //converted to JavaScript
    let foo = this.value.split("-").join(""); // remove hyphens
    if (foo.length > 0) {
      foo = foo.match(new RegExp('.{1,4}', 'g')).join("-");
    }
    this.value = foo;
}
