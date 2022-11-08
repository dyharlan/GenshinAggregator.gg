/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author dyhar
 */
import javax.servlet.*;

import java.time.LocalTime;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import static java.time.temporal.ChronoUnit.HOURS;

public class AssetListener implements ServletContextListener{
    public void contextInitialized(ServletContextEvent sce) {
       ServletContext context = sce.getServletContext();
       LocalTime curr = LocalTime.now();
       DateTimeFormatter dtf = new DateTimeFormatterBuilder()
                                .parseCaseInsensitive()
                                .appendPattern("h:m a")
                                .toFormatter(Locale.ENGLISH);
       
       LocalTime resetTime = LocalTime.parse("4:00 am", dtf);
       context.setAttribute("resetTime", curr.until(resetTime, HOURS)+24);
       
    }
    
     public void contextDestroyed(ServletContextEvent sce) {
        
    }
}
