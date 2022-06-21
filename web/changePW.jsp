<%-- 
    Document   : changePW
    Created on : 2020年5月6日, 上午12:20:27
    Author     : tonyf
--%>


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
        String user_id = session.getAttribute("user_id").toString();
        String username = session.getAttribute("username").toString();
        String oldpw = request.getParameter("oldpw");
        String newpw = request.getParameter("newpw");
        //sql
        String sql = "SELECT count(*) as 'row', user_id FROM user WHERE user_id=? AND password = ?"; 
        PreparedStatement prestate = conn.prepareStatement(sql);
        prestate.setString(1, user_id);
        prestate.setString(2, oldpw);
        rs = prestate.executeQuery();
        rs.first();
        int rowcount = rs.getInt("row");
        if(rowcount == 1){
            String changeSql = "UPDATE user SET password= ? where user_id = ?";
            PreparedStatement state = conn.prepareStatement(changeSql);
            state.setString(1, newpw);
            state.setString(2, user_id);
            int result = state.executeUpdate();
            if(result == 1){
                out.println("update succeessful");
            }
        }else{
            out.println("old password not match");
        }
    }
%>
