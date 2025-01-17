<!DOCTYPE html>

<html lang="en">
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="alert.js" defer></script>
        <link href="welcome-page.css" rel="stylesheet">
        <style>
            @font-face {
                font-family: 'zh-cn';
                src:url("<%=request.getContextPath()%>/<%= getServletContext().getInitParameter("asset-folder")%>zh-cn.ttf");
            }        
        </style>
        <title><%= getServletContext().getInitParameter("AppName")%> - Celebrating 1 year in the service of Tech Otakus!</title>
    </head>
    <body onload="">
        <section class="welcome-section">
            <img src="assets/ConaShop-Logo.png">
            <h1>Celebrating 1 year in the service of Tech Otakus!</h1>   
            <br>
            <a href="BannerViewer?goto=store"  class="store-redirect">Visit our Store now to recharge your crystals! We now Support Valorant.</a>
            
        </section>

        <!--<section class="news-section">
            <h1>Here are the latest news about Genshin Impact</h1> 

            <div class="news-articles">
                <article>
                    <p>test</p>
                </article>
    
                <article>
                    <p>test</p>
                </article>
    
                <article>
                    <p>test</p>
                </article>
            </div>
        </section>-->

        <section class="banner-section genshin">
            <h4>Time until server reset is: <%= getServletContext().getAttribute("resetTime") %></h4>
            <br>
            <h1 class="banner-header">Today's current banners are:</h1>
            <div class="banners">
                <div class="cbanner-1 cbanner child">
                    <h4>Character Banner 1</h4>
                    <p>Nahida</p>
                    <form action="BannerViewer" METHOD="GET">
                        <button type="submit" name="banner" value="b1"><img src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("asset-folder") %>cbanner1.png" alt="5 star 1st character"></button>
                    </form>
                        <a class="trailer-link" href="watch?v=<%= getServletContext().getInitParameter("video1") %> ">Watch the trailer now!</a>
                </div>
                <div class="cbanner-2 cbanner child">
                    <h4>Character Banner 2</h4>
                    <p>Nilou</p>
                    <form action="BannerViewer" METHOD="GET">
                        <button type="submit" name="banner" value="b2"><img src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("asset-folder") %>cbanner2.png" alt="5 star 2nd character"></button>
                    </form>
                        <a class="trailer-link" href="watch?v=<%= getServletContext().getInitParameter("video2") %> ">Watch the trailer now!</a>
                        
                </div>
               
                
                <div class="wbanner child">
                    <h4>Weapon Banner</h4>
                    <form action="BannerViewer" METHOD="GET">
                        <button type="submit" name="banner" value="wb"><img src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("asset-folder") %>wbanner.png" alt="Weapon Banner"></button>
                    </form>
                       
                </div>
            </div>
        </section>
                    
        <section class="banner-section hsr">
            <h4>Time until server reset is: <%= getServletContext().getAttribute("resetTime") %></h4>
            <br>
            <h1 class="banner-header">Today's current warp is:</h1> 
            <div class="banners">
                
                <div class="cbanner-1 cbanner child">
                    <h2>Seele</h2>
                    <form action="BannerViewer" METHOD="GET">
                        <button type="submit" name="banner" value="b1-hsr"><img src="<%= request.getContextPath() %>/<%= getServletContext().getInitParameter("asset-folder") %>HSR/BannerPage/splash/5s1.png" alt="5 star HSR Character"></button>
                    </form>
                        <a class="trailer-link" href="watch?v=<%= getServletContext().getInitParameter("video3") %> ">Watch the trailer now!</a>
                </div>
                
            </div>
        </section>
                
    </body>
</html>