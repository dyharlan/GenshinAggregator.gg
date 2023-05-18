/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.LinkedHashMap;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author csean
 */
public class LoginServlet extends HttpServlet {

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
        //Map<String,String> result = (LinkedHashMap) session.getAttribute("result");
        boolean credentialsFound = false;
            try 
            {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String query = "SELECT USERID,EMAIL,PASSWORD FROM PersonCredentials WHERE EMAIL = ? AND PASSWORD = ?";
                ResultSet credentials = runQuery(request, query, email, password); //used to determine if the login input matches credentials in database
                Security sec = new Security(getServletContext().getInitParameter("key"), getServletContext().getInitParameter("initVector"));
                while (credentials.next()) 
                { //if successful match is found, forwards to records.jsp
                    if (credentials.getString("EMAIL").trim().equals(email) && sec.decrypt(credentials.getString("PASSWORD").trim()).equals(password))
                    {
                        credentialsFound = true;
                        Cookie cookie = new Cookie("let him cook",credentials.getString("USERID"));
                        response.addCookie(cookie);
                        credentials.close();
                        response.sendRedirect("index.jsp");
                        break;
                    }
                }
                //if the while loop ends and there are no successful matches, redirects to error page
                if (credentialsFound != true)
                {
                    if (session.getAttribute("errorCount") == null)
                        session.setAttribute("errorCount",1);
                    else
                        session.setAttribute("errorCount", ((Integer) session.getAttribute("errorCount")).intValue() + 1);
                    response.sendRedirect("error.jsp");
                }
            }
            catch (SQLException sqle)
            {
                System.err.println(sqle.getCause());
                response.sendRedirect("sqlexception.jsp");
            }
        }
        
        public ResultSet runQuery(HttpServletRequest request, String query) throws SQLException {
            ServletContext context = request.getServletContext();
            
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            //Map<String,String> map = null;
            try {
                Class.forName(context.getInitParameter("className"));
                String username = context.getInitParameter("dbUsername");
                String password = context.getInitParameter("dbPassword");
                StringBuffer url = new StringBuffer(context.getInitParameter("driverURL"))
                        .append("://")
                        .append(context.getInitParameter("dbHostName"))
                        .append(":")
                        .append(context.getInitParameter("dbPort"))
                        .append("/")
                        .append(context.getInitParameter("dbName"));
                        //.append(config.getInitParameter("sqlSSL"));
                conn = DriverManager.getConnection(url.toString(), username, password);
                ps = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_SENSITIVE);
                rs = ps.executeQuery(); //support for non-query functions
            }
            catch(SQLException sqle)
            {
                System.err.println("SQLException occured - " + sqle.getMessage());
            }
            catch(ClassNotFoundException cnfe)
            {
                System.err.println("ClassNotFoundException occured - " + cnfe.getMessage());
            }
            finally {
                if (ps != null)
                    ps.close();
                if (conn != null)
                    conn.close();
            }
            return rs;
        }

		public ResultSet runQuery(HttpServletRequest request, String query, Object... params) throws SQLException {
            ServletContext context = request.getServletContext();
            
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            //Map<String,String> map = null;
            try {
                Class.forName(context.getInitParameter("className"));
                String username = context.getInitParameter("dbUsername");
                String password = context.getInitParameter("dbPassword");
                StringBuffer url = new StringBuffer(context.getInitParameter("driverURL"))
                        .append("://")
                        .append(context.getInitParameter("dbHostName"))
                        .append(":")
                        .append(context.getInitParameter("dbPort"))
                        .append("/")
                        .append(context.getInitParameter("dbName"));
                        //.append(config.getInitParameter("sqlSSL"));
                conn = DriverManager.getConnection(url.toString(), username, password);
                ps = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_SENSITIVE);
				int ctr = 1;
				for (Object object : params)
				{
					if (object instanceof String)
					{
						ps.setString(ctr, (String) object);
					}
					else if (object instanceof Integer)
					{
						ps.setInt(ctr, (Integer) object);
					}
					ctr++;
				}
                rs = ps.executeQuery(); //support for non-query functions
            }
            catch(SQLException sqle)
            {
                System.err.println("SQLException occured - " + sqle.getMessage());
            }
            catch(ClassNotFoundException cnfe)
            {
                System.err.println("ClassNotFoundException occured - " + cnfe.getMessage());
            }
            finally {
                if (ps != null)
                    ps.close();
                if (conn != null)
                    conn.close();
            }
            return rs;
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
/*
TODO: (MP3)
Implement adding records:
1. Check if the email is already in the result set (if it is, send the user back to the add record page saying that there is already that email) [NOTE: STEP NOT NEEDED]
2. Check if the password is the same with the confirm password (if it isn't, send the user back saying that the passwords don't match)
3. Then, encrypt the password
4. INSERT INTO USERS (EMAIL, PASSWORD, USERROLE) VALUES (?,?,?) - SQL PreparedStatement query where the question marks align with the parameters next to USERS (password should be encrypted)
5. After successfully inserting the record, remove the current result set and create a new one immediately
6. Send the user back to the Records Page
*/

/*
TODO: (MP4)
*/

/*
TODO: (Post-MP4)
1. Build this program again from the ground up (properly close ResultSet and Statement)
*/