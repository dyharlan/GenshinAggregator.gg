function changeContent(evt, charName) {
    var i, tabContent, tabLinks, rateUp, perOp;
    if (charName == "Nahida") {
        document.getElementById("display").src = document.querySelector('#vars').getAttribute('path');
        rateUp = "ru1";
        perOp = "po1";
    }
    else if (charName == "Noelle") {
        document.getElementById("display").src="assets/splash/4splash1.png";
        rateUp = "ru2";
        perOp = "po2";
    }
    else if (charName == "Bennett") {
        document.getElementById("display").src="assets/splash/4splash2.png";
        rateUp = "ru3";
        perOp = "po3";
    }
    else { //charName == "Razor"
        document.getElementById("display").src="assets/splash/4splash3.png"
        rateUp = "ru4";
        perOp = "po4";
    }
    
    tabContent = document.getElementsByClassName("tab-content");
    for (i = 0; i < tabContent.length; i++) {
        tabContent[i].style.display = "none";
    }

    tabLinks = document.getElementsByClassName("tab-links");
    for (i = 0; i < tabLinks.length; i++) {
        tabLinks[i].className = tabLinks[i].className.replace(" active", "");
    }

    document.getElementById(rateUp).style.display = "block";
    document.getElementById(perOp).style.display = "block";

    evt.currentTarget.className += " active";
}
document.getElementById("defaultOpen").click();