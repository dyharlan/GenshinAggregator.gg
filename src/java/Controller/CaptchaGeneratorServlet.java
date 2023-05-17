package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.captcha.*;
import nl.captcha.servlet.*;
import nl.captcha.backgrounds.*;
import javax.servlet.ServletConfig;
import java.util.Date;
/**
 *
 * @author dyhar
 */
public class CaptchaGeneratorServlet extends HttpServlet {

  
    //default is 10 minutes
    private static long _ttl = 1000 * 60 * 10;
    private static int _width = 200;
    private static int _height = 50;
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    	if (getInitParameter("captcha-height") != null) {
    		_height = Integer.valueOf(getInitParameter("captcha-height"));
    	}
    	
    	if (getInitParameter("captcha-width") != null) {
    		_width = Integer.valueOf(getInitParameter("captcha-width"));
    	}
    	
        if (getInitParameter("ttl") != null) {
            _ttl = 1000 * 60 * Long.valueOf(getInitParameter("ttl"));
        }
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
     public void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Captcha captcha;
        Boolean captcha_failure = (Boolean)req.getSession().getAttribute("captcha-failure");
        Boolean sql_failure = (Boolean)req.getSession().getAttribute("sql-failure");
        System.out.println("captcha fail?" + captcha_failure);
        System.out.println("sql fail?" + sql_failure);
        if (session.getAttribute(Captcha.NAME) == null) {
            captcha = buildAndSetCaptcha(session);
        }

        captcha = (Captcha) session.getAttribute(Captcha.NAME);
        if (shouldExpire(captcha)) {
            captcha = buildAndSetCaptcha(session);
        }
        //regenerate captcha when sql failure occurs or when captcha failure occurs
        if ((captcha_failure != null && captcha_failure == true) || (sql_failure != null && sql_failure == true)) {
           
            captcha = buildAndSetCaptcha(session);
        }
        
        CaptchaServletUtil.writeImage(resp, captcha.getImage());
    }
     
    private Captcha buildAndSetCaptcha(HttpSession session) {
        Captcha captcha = new Captcha.Builder(_width, _height)
            .addText()
            .gimp()
            .addBorder()
            .addNoise()
            .addNoise()
            .addBackground(new SquigglesBackgroundProducer())
            .build();

        session.setAttribute(Captcha.NAME, captcha);
        return captcha;
    }
    
    // Expire the CAPTCHA after a given number of minutes
    static boolean shouldExpire(Captcha captcha) {
        long ts = captcha.getTimeStamp().getTime();
        long now = new Date().getTime();
        long diff = now - ts;

        return diff >= _ttl;
    }
    
    /**
     * Set the length of time the CAPTCHA will live in session, in milliseconds.
     * 
     * @param ttl
     */
    static void setTtl(long ttl) {
        if (ttl < 0) {
            ttl = 0;
        }

        _ttl = ttl;
    }

    /**
     * Get the time to live for the CAPTCHA, in milliseconds.
     * 
     * @return
     */
    static long getTtl() {
        return _ttl;
    }
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
