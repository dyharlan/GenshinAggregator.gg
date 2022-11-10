/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.PriceModel;
/**
 *
 * @author dyhar
 */
public class PaymentProcessorServlet extends HttpServlet {

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
        RequestDispatcher dispatcher = request.getRequestDispatcher("form.jsp");
        PriceModel pm = new PriceModel((String)request.getParameter("select"),(String)request.getParameter("payment"));
        Float totalAmount = pm.getItemPrice();
        String creditCard = pm.getCcType();
        String itemName = pm.getItemName();
        HttpSession session = request.getSession();
        session.setAttribute("totalAmount", totalAmount);
        session.setAttribute("creditCard", creditCard);
        session.setAttribute("item",itemName);
        session.setAttribute("uid", request.getParameter("uid"));
        session.setAttribute("server", request.getParameter("server"));
        dispatcher.forward(request, response);
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
        response.sendError(418);
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
        response.setContentType("text/html;charset=UTF-8");  
        
        if(!(request.getParameter("uid").startsWith("6")) && request.getParameter("server").equals("na") ){
            request.setAttribute("uidstatus", "Invalid UID! NA Server UIDs start with 6");
            RequestDispatcher rd = request.getRequestDispatcher("/Store/index.jsp");  
            rd.include(request, response);  
        }
        else if(!(request.getParameter("uid").startsWith("7")) && request.getParameter("server").equals("eu") ){
            request.setAttribute("uidstatus", "Invalid UID! EU Server UIDs start with 7");
            RequestDispatcher rd = request.getRequestDispatcher("/Store/index.jsp");  
            rd.include(request, response);  
        }
        else if(!(request.getParameter("uid").startsWith("8")) && request.getParameter("server").equals("asia") ){
            request.setAttribute("uidstatus", "Invalid UID! Asia Server UIDs start with 8");
            RequestDispatcher rd = request.getRequestDispatcher("/Store/index.jsp");  
            rd.include(request, response);  
        }
        else if(!(request.getParameter("uid").startsWith("9")) && request.getParameter("server").equals("sar") ){
            request.setAttribute("uidstatus", "Invalid UID! TW/HK SAR Server UIDs start with 9");
            RequestDispatcher rd = request.getRequestDispatcher("/Store/index.jsp");  
            rd.include(request, response);  
        }
        else
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
