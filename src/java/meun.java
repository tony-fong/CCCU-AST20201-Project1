/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


/**
 *
 * @author tonyf
 */
@WebServlet(urlPatterns = {"/meun"})
public class meun extends HttpServlet {

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
        String role;
        
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        role = "guess";
        if(session.getAttribute("role") == null){
            role = "guess";
        }else{
            role = session.getAttribute("role").toString();
        }
        
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            //head
            out.println("<head>");
            out.println("<link rel='stylesheet' type='text/css' href='style.css'>");
            out.println("</head>");
            //body
            out.println("<body>");
            if(role.equals("admin")){
                
                out.println("<div id='meunfunction'>");
                  out.println("<a href='product.html' target='main'> product</a>");
                  out.println("<a href='shoppingcar.jsp' target='main'>shopping car </a>");
                out.println("</div>");
                out.println(" <div id='userfunction'>");
                    out.println("<a href='register.html' target='main'> register</a>");
                    out.println("<a href='login.html' target='main'> login</a>");
                    out.println("<a href='userhomepage.html' target='main'>userhomepage</a>");
                    out.println("<a href='upload.html' target='main'> upload</a>");
                    out.println("<a href='shoppingcar.jsp' target='main'>shopping car </a>");
                    out.println("<form id='logout' action='logout.jsp' method='post'><input type='submit' value='logout'></from>");
                out.println("</div>");
                out.println("<div id='icon'>");
                    out.println("<img src='img/BBshop.jpg' width='130' hight='150'>");
                out.println("</div>");
            }else if(role.equals("buyer")){
                
                out.println("<div id='meunfunction'>");
                  out.println("<a href='product.html' target='main'> product</a>");
                out.println("</div>");
                out.println(" <div id='userfunction'>");
                    out.println("<a href='userhomepage.html' target='main'>userhomepage</a>");
                    out.println("<a href='shoppingcar.jsp' target='main'>shopping car </a>");
                    out.println("<form id='logout' action='logout.jsp' method='post'><input type='submit' value='logout'></from>");
                out.println("</div>");      
                out.println("<div id='icon'>");
                    out.println("<img src='img/BBshop.jpg' width='130' hight='150'>");
                out.println("</div>");                
            }else if(role.equals("seller")){
                
                out.println("<div id='meunfunction'>");
                  out.println("<a href='product.html' target='main'> product</a>");
                out.println("</div>");
                out.println(" <div id='userfunction'>");
                    out.println("<a href='userhomepage.html' target='main'>userhomepage</a>");
                    out.println("<a href='upload.html' target='main'> upload</a>");
                    out.println("<form id='logout' action='logout.jsp' method='post'><input type='submit' value='logout'></from>");
                out.println("</div>");     
                out.println("<div id='icon'>");
                    out.println("<img src='img/BBshop.jpg' width='130' hight='150'>");
                out.println("</div>");               
            }else if(role.equals("guess")){
                out.println("<div id='meunfunction'>");
                  out.println("<a href='product.html' target='main'> product</a>");
                out.println("</div>");

                out.println(" <div id='userfunction'>");
                    out.println("<a href='register.html' target='main'> register</a>");
                    out.println("<a href='login.html' target='main'> login</a>");
                out.println("</div>");
                out.println("<div id='icon'>");
                    out.println("<img src='img/BBshop.jpg' width='130' hight='150'>");
                out.println("</div>");
            }
            
            out.println("</body>");
            out.println("</html>");
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
