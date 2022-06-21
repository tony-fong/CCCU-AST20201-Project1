<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <%
            
        //get data
        if(session.getAttribute("role") == null || session.getAttribute("role").toString() == "buyer"){
            out.println("please login as a seller");
        }else{
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String price = request.getParameter("price");
        String info = request.getParameter("info");
        session.setAttribute("create_Product_name" , name);
        session.setAttribute("create_Product_type" , type);
        session.setAttribute("create_Product_price" , price);
        session.setAttribute("create_Product_info" , info);

            out.println("<script>window.location.replace('upImage.html')</script>");
        }
        %>
    </body>
</html>

