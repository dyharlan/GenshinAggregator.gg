function changeContent(evt, weapName, spashpath) {
    var i, tabContent, tabLinks, rateUp, perOp;
    if (weapName == "5starWeap1") {
        document.getElementById("display").src = spashpath;
        rateUp = "ru1";
        perOp = "po1";
    }
    else if (weapName == "5starWeap2") {
        document.getElementById("display").src= spashpath;
        rateUp = "ru2";
        perOp = "po2";
    }
    else if (weapName == "4starSword") {
        document.getElementById("display").src= spashpath;
        rateUp = "ru3";
        perOp = "po3";
    }
    else if (weapName == "4starBow") {

    }
    else if (weapName == "4starSpear") {

    }
    else if (weapName == "4starClaymore") {

    }
    else { //weapName == "4starCatalyst"
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