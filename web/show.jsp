<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
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
        //set data
        String id = request.getParameter("id");
        String product_name = null;
        String product_type = null;
        String product_Info = null;
        String local = null;
        String seller_name = null;
        int seller_id = 0;
        int price = 0;
        int product_id = 0; 
        
        //sql
        String SQL = "select * From product Where product_id = " + id + "";
        rs = stmt.executeQuery(SQL);
        if(rs.next()){
            product_name = rs.getString("product_name");
            product_type = rs.getString("type");
            product_Info = rs.getString("info");
            local = rs.getString("img");
            seller_id = rs.getInt("user_id");
            price = rs.getInt("price");
            product_id = rs.getInt("product_id");        
        }
        stmt = null;
        rs = null;
        stmt = conn.createStatement();
        rs = stmt.executeQuery("Select username From user where user_id ='" + seller_id + "'"); 
        if(rs.next()){
            seller_name = rs.getString("username");
        }
        String getcomment="select (select username from user where user_id = comment.user_id) as username, comment, Date from comment where product_id = ?";
        PreparedStatement prestate = conn.prepareStatement(getcomment);
        prestate.setInt(1,product_id);
        ResultSet comment =  prestate.executeQuery();
%>
<html>
    <head>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <style media="screen">
            @media only screen and (min-width:1200px){
                .showproduct{
                    height:400px;
                }
                #image{
                    display:inline-block;
                    float:left;
                    position: fixed;
                }
                #text{
                    display:inline-block;
                    float:right;
                    right:300px;
                    position: sticky;
                }
                #commentdiv{
                    float:left;
                    position: sticky;
                }
            }
        </style>   
            
    </head>
    <body>
        <div class="showproduct">
        <p><image id="image" src="<%=local%>"></p>
            <div id="text">
            <p>product name <%=product_name%></p>
            <p>product type <%=product_type%></p>
            <p>product price <%=price%></p>
            <p>product seller <%=seller_name%></p>
            <p>product info<%=product_Info%></p>
           
            <p>number : <input type="button" value="-" id="sub"><input type="text" value="1" id="amounts" maxlength="3" size="3" readonly><input type="button" value="+" id="add"></p>
            <input type="button" value="buy" class="buy" id="<%=product_id%>"/>
            </div>
        </div>
            
        <div id="commentdiv">
        <div style"float:left;">
        <p> comment <input type="text" id="comment"></p>
        <input type="button" value="comment" class="addcomment" id="<%=product_id%>"/>
        </div>
        <div id="showcomment">
            <%
                while(comment.next()){
                    out.println("<a class='user'>" + comment.getString("username") + "</a><br>");
                    out.println("<a class='comment'>" + comment.getString("comment") + "</a>");
                }
            %>
        </div>
        </div>
    </body>
    <script>
        $(".buy").click(function(){
            var product_id = this.id;
            var product_name = "<%=product_name%>";
            var price = "<%=price%>";
            var local = "<%=local%>";
            var seller_name = "<%=seller_name%>";
            var seller_id = "<%=seller_id%>";
            var number = $("#amounts").val();
            if(number <= 0){
                alert("invalid number");
            }else{
            $.post("addcart.jsp",{
                local:local,
                number:number,
                product_id:product_id,
                product_name: product_name,
                seller_name:seller_name,
                seller_id:seller_id,
                price:price
            }).done(function(){
                alert("successful");
            });
        }
        });
        $(".addcomment").click(function(){
            var product_id = this.id;
            var comment = $("#comment").val();
            $.post("addcomment.jsp",{
               comment:comment,
               product_id:product_id
            }).done(function(){
                location.reload();
            });
        });
        $("#sub").click(function(){
           var number = $("#amounts").val();
           if(number > 0){
               number = number - 1 ;
           }
           $("#amounts").val(number);
        });
        $("#add").click(function(){
           var number = $("#amounts").val();
           if(number >= 0){
               number = parseInt(number,10) +1 ;
           }
           $("#amounts").val(number);
        });
    
    </script> 
</html>
