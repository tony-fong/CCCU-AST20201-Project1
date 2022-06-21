<jsp:useBean id="obj" class ="AST20201.userhash" />
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
        try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
        }catch(Exception e){
            out.println("create class fall:  " + e);
        }
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSetMetaData meta = null;

        try{
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/ast20201?user=root&password=root&useSSL=false&serverTimezone=UTC"
            );
            stmt = conn.createStatement();
        }catch(SQLException e){
            out.println("connection error: " + e);
        }
        
        //get data
        String name = request.getParameter("username");
        String password = request.getParameter("pw");
        String role = request.getParameter("role");
        int id =  obj.idHash(name);
        //sql
        String checksql = "select count(username) as 'row' from user where username = ?";
        PreparedStatement precheck = conn.prepareStatement(checksql);
        precheck.setString(1, name);
        rs = precheck.executeQuery();
        out.println(name + "<br>");
        rs.next();
        if(rs.getInt("row") == 1){
            out.println("error! The username had been use");
            
        }else{
            rs = null;
            String sql = "INSERT INTO `user`(`username`, `password`, `user_id`, `role`) VALUES ('" + name + "', '" + password + "', " + id + ", '" + role +"')";
            int result = stmt.executeUpdate(sql);
            out.println(result);
            if(result == 1){
                out.println("<script>parent.location.reload();</script>");
            }
        }
        %>
    </body>
</html>
