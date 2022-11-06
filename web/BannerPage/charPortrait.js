function changeContent(evt, charName, spashpath) {
    var i, tabContent, tabLinks, rateUp, perOp;
    if (charName == "Nahida") {
        document.getElementById("display").src = spashpath;
        rateUp = "ru1";
        perOp = "po1";
    }
    else if (charName == "Noelle") {
        document.getElementById("display").src= spashpath;
        rateUp = "ru2";
        perOp = "po2";
    }
    else if (charName == "Bennett") {
        document.getElementById("display").src= spashpath;
        rateUp = "ru3";
        perOp = "po3";
    }
    else { //charName == "Razor"
        document.getElementById("display").src= spashpath;
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