<!DOCTYPE html>
<html>
    <%@ 
        page import="Model.BannerPrize"
     %>
    <%
            BannerPrize _5star1 = (BannerPrize) request.getAttribute("5starwpn1");
            BannerPrize _5star2 = (BannerPrize) request.getAttribute("5starwpn2");
            BannerPrize _4star1 = (BannerPrize) request.getAttribute("4starwpn1");
            BannerPrize _4star2 = (BannerPrize) request.getAttribute("4starwpn2");
            BannerPrize _4star3 = (BannerPrize) request.getAttribute("4starwpn3");
            BannerPrize _4star4 = (BannerPrize) request.getAttribute("4starwpn4");
            BannerPrize _4star5 = (BannerPrize) request.getAttribute("4starwpn5");

    %>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="BannerPage/banner.css" rel="stylesheet">
        <script defer src="BannerPage/weapPortrait.js"></script>
        <script defer id="vars" type="text/javascript">
            var _5splashpath1 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_5star1.getSplashArt() %>";
            var _5splashpath2 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_5star2.getSplashArt() %>";
            var _4splashpath1 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_4star1.getSplashArt() %>";
            var _4splashpath2 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_4star2.getSplashArt() %>";
            var _4splashpath3 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_4star3.getSplashArt() %>";
            var _4splashpath4 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_4star4.getSplashArt() %>";
            var _4splashpath5 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_4star5.getSplashArt() %>";
            
        </script>
        <title>Weapon Banner Page | <%= getServletContext().getInitParameter("AppName")%></title>
        <style>
            @font-face {
                font-family: 'zh-cn';
                src:url("<%=request.getContextPath()%>/<%= getServletContext().getInitParameter("asset-folder")%>zh-cn.ttf");
            } 
        </style>
       
    </head>
    <body background="assets/BannerPage/bg.jpg" onload="changeContent(event, '1', _5splashpath1)">
        <div class="navbar">
            <ul>
                <li><button class="tab-links" id="defaultOpen" onclick="changeContent(event, '1', _5splashpath1 )"><img  loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/wportraits/<%= _5star1.getPortrait()%>" alt="5 Star weapon #1"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '2', _5splashpath2 )"><img  loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/wportraits/<%= _5star2.getPortrait()%>" alt="5 Star weapon #2"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '3', _4splashpath1)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/wportraits/4stars/4sw1.png" alt="4 Star weapon #1"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '4', _4splashpath2)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/wportraits/4stars/4sw2.png" alt="4 Star weapon #2"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '5', _4splashpath3)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/wportraits/4stars/4sw3.png" alt="4 Star weapon #3"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '6', _4splashpath4)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/wportraits/4stars/4sw4.png" alt="4 Star weapon #4"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '7', _4splashpath5)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/wportraits/4stars/4sw5.png" alt="4 Star weapon #5"></button></li>
            </ul>
        </div>
        <div class="main">
            
            <div class="box">
                <div class="column-1">
                    <img id="display" id="splashimg" loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("bannerpage-asset-folder") %>/splash/<%=_5star1.getSplashArt() %>" >
                </div>
                <div class="column-2">
                    <div class="row-1">
                        <h3>Info about Rate Up</h3>
                        <div id="ru1" class="tab-content"><%= _5star1.getDescription() %></div>
                        <div id="ru2" class="tab-content"><%= _5star2.getDescription() %></div>
                        <div id="ru3" class="tab-content"><%= _4star1.getDescription() %></div>
                        <div id="ru4" class="tab-content"><%= _4star2.getDescription() %></div>
                        <div id="ru5" class="tab-content"><%= _4star3.getDescription() %></div>
                        <div id="ru6" class="tab-content"><%= _4star4.getDescription() %></div>
                        <div id="ru7" class="tab-content"><%= _4star5.getDescription() %></div>
                    </div>
                    <div class="row-2">
                        <h3>Personal Opinion</h3>
                        <div id="po1" class="tab-content"><%= _5star1.getOpinion() %></div>
                        <div id="po2" class="tab-content"><%= _5star2.getOpinion() %></div>
                        <div id="po3" class="tab-content"><%= _4star1.getOpinion() %></div>
                        <div id="po4" class="tab-content"><%= _4star2.getOpinion() %></div>
                        <div id="po5" class="tab-content"><%= _4star3.getOpinion() %></div>
                        <div id="po6" class="tab-content"><%= _4star4.getOpinion() %></div>
                        <div id="po7" class="tab-content"><%= _4star5.getOpinion() %></div>
                    </div>
                </div>
            </div>
        </div>


    </body>
</html>