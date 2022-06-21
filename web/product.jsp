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
            //check login
            String username = null;
            if(session.getAttribute("username") == null){
                username = "guess";
            }else{
                username =session.getAttribute("username").toString();
            }
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
            //get data
            String type = request.getParameter("type");
            String search = "";
            String sql = "";
            String mange = null;
            //set sql
            if(request.getParameter("mange") != null){
              mange = request.getParameter("mange");
              String user_id = null;
              if(session.getAttribute("role").toString().equals("admin")){
                  sql = "select * from product";
                  PreparedStatement pre = conn.prepareStatement(sql);
                   rs = pre.executeQuery();
              }else if(session.getAttribute("user_id") != null){ 
                  user_id = session.getAttribute("user_id").toString();
                   sql = "SELECT * FROM `product` WHERE `user_id` = ?";
                   PreparedStatement pre = conn.prepareStatement(sql);
                   pre.setString(1, user_id);
                   rs = pre.executeQuery();
              }
              

              if(rs.next() == false){
                  out.println("no result");
                  out.println("go to upload some product!");
              }else{
                  rs.first();
              }
              rs.beforeFirst();
              while(rs.next()){
                  out.println("<div class='product' id='" + rs.getInt("product_id") + "'>");
                  out.println("<a id='productId'>" + rs.getInt("product_id") + "</a>");
                  String location = rs.getString("img");
                  out.println("<img src=" + location + " width='130' hight='200'>");
                  out.println("<a class='contact' id='productType'>"+rs.getString("type")+"</a>");
                  out.println("<a class='contact' id='productName'>"+rs.getString("product_name")+"</a>");
                  out.println("<a class='contact' id='productPrice'>" + rs.getDouble("price") + "</a>");
                  out.println("<a class='contact' id='info'>" + rs.getString("info") + "</a>");
                  out.println("<input type='button' class='submit' id=" + rs.getInt("product_id") + " value='change' style='display: none;'>");
                  out.println("<input type='button' class='delete' id='" +  rs.getInt("product_id") + "' value='delete' >");
                  out.println("</div>");
                  out.println("<hr/>");
              }
            }else{
                if(request.getParameter("search") != null){
                    search = request.getParameter("search");
                    //out.println("search = " + search + "<br>");
                }

                if( search != "" && search != null && search.length() != 0){
                    if(type.equals("all")){
                            sql = "Select * From product where Product_name like '%" + search + "%'";
                    }else{
                            sql = "Select * From product where type = '" + type + "' AND Product_name like '%" + search + "%'"; 
                    }
                }else if(type.equals("all")){
                        sql = "Select * From product";
                }else{
                        sql = "Select * From product where type = '" + type + "'"; 
                }


                //sql execute
                rs = stmt.executeQuery(sql);

                if(rs.next() == false){
                    out.println("no result");
                }else{
                    rs.first();
                }
                rs.beforeFirst();
                while(rs.next()){
                    out.println("<div class='product' id='" + rs.getInt("product_id") + "'>");
                    String location = rs.getString("img");
                    out.println("<img src=" + location + " width='130' hight='200'>");
                    out.println(rs.getString("product_name"));
                    out.println(rs.getDouble("price"));
                    Statement stm = conn.createStatement();
                    ResultSet owner = stm.executeQuery("Select username From user Where user_id ='" + rs.getInt("user_id") + "'");
                    if(owner.next()){
                            out.println(owner.getString("username"));
                    }
                    out.println("</div>");
                    out.println("<hr/>");
                }
            
	%>
    </body>

</html>
<%}%>