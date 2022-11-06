<!DOCTYPE html>
<html>
    <%@ 
        page import="Model.BannerCharacter"
     %>
    <%
            BannerCharacter _5star = (BannerCharacter) request.getAttribute("5starchar");
            BannerCharacter _4star1 = (BannerCharacter) request.getAttribute("4starchar1");
            BannerCharacter _4star2 = (BannerCharacter) request.getAttribute("4starchar2");
            BannerCharacter _4star3 = (BannerCharacter) request.getAttribute("4starchar3");
    %>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="BannerPage/banner.css" rel="stylesheet">
        <script src="BannerPage/portrait.js"></script>
        <script id="vars" type="text/javascript">
            var _5splashpath = "assets/BannerPage/splash/<%=_5star.getCharSplash() %>";
            var _4splashpath1 = "assets/BannerPage/splash/<%=_4star1.getCharSplash() %>";
            var _4splashpath2 = "assets/BannerPage/splash/<%=_4star2.getCharSplash() %>";
            var _4splashpath3 = "assets/BannerPage/splash/<%=_4star3.getCharSplash() %>";
            
        </script>
    </head>
    <body background="assets/BannerPage/bg.jpg">
        <div class="navbar">
            <ul>
                <li><button class="tab-links" id="defaultOpen" onclick="changeContent(event, 'Nahida', _5splashpath )"><img  loading="lazy" src="assets/BannerPage/cportraits/<%= _5star.getCharPortrait()%>" alt="5 Star character"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, 'Noelle', _4splashpath1)"><img loading="lazy" src="assets/BannerPage/cportraits/4stars/4s1.png" alt="4 Star character #1"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, 'Bennett', _4splashpath2)"><img loading="lazy" src="assets/BannerPage/cportraits/4stars/4s2.png" alt="4 Star character #2"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, 'Razor', _4splashpath3)"><img loading="lazy" src="assets/BannerPage/cportraits/4stars/4s3.png" alt="4 Star character #3"></button></li>
            </ul>
        </div>
        <div class="main">
            
            <div class="box">
                <div class="column-1">
                    <img id="display" id="splashimg" loading="lazy" src="assets/BannerPage/splash/<%=_5star.getCharSplash() %>" >
                </div>
                <div class="column-2">
                    <div class="row-1">
                        <h3>Info about Rate Up</h3>
                        <div id="ru1" class="tab-content"><%= _5star.getDescription() %></div>
                        <div id="ru2" class="tab-content"><%= _4star1.getDescription() %></div>
                        <div id="ru3" class="tab-content"><%= _4star2.getDescription() %></div>
                        <div id="ru4" class="tab-content"><%= _4star3.getDescription() %></div>
                    </div>
                    <div class="row-2">
                        <h3>Personal Opinion</h3>
                        <div id="po1" class="tab-content"><%= _5star.getOpinion() %></div>
                        <div id="po2" class="tab-content"><%= _4star1.getOpinion() %></div>
                        <div id="po3" class="tab-content"><%= _4star2.getOpinion() %></div>
                        <div id="po4" class="tab-content"><%= _4star3.getOpinion() %></div>
                    </div>
                </div>
            </div>
        </div>


    </body>
</html>