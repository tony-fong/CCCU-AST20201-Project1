
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        }catch(Exception e){
            out.println("create class fall:  " + e);
        }
        String url = "jdbc:mysql://localhost:3306/ast20201?user=root&password=root&useSSL=false&serverTimezone=UTC";
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try{
            conn = DriverManager.getConnection(
                  url
            );
            stmt = conn.createStatement();
        }catch(SQLException e){
            out.println("connection error: " + e);
        }
        //data
        String product_id = request.getParameter("product_id");
        //
        String sql = "DELETE FROM `product` WHERE product_id = ?";
        PreparedStatement prestate = conn.prepareStatement(sql);
        prestate.setString(1,product_id);
        int result = prestate.executeUpdate();
        if(result == 1){
            out.println("successful");
        }else{
            out.println(result);
             out.println("fail");
        }
%>
