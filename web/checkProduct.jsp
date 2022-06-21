
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%
    if(session.getAttribute("username") == null && session.getAttribute("role").toString() == "buyer"){
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
        String user_id = session.getAttribute("user_id").toString();
        String sql  = "Select * from product where user_id = ?";
        PreparedStatement prestatm = conn.prepareStatement(sql);
        prestatm.setString(1,user_id);
        rs = prestatm.executeQuery();
        while(rs.next()){
            //print out and done :D
            out.println(rs.getInt("product_id"));
        }
    }
 %>
