
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("username") == null){
        out.println("login please");
    }else{
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

        String product_id;
        String new_product_name = "" ;
        String new_product_price = "";
        String new_product_info = "";
        String new_product_type= "";

        if(request.getParameter("product_id") == null){
        }else{
            product_id = request.getParameter("product_id");
            if(request.getParameter("product_name") != null){
                new_product_name = request.getParameter("product_name");
            }
            if(request.getParameter("product_price") != null){
                new_product_price = request.getParameter("product_price");
            }
            if(request.getParameter("product_info") != null){
                new_product_info = request.getParameter("product_info");
            }
            if(request.getParameter("product_type") != null){
                new_product_type = request.getParameter("product_type");
            }
            rs = stmt.executeQuery("select type, product_name, price, info from product where product_id='" + product_id + "'");
            String old_name =""; 
            String old_price=""; 
            String old_info="";
            String old_type="";
            if(rs.next()){
                old_name = rs.getString("product_name");
                old_price = rs.getString("price");
                old_info = rs.getString("info");
                old_type = rs.getString("type");
            }


            String sql = "UPDATE product SET product_name = if(?='',?,?), price = if(?='',?,?), info = if(?='',?,?), type= if(? = 'none',?,?)  Where product_id = ?";
            PreparedStatement prestmt = conn.prepareStatement(sql);
            prestmt.setString(1,new_product_name);
            prestmt.setString(2,old_name);
            prestmt.setString(3,new_product_name);
            
            prestmt.setString(4,new_product_price);
            prestmt.setString(5,old_price);
            prestmt.setString(6,new_product_price);
            
            prestmt.setString(7,new_product_info);
            prestmt.setString(8,old_info);
            prestmt.setString(9,new_product_info);
            
            prestmt.setString(10,new_product_type);
            prestmt.setString(11,old_type);
            prestmt.setString(12,new_product_type);
            prestmt.setString(13,product_id);
            
            int result = prestmt.executeUpdate();
            if(result == 1){
                out.println("successful");
            }
        }

    }
%>
