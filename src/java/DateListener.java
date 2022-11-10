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
import static java.time.temporal.ChronoUnit.MINUTES;
import static java.time.temporal.ChronoUnit.SECONDS;

public class DateListener implements ServletContextListener{
    public void contextInitialized(ServletContextEvent sce) {
       ServletContext context = sce.getServletContext();
       LocalTime curr = LocalTime.now();
       DateTimeFormatter dtf = new DateTimeFormatterBuilder()
                                .parseCaseInsensitive()
                                .appendPattern("h:m a")
                                .toFormatter(Locale.ENGLISH);
       
       LocalTime resetTime = LocalTime.parse("4:00 am", dtf);
       String countdown = "NaN";
       if (curr.until(resetTime, HOURS) == 0)
        {
            if (curr.until(resetTime, MINUTES) < 0)
                //System.out.println("resetTime: " + (curr.until(resetTime, HOURS)+23) + " hours");
                countdown = (curr.until(resetTime, HOURS)+23) + " hours";
            else
            {
                if (curr.until(resetTime, MINUTES) == 1)
                    //System.out.println("resetTime: " + (curr.until(resetTime, MINUTES)) + " minute");
                    countdown = (curr.until(resetTime, MINUTES)) + " minute";
                else
                    //System.out.println("resetTime: " + (curr.until(resetTime, MINUTES)) + " minutes");
                    countdown = (curr.until(resetTime, MINUTES)) + " minutes";
            }
        }
        else if (curr.until(resetTime,HOURS) < 0)
        {
            if (curr.until(resetTime, MINUTES) < 0)
                //System.out.println("resetTime: " + (curr.until(resetTime, HOURS)+24) + " hours");
                countdown = (curr.until(resetTime, HOURS)+24) + " hours";
        }
        else
        {
            if (curr.until(resetTime, HOURS) == 1)
                //System.out.println("resetTime: " + curr.until(resetTime, HOURS) + " hour");
                countdown = curr.until(resetTime, HOURS) + " hour";
            else
                //System.out.println("resetTime: " + curr.until(resetTime, HOURS) + " hours");
                countdown = curr.until(resetTime, HOURS) + " hours";
        }
       context.setAttribute("resetTime", countdown);
    }
    
     public void contextDestroyed(ServletContextEvent sce) {
        
    }
}