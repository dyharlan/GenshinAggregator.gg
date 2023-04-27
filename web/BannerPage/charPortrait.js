function changeContent(evt, charNum, spashpath) {
    var i, tabContent, tabLinks, rateUp, perOp;
    if (charNum === '1') {
        document.getElementById("display").src = spashpath;
        rateUp = "ru1";
        perOp = "po1";
    }
    else if (charNum === '2') {
        document.getElementById("display").src= spashpath;
        rateUp = "ru2";
        perOp = "po2";
    }
    else if (charNum === '3') {
        document.getElementById("display").src= spashpath;
        rateUp = "ru3";
        perOp = "po3";
    }
    else if (charNum === '4') { 
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
//document.getElementById("defaultOpen").click();