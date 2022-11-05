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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author dyhar
 */
public class BannerControllerServlet extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet BannerControllerServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet BannerControllerServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
        Model.BannerModel bm = null;
        System.out.println("here:" + getServletContext().getRealPath("/BannerPage/assets/CBannerInfo.txt"));
        try{
           bm = new Model.BannerModel(getServletContext().getRealPath("/BannerPage/assets/CBannerInfo.txt"));
        }
        catch(Model.IncompleteDataException | IOException ex){
            response.sendError(500, ex.toString());
        }
        request.setAttribute("4starchar1", bm.charInfo(2));
        request.setAttribute("4starchar2", bm.charInfo(3));
        request.setAttribute("4starchar3", bm.charInfo(4));
        RequestDispatcher dispatcher = request.getRequestDispatcher("BannerPage/banner.jsp");
        if(request.getParameter("banner")!= null){
                switch(request.getParameter("banner") ){
                case "b1":
                    request.setAttribute("5starchar", bm.charInfo(0));
                    dispatcher.forward(request,response);
                break;
                case "b2":
                    request.setAttribute("5starchar", bm.charInfo(1));
                    dispatcher.forward(request,response);
                break;
                default:
                    response.sendError(404, "No such page");
                
            }
        }
        else{
            response.sendError(404, "No such page");
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
