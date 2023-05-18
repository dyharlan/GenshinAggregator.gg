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
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nl.captcha.Captcha;

/**
 *
 * @author dyhar
 */
public class UserRegistrationControllerServlet extends HttpServlet {

    Connection conn;

    PreparedStatement ps1;
    PreparedStatement ps2;
    ResultSet rs;
    PreparedStatement ps3;

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
        HttpSession session = request.getSession();
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet UserRegistrationControllerServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet UserRegistrationControllerServlet at " + request.getContextPath() + "</h1>");
//            out.println(request.getParameter("email"));
//            out.println(request.getParameter("fname"));
//            out.println(request.getParameter("lname"));
//            Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));
//            String encPass = sec.encrypt(request.getParameter("password"));
//            out.println(encPass);
//            out.println(request.getParameter("birthday"));
//            out.println("</body>");
//            out.println("</html>");
//        }
        Captcha captcha = (Captcha) request.getSession().getAttribute(Captcha.NAME);
        //captcha check
        String answer = request.getParameter("answer");
        if (!captcha.isCorrect(answer)) {
            System.out.println(captcha.isCorrect(answer));
            request.getSession().setAttribute("captcha-failure", true);
            request.getRequestDispatcher("register.jsp").include(request, response);
            return;
        } //tell the session that the captcha check was successful.
        else {
            request.getSession().setAttribute("captcha-failure", false);
        }
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
	
            String query = "SELECT EMAIL FROM PersonCredentials";
            Statement statement = conn.createStatement();
            ResultSet emailSet = statement.executeQuery(query);
            while (emailSet.next()) {
                if (request.getParameter("email").equals(emailSet.getString("EMAIL"))) {
                    boolean userExistsFlag = true;
                    request.setAttribute("userExists", userExistsFlag);
                    session.setAttribute(Captcha.NAME, null);
                    request.getRequestDispatcher("register.jsp").include(request, response);
                    return;
                }
            }
			
            //set parameterized query
            String ps_query1 = "INSERT INTO PersonCredentials(EMAIL,PASSWORD) VALUES(?,?)";
            ps1 = conn.prepareStatement(ps_query1);
            ps1.setString(1, request.getParameter("email"));
            Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));
            ps1.setString(2, sec.encrypt(request.getParameter("password")));

            //disable autocommit for transaction mode
            conn.setAutoCommit(false);
            //execute parameterized query
			
            try {

                ps1.executeUpdate();

                String ps_query2 = "SELECT USERID FROM PersonCredentials WHERE EMAIL = ?";
                ps2 = conn.prepareStatement(ps_query2);
                ps2.setString(1, request.getParameter("email"));
                rs = ps2.executeQuery();
                int userid = -1;
                while (rs.next()) {
                    userid = rs.getInt("USERID");
                }
                if (userid == -1) {
                    throw new SQLException();
                } else {
                    String ps_query3 = "INSERT INTO PersonInfo (USERID, FNAME, LNAME, DOB) VALUES(?,?,?,?)";
                    ps3 = conn.prepareStatement(ps_query3);
                    ps3.setInt(1, userid);
                    ps3.setString(2, request.getParameter("fname"));
                    ps3.setString(3, request.getParameter("lname"));
                    ps3.setString(4, request.getParameter("birthday"));
                    ps3.executeUpdate();
                    conn.commit();
                }

            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            } finally {
                conn.setAutoCommit(true);
            }
            ps3.close();
            rs.close();
            ps2.close();
            ps1.close();
            conn.close();

            //clear persistent captcha
            session.setAttribute(Captcha.NAME, null);
            //set status flags accordingly
            session.setAttribute("sql-failure", false);
            session.setAttribute("sql-success", true);
			request.removeAttribute("userExists");
            response.sendRedirect("index.jsp");

        } catch (SQLException sqle) {
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
        response.sendRedirect(request.getContextPath() + "/Store/register.jsp");
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
