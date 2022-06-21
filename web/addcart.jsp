<%-- 
    Document   : addcar
    Created on : 2020年5月2日, 上午01:42:25
    Author     : tonyf
--%>
<jsp:useBean id="cart" class="AST20201.Cartdata" scope="session"/>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    if(session.getAttribute("username") == null){
        out.println("login please");
    }else{
        String seller_id = request.getParameter("seller_id");
        String product_id = request.getParameter("product_id");
        String number = request.getParameter("number");
        String price = request.getParameter("price");
        String local = request.getParameter("local");
        String seller_name = request.getParameter("seller_name");
        String product_name = request.getParameter("product_name");
        
        cart.setSellerId(seller_id);
        cart.setProductId(product_id);
        cart.setProductName(product_name);
        cart.setNumber(number);
        cart.setPrice(price);
        cart.setLocal(local);
        cart.setSellerName(seller_name);
        out.println("1");
%>


<%}%>