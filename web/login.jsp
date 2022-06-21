<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
</head>
<body>
    <%  String user = request.getParameter("username");
        String pw = request.getParameter("password");
        //username = "username";
        //password = "password";
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
        //SQL execute
        String SQL = "Select count(*) as 'row' ,username, user_id, role From user Where username = '" + user + "' AND password = '" + pw + "'";
        //out.println(SQL);
        rs = stmt.executeQuery(SQL);
        rs.first();
        int rowcount = rs.getInt("row");
        if(rowcount == 1){
           Statement tempstmt = null;
           tempstmt = conn.createStatement();
           session.setAttribute("role", rs.getString("role"));
           session.setAttribute("username", rs.getString("username"));
           session.setAttribute("user_id", rs.getInt("user_id"));
           tempstmt.executeUpdate("UPDATE user SET lastlogin = TIMESTAMP(NOW()) WHERE user_id = '" + rs.getInt("user_id") + "'");
           out.println("<script>alert('login successful')</script>");
           out.println("<script>parent.location.reload();</script>");
        }else{
           out.println("<a> login fail! incorrect username or password</a>");
        }
    %>


</body>
</html>
