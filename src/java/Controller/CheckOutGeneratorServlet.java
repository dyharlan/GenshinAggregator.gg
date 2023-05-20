/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.captcha.Captcha;
import java.util.UUID;
import java.sql.Date;
import javax.servlet.http.Cookie;
import java.time.*;


/**
 *
 * @author dyhar
 */
public class CheckOutGeneratorServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    Connection conn;

    PreparedStatement ps1;
    PreparedStatement psCheck;
    PreparedStatement ps2;
    ResultSet rs;
    PreparedStatement ps3;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
        String answer = request.getParameter("answer");
        Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));
        String paymentMethod = sec.decrypt(request.getParameter("paymentMethod"));
        String recipient = request.getParameter("recipient");
        String itemid = request.getParameter("itemid");
        if (!captcha.isCorrect(answer)) {
            System.out.println(captcha.isCorrect(answer));
            session.setAttribute("captcha-failure", true);
            response.setContentType("text/html;charset=UTF-8");
            request.getRequestDispatcher("/Store/order-summary.jsp?select=" + itemid +"&uid="+recipient).include(request, response);
            System.out.println("/Store/order-summary.jsp?select=" + itemid +"&uid="+recipient);
            return;
        } //tell the session that the captcha check was successful.
        else {
            session.setAttribute("captcha-failure", false);
        }
        UUID uuid = UUID.randomUUID();
        String transactionID = uuid.toString();
        
        
        try {
            /*
             *  AYOKO NA NG DERBY DI KO SANA GAGAWIN ITO KUNG MADALI LANG GUMAWA NG STORED PROCEDURES
             * -dyharlan, 2021147927
             */
            Class.forName(getServletContext().getInitParameter("className"));
            //System.out.println("jdbcClassName: " + config.getInitParameter("jdbcClassName"));
            String username = getServletContext().getInitParameter("dbUsername");
            String password = getServletContext().getInitParameter("dbPassword");
            StringBuffer url = new StringBuffer(getServletContext().getInitParameter("driverURL"))
                    .append("://")
                    .append(getServletContext().getInitParameter("dbHostName"))
                    .append(":")
                    .append(getServletContext().getInitParameter("dbPort"))
                    .append("/")
                    .append(getServletContext().getInitParameter("dbName"));
            System.out.println(password);
            conn = DriverManager.getConnection(url.toString(), username, password);
            //check if cookies are valid
            String email = "";
            int userID = -1;
            Cookie[] cookies = request.getCookies();
            if (cookies != null)
                for (Cookie cookie : cookies) {
                   if(cookie.getName().equals("let-him-cook1"))
                      userID = Integer.parseInt(cookie.getValue());
                   if(cookie.getName().equals("let-him-cook2"))
                      email = cookie.getValue(); 
                }
            else{
                response.sendRedirect(request.getContextPath() + "index.jsp");
                return;
            }
            //check for valid email,pmidentifier, and userid
            String query = "SELECT PersonCredentials.USERID, PersonCredentials.email,UserPaymentMethods.PMIdentifier,UserPaymentMethods.PaymentType from PersonCredentials Join UserPaymentMethods using(USERID) where PersonCredentials.USERID = ? and email = ? and PMIdentifier = ?";
            psCheck = conn.prepareStatement(query);
            psCheck.setInt(1, userID);
            psCheck.setString(2, email);
            psCheck.setString(3, paymentMethod);
            

            int paymentType = -1;    
            ResultSet userSet = psCheck.executeQuery();
            while(userSet.next()){
                System.out.println(userSet.getInt("PaymentType"));
                paymentType = userSet.getInt("PaymentType");
            }
            if (paymentType == -1) { 
                    //invalidate cookies if the client enters an invalid user and/or payment method
                    if (cookies != null)
                        for (Cookie cookie : cookies) {
                            cookie.setMaxAge(0);
                            cookie.setValue("");
                            response.addCookie(cookie);
                        }
                    request.getSession().setAttribute("paymentInfo", null);
                    session.invalidate();
                    response.sendRedirect("index.jsp");
                    return;   
            }
            
            String upd1 = "INSERT INTO USERTRANSACTIONS VALUES (?,?,?,?,?)";
            
            ps1 = conn.prepareStatement(upd1);
            ps1.setInt(1, userID);
            ps1.setString(2, transactionID);
            ps1.setInt(3, paymentType);
            ps1.setString(4, paymentMethod);
            ps1.setDate(5, Date.valueOf(LocalDate.now()));
            //disable autocommit for transaction mode
            conn.setAutoCommit(false);
            //execute parameterized query
			
            try {
                ps1.executeUpdate();
                String upd2 = "INSERT INTO TRANSACTIONINFO VALUES(?,?,?)";
                ps2 = conn.prepareStatement(upd2);
                ps2.setString(1, transactionID);
                ps2.setString(2, itemid);
                ps2.setString(3, recipient);
                ps2.executeUpdate();
                conn.commit();   
            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            } finally {
                conn.setAutoCommit(true);
            }
            //ps3.close();
            //rs.close();
            //ps2.close();
            ps1.close();
            conn.close();

            //clear persistent captcha
            session.setAttribute(Captcha.NAME, null);
            //set status flags accordingly
            session.setAttribute("sql-failure", false);
            session.setAttribute("sql-success", true);
            session.setAttribute("transactionID", transactionID);
            response.sendRedirect(request.getContextPath() + "/Store/receipt.jsp");

        } catch (SQLException sqle) {
            response.sendError(500, "An unexpected error has occured!: " + sqle.toString());
            System.out.println(sqle.toString());
        } catch (ClassNotFoundException nfe) {
            response.sendError(500, "An unexpected error has occured!: " + nfe.toString());
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
