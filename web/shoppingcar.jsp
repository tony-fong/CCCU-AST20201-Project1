<jsp:useBean id="cart" class="AST20201.Cartdata" scope="session"/>
<jsp:useBean id="path" class="AST20201.Rewirte"/>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page session="true"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
   if(session.getAttribute("username") == null){
        out.println("login please");
   }else{ 
   String buyer_id = session.getAttribute("user_id").toString();
   ArrayList<String> seller_id = cart.getSellerId();
   ArrayList<String> product_id = cart.getProductId();
   ArrayList<String> product_name = cart.getProductName();
   ArrayList<String> price = cart.getPrice();
   ArrayList<String> number = cart.getNumber();
   ArrayList<String> local = cart.getLocal();
   ArrayList<String> seller_name = cart.getSellerName();

   /*out.println(seller_id);
   out.println(product_id);
   out.println(product_name);
   out.println(price);
   out.println(number);
   out.println(local);
   out.println(seller_name);*/
   int totalprice = 0;
   if(local.size() == 0){
       out.println("noting in the shopping car go to buy some");
   }else{
        out.println("<table style='text-align: center;'>");
        out.print("<td>image</td><td>product name</td><td>seller name</td><td>amount</td><td>price</td>");
        for(int i=0; i < local.size(); i++){
           out.println("<tr class='list' id='" + product_id.get(i) + "'>");
           String temp = local.get(i);
           String filepath = "";
           filepath =  path.rewrite(temp);
           out.println("<td><img src=" + filepath + " width='130' hight='200'></td>");
           out.println("<td>" + product_name.get(i) + "</td>");
           out.println("<td>" + seller_name.get(i) + "</td>");
           out.println("<td>" + number.get(i) + "</td>");
           out.println("<td>" + price.get(i) + "</td>");      

           int num = Integer.parseInt(number.get(i));
           int pric = Integer.parseInt(price.get(i));
           totalprice = totalprice + num * pric; 
           out.println("</tr>");
    }
    out.println("</table>");    
    out.println("<input type='button' id='but' value='pay'>");
    out.println("<div id='result'> </div>");
   }
%>
<html>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script>
      $("#but").click(function(){
          var pay = confirm("total price is " + <%=totalprice%> + "");
          if(pay){
            $.post("addrecord.jsp",{
            }).done(function(data){
                $("#result").html(data);
            });
        }else{
            alert("cancell");
        }
      });  
    </script>
<%}%>    
</html>