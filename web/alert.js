/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/javascript.js to edit this template
 */


function showSize() {
    let innerwidth = window.innerWidth;
    let innerheight = window.innerHeight;
    alert(`(Inner) The viewport's width is ${innerwidth} and the height is ${innerheight}.`);
    let outerwidth = window.outerWidth;
    let outerheight = window.outerHeight;
    alert(`(Outer) The viewport's width is ${outerwidth} and the height is ${outerheight}.`);
}