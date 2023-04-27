<html>
    <head>
        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300&display=swap" rel="stylesheet">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="<%=request.getContextPath()%>/error.css" rel="stylesheet">
        <title>How are you even in here?</title>
        <style>
            h1 {
                font-size: 2em;
            }
        </style>
    </head>

    <body background="<%=request.getContextPath()%>/<%= getServletContext().getInitParameter("asset-folder")%>bg2.jpg">
        <main>

            <div class="error-div">
                <div class="col1">
                    <img src="<%=request.getContextPath()%>/<%= getServletContext().getInitParameter("asset-folder")%>statuscodes/403b.png"></img>
                </div>
                <div class="col2">
                    <h1>Error 403 - Forbidden access!</h1>
                    
                    <h3>Mona sensed that you were accessing things you weren't supposed to. So she put a ward to stop you!</h3>
                    <a href="<%=request.getContextPath()%>">Go back to Homepage.</a>
                </div>
            </div>

        </main>
    </body>
</html>