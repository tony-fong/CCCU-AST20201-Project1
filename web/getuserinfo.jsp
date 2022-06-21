<%-- 
    Document   : getinfo
    Created on : 2020年5月1日, 下午09:59:32
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
        ResultSetMetaData meta = null;
 
        try{
            conn = DriverManager.getConnection(
                  url
            );
            stmt = conn.createStatement();
        }catch(SQLException e){
            out.println("connection error: " + e);
        }
        //get data
        String id = session.getAttribute("user_id").toString();
        //sql
        String sql = "Select role, username, user_id From user Where user_id = '" + id + "'";
        rs = stmt.executeQuery(sql);
        if(rs.next()){
            out.println("<a> user role: "+ rs.getString("role") + "</a><br/>");
            out.println("<a> username: "+ rs.getString("username") + "</a><br/>");
            out.println("<a> your id: "+ rs.getString("user_id") + "</a><br/>");
            out.println("<button id='changepw'> chage password </button>");
            out.println("<button id='checkRecord'>check Record </button>");
            if(rs.getString("role").equals("seller") || rs.getString("role").equals("admin")){
                out.println("<a href='productMange.html'>product mangement</a>");
            }
        }
    }
%>
