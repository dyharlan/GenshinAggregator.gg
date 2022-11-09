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
        response.setContentType("text/html");
        Model.BannerModel bm = null;
        try{
           //bm = new Model.BannerModel(getServletContext().getRealPath("/assets/BannerPage/CBannerInfo.txt"));
           //ServletConfig #1
           bm = new Model.BannerModel(getServletContext().getRealPath(getServletConfig().getInitParameter("cbannerinfo-path")), getServletContext().getRealPath(getServletConfig().getInitParameter("wbannerinfo-path")));
        }
        catch(Model.IncompleteDataException | IOException ex){
            response.sendError(500, ex.toString());
        }
        
        
        if(request.getParameter("banner")!= null && !(request.getParameter("banner").equals("wb")) ){
            //ServletConfig #2
            RequestDispatcher dispatcher = request.getRequestDispatcher(getServletConfig().getInitParameter("cbannerpage-path"));
                request.setAttribute("4starchar1", bm.charInfo(2));
                request.setAttribute("4starchar2", bm.charInfo(3));
                request.setAttribute("4starchar3", bm.charInfo(4));
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
                    break;
            }
        }
        else if(request.getParameter("banner")!= null && request.getParameter("banner").equals("wb") ){
            //response.sendError(500, "Server under construction");
             request.setAttribute("5starwpn1", bm.wpnInfo(0));
             request.setAttribute("5starwpn2", bm.wpnInfo(1));
             request.setAttribute("4starwpn1", bm.wpnInfo(2));
             request.setAttribute("4starwpn2", bm.wpnInfo(3));
             request.setAttribute("4starwpn3", bm.wpnInfo(4));
             request.setAttribute("4starwpn4", bm.wpnInfo(5));
             request.setAttribute("4starwpn5", bm.wpnInfo(6));
             
             RequestDispatcher dispatcher = request.getRequestDispatcher(getServletConfig().getInitParameter("wbannerpage-path"));
             dispatcher.forward(request,response);
             
        }
        else{
            response.sendRedirect("/GenshinAggregator.gg");
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
