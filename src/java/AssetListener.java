/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author dyhar
 */
import javax.servlet.*;
import java.time.LocalDate;
import java.time.Period;
public class AssetListener implements ServletContextListener{
    public void contextInitialized(ServletContextEvent sce) {
       ServletContext context = sce.getServletContext();
       
       context.setAttribute("versionTime", Period.between(LocalDate.now(), LocalDate.of(2022, 11, 2)).getDays());
    }
    
     public void contextDestroyed(ServletContextEvent sce) {
        
    }
}
