/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author dyhar
 */
import java.time.Duration;
import javax.servlet.*;

import java.time.LocalTime;
import java.time.LocalDate;
import java.time.format.DateTimeFormatterBuilder;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import static java.time.temporal.ChronoUnit.HOURS;
import static java.time.temporal.ChronoUnit.MINUTES;

//Create date objects for the game's reset times and for transaction logging
public class DateListener implements ServletContextListener{
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        LocalTime curr = LocalTime.now();
        LocalDate currDate = LocalDate.now();
        DateTimeFormatter dtf = new DateTimeFormatterBuilder()
                                .parseCaseInsensitive()
                                .appendPattern("h:m a")
                                .toFormatter(Locale.ENGLISH);
        LocalTime resetTime = LocalTime.parse("4:00 am", dtf);
        Duration duration = Duration.between(curr, resetTime);
        long hours, minutes, seconds;
        if (duration.isNegative())
        {
            //duration = duration.negated(); //see comments below for an alternative code without this line
            hours = duration.plusHours(24).toHours() % 24;
            minutes = duration.plusMinutes(1440).toMinutes() % 60; //ChronoUnit.MINUTES.between(resetTime,curr);
            seconds = duration.plusSeconds(86400).getSeconds() % 60; //ChronoUnit.SECONDS.between(resetTime,curr);
        }
        else
        {
            hours = duration.toHours();
            minutes = duration.toMinutes();
            seconds = duration.getSeconds();
        }
        StringBuilder countdown = new StringBuilder();
        if (!(hours == 0))
        {
            countdown = countdown.append(String.format("%d hour", hours));
            if (hours != 1)
                countdown.append("s");
        }
        else if (!(minutes == 0))
        {
            countdown = countdown.append(String.format("%d minute",minutes));
            if (minutes != 1)
                countdown.append("s");
        }
        else
        {
            countdown.append(String.format("%d second",seconds));
            if (seconds != 1)
                countdown.append("s");
            /*the following is also possible
                countdown.append(String.format("%d seconds",seconds));
                if (seconds == 1)
                    countdown.delete(countdown.lastIndexOf(countdown.toString()));
            */
        }
        if (countdown.toString().isEmpty())
            countdown.append("NaN");
//       if (curr.until(resetTime, HOURS) == 0)
//        {
//            if (curr.until(resetTime, MINUTES) < 0)
//                //System.out.println("resetTime: " + (curr.until(resetTime, HOURS)+23) + " hours");
//                countdown = (curr.until(resetTime, HOURS)+23) + " hours";
//            else
//            {
//                if (curr.until(resetTime, MINUTES) == 1)
//                    //System.out.println("resetTime: " + (curr.until(resetTime, MINUTES)) + " minute");
//                    countdown = (curr.until(resetTime, MINUTES)) + " minute";
//                else
//                    //System.out.println("resetTime: " + (curr.until(resetTime, MINUTES)) + " minutes");
//                    countdown = (curr.until(resetTime, MINUTES)) + " minutes";
//            }
//        }
//        else if (curr.until(resetTime,HOURS) < 0)
//        {
//            if (curr.until(resetTime, MINUTES) < 0)
//                //System.out.println("resetTime: " + (curr.until(resetTime, HOURS)+24) + " hours");
//                countdown = (curr.until(resetTime, HOURS)+24) + " hours";
//        }
//        else
//        {
//            if (curr.until(resetTime, HOURS) == 1)
//                //System.out.println("resetTime: " + curr.until(resetTime, HOURS) + " hour");
//                countdown = curr.until(resetTime, HOURS) + " hour";
//            else
//                //System.out.println("resetTime: " + curr.until(resetTime, HOURS) + " hours");
//                countdown = curr.until(resetTime, HOURS) + " hours";
//        }
        
        context.setAttribute("resetTime", countdown.toString());
        context.setAttribute("currTime", curr);
        context.setAttribute("currDate", currDate);
    }
    
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
}
