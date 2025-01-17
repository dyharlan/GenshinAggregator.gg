<!DOCTYPE html>
<html>
    <%@ 
        page import="Model.BannerPrize"
     %>
    <%
            BannerPrize _5star = (BannerPrize) request.getAttribute("5starchar");
            BannerPrize _4star1 = (BannerPrize) request.getAttribute("4starchar1");
            BannerPrize _4star2 = (BannerPrize) request.getAttribute("4starchar2");
            BannerPrize _4star3 = (BannerPrize) request.getAttribute("4starchar3");
    %>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="BannerPage/banner.css" rel="stylesheet">
        <script defer src="BannerPage/charPortrait.js"></script>
        <script defer id="vars" type="text/javascript">
            var _5splashpath = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/splash/<%=_5star.getSplashArt() %>";
            var _4splashpath1 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/splash/<%=_4star1.getSplashArt() %>";
            var _4splashpath2 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/splash/<%=_4star2.getSplashArt() %>";
            var _4splashpath3 = "<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/splash/<%=_4star3.getSplashArt() %>";
        </script>
        <title>Character Banner Page | <%= getServletContext().getInitParameter("AppName")%></title>
        <style>
            @font-face {
                font-family: 'zh-cn';
                src:url("<%=request.getContextPath()%>/<%= getServletContext().getInitParameter("asset-folder")%>zh-cn.ttf");
            } 
        </style>
    </head>
    <body background="<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/bg.jpg" onload="changeContent(event, '1', _5splashpath)">
        
        <div class="navbar">
            <ul>
                <li><button class="tab-links" id="defaultOpen" onclick="changeContent(event, '1', _5splashpath )"><img  loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/portraits/<%= _5star.getPortrait()%>" alt="5 Star character"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '2', _4splashpath1)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/portraits/4stars/<%= _4star1.getPortrait() %>" alt="4 Star character #1"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '3', _4splashpath2)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/portraits/4stars/<%= _4star2.getPortrait() %>" alt="4 Star character #2"></button></li>
                <li><button class="tab-links" onclick="changeContent(event, '4', _4splashpath3)"><img loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/portraits/4stars/<%= _4star3.getPortrait() %>" alt="4 Star character #3"></button></li>
            </ul>
        </div>
        <div class="main">
            <div class="box">
                <div class="column-1">
                    <img id="display" id="splashimg" loading="lazy" src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("hsr-bannerpage-asset-folder") %>/splash/<%=_5star.getSplashArt() %>" >
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