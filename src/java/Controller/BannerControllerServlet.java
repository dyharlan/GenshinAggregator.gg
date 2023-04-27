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

/**
 *
 * @author dyhar
 */

//load assets and information for the banner pages
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
        
        Model.BannerModel genshin_bm = null;
        Model.BannerModel hsr_bm = null;
        try{
           //ServletConfig #1
           hsr_bm = new Model.BannerModel(getServletContext().getRealPath(getServletConfig().getInitParameter("hsr-cbannerinfo-path")), 4);
           genshin_bm = new Model.BannerModel(getServletContext().getRealPath(getServletConfig().getInitParameter("cbannerinfo-path")), getServletContext().getRealPath(getServletConfig().getInitParameter("wbannerinfo-path")), 5);
        }
        catch(Model.IncompleteDataException | IOException ex){
            response.sendError(500, ex.toString());
            System.out.println("The problem: " + ex);
        }
        
        
        if(request.getParameter("banner")!= null && (request.getParameter("banner").equals("b1") || request.getParameter("banner").equals("b2")) ){
            //ServletConfig #2
            RequestDispatcher dispatcher = request.getRequestDispatcher(getServletConfig().getInitParameter("cbannerpage-path"));
                request.setAttribute("4starchar1", genshin_bm.charInfo(2));
                request.setAttribute("4starchar2", genshin_bm.charInfo(3));
                request.setAttribute("4starchar3", genshin_bm.charInfo(4));
                switch(request.getParameter("banner") ){
                case "b1":
                    request.setAttribute("5starchar", genshin_bm.charInfo(0));
                    dispatcher.forward(request,response);
                break;
                case "b2":
                    request.setAttribute("5starchar", genshin_bm.charInfo(1));
                    dispatcher.forward(request,response);
                break;
                default:
                    response.sendError(404, "No such page");    
                    break;
            }
        }
        else if(request.getParameter("banner")!= null && request.getParameter("banner").equals("wb") ){
            //response.sendError(500, "Server under construction");
             request.setAttribute("5starwpn1", genshin_bm.wpnInfo(0));
             request.setAttribute("5starwpn2", genshin_bm.wpnInfo(1));
             request.setAttribute("4starwpn1", genshin_bm.wpnInfo(2));
             request.setAttribute("4starwpn2", genshin_bm.wpnInfo(3));
             request.setAttribute("4starwpn3", genshin_bm.wpnInfo(4));
             request.setAttribute("4starwpn4", genshin_bm.wpnInfo(5));
             request.setAttribute("4starwpn5", genshin_bm.wpnInfo(6));
             
             RequestDispatcher dispatcher = request.getRequestDispatcher(getServletConfig().getInitParameter("wbannerpage-path"));
             dispatcher.forward(request,response);
             
        }
        else if(request.getParameter("banner")!= null && request.getParameter("banner").equals("b1-hsr") ){
            //HttpSession session = request.getSession();
            request.setAttribute("5starchar", hsr_bm.charInfo(0));
            request.setAttribute("4starchar1", hsr_bm.charInfo(1));
            request.setAttribute("4starchar2", hsr_bm.charInfo(2));
            request.setAttribute("4starchar3", hsr_bm.charInfo(3));
             
            RequestDispatcher dispatcher = request.getRequestDispatcher(getServletConfig().getInitParameter("hsr-cbannerpage-path"));
            dispatcher.forward(request,response);
            //response.sendRedirect("BannerPage/banner-hsr.jsp");
             
        }
        else if(request.getParameter("goto")!= null && request.getParameter("goto").equals("store") ){
            //relative redirect
            response.sendRedirect("Store");
        }
        else{
            //absolute redirect
            response.sendRedirect(request.getContextPath());
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
        //processRequest(request, response);
        response.sendError(418);
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
