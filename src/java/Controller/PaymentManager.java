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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.captcha.Captcha;

/**
 *
 * @author dyhar
 */

public class PaymentManager extends HttpServlet {
    private static final String NONE = "none"; 
    Connection conn;
    ResultSet rs;
    PreparedStatement ps1;
   
    
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
        response.setContentType("text/html;charset=UTF-8");
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
            
            String query = "SELECT PMIDENTIFIER FROM USERPAYMENTMETHODS";
            Statement statement = conn.createStatement();
            rs = statement.executeQuery(query);
            String matchedPM = this.NONE;
            while (rs.next()) {
                matchedPM = rs.getString("PMIDENTIFIER").trim();
            }
            if(matchedPM.equals(this.NONE)){
                response.sendRedirect(request.getContextPath() + "/Store/profile.jsp");
                return;
            }
            
            //set parameterized query
            String ps_query1 = "DELETE FROM USERPAYMENTMETHODS WHERE PMIDENTIFIER = ?";
            ps1 = conn.prepareStatement(ps_query1);
            Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));
            ps1.setString(1, sec.decrypt(request.getParameter("pmIdentifier")));

            //disable autocommit for transaction mode
            conn.setAutoCommit(false);
            //execute parameterized query
			
            try {
                ps1.executeUpdate();                   
                conn.commit();
            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            } finally {
                conn.setAutoCommit(true);
            }            
            ps1.close();
            rs.close();
            conn.close();            
            response.sendRedirect(request.getContextPath() + "/Store/profile.jsp");

        } catch (SQLException sqle) {
             System.out.println("tubol " + sqle);
            response.sendError(500, "An unexpected error has occured!: " + sqle.toString());
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
        //processRequest(request, response);
       response.sendRedirect(request.getContextPath() + "/Store/profile.jsp");

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
