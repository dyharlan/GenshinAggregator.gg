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
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author dyhar
 */
public class GCashServlet extends HttpServlet {
    Connection conn;
    PreparedStatement psCheck;
    ResultSet gcashNumSet;
    PreparedStatement ps1;
    PreparedStatement ps2;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
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
            Cookie[] cookies = request.getCookies();
            int userID = -1;
            if (cookies != null)
                for (Cookie cookie : cookies) {
                   if(cookie.getName().equals("let-him-cook1"))
                      userID = Integer.parseInt(cookie.getValue());
                }
            else{
                response.sendRedirect(request.getContextPath() + "index.jsp");
                return;
            }
            String query = "SELECT UserPaymentMethods.UserID,UserPaymentMethods.PMIdentifier,GCASHINFO.GCASHNumber FROM GCashINFO JOIN UserPaymentMethods USING(PMIDENTIFIER) WHERE UserPaymentMethods.UserID = ? AND GCASHNumber = ?";
            psCheck = conn.prepareStatement(query);
            psCheck.setInt(1, userID);
            Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));
            String encryptedGCashNum = sec.encrypt(request.getParameter("gcash-number"));
            System.out.println(encryptedGCashNum);
            psCheck.setString(2, encryptedGCashNum);
           
            gcashNumSet = psCheck.executeQuery();
            while (gcashNumSet.next()) {
                System.out.println("true?");
                
                if ( gcashNumSet.getInt("UserID") == userID && gcashNumSet.getString("GCASHNUMBER").trim().equals(encryptedGCashNum) ) {
                    Boolean gcashExistsFlag = true;
                    request.setAttribute("gcashExists", gcashExistsFlag);
                    request.getRequestDispatcher("gcash-add.jsp").include(request, response);
                    return;
                }
            }
            UUID uuid = UUID.randomUUID();
            String PMIdentifier = uuid.toString();
           
            
            //set parameterized query
            String ps_query1 = "INSERT INTO UserPaymentMethods VALUES(?,?,?)";
            ps1 = conn.prepareStatement(ps_query1);
            ps1.setInt(1, userID);
            ps1.setString(2, PMIdentifier);
            ps1.setInt(3, 2);
            
            //disable autocommit for transaction mode
            conn.setAutoCommit(false);
            //execute parameterized query

            try {
                ps1.executeUpdate();
                String ps_query2 = "INSERT INTO GCASHInfo VALUES(?,?)";
                ps2 = conn.prepareStatement(ps_query2);
                ps2.setString(1, PMIdentifier);
                ps2.setString(2, encryptedGCashNum);
                ps2.executeUpdate();
                conn.commit();
            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            } finally {
                conn.setAutoCommit(true);
            }

            ps2.close();
            ps1.close();
            gcashNumSet.close();
            psCheck.close();
            conn.close();

           
            //set status flags accordingly
            session.setAttribute("sql-failure", false);
            session.setAttribute("sql-success", true);
            request.setAttribute("gcashExists", false);
            session.setAttribute("gcash-success", true); //before the redirect
            response.sendRedirect("profile.jsp");

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
