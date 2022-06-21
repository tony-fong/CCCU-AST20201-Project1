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
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;


        try{
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/ast20201?user=root&password=root&useSSL=false&serverTimezone=UTC"
            );
            stmt = conn.createStatement();
        }catch(SQLException e){
                out.println("connection error: " + e);
        }
        //data
        String user_id = session.getAttribute("user_id").toString();
        String product_id = request.getParameter("product_id");
        String comment = request.getParameter("comment");
        //sql
        String sql = "INSERT INTO comment(user_id, product_id, comment) VALUES (?,?,?)";
        PreparedStatement prestate = conn.prepareStatement(sql);
        prestate.setString(1,user_id);
        prestate.setString(2, product_id);
        prestate.setString(3,comment);
        int result = prestate.executeUpdate();
        if(result == 1){
            out.println("successful");
        }
  }
%>
