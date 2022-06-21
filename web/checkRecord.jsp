<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  if(session.getAttribute("username") == null){
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
       

        try{
            conn = DriverManager.getConnection(
                  url
            );
            stmt = conn.createStatement();
        }catch(SQLException e){
            out.println("connection error: " + e);
        }
        //data
        String role = session.getAttribute("role").toString();
        String user_id = session.getAttribute("user_id").toString();
        if(role.equals("buyer")){
           
            ResultSet rs = null;
            String sql = "Select (SELECT username from user where user_id = seller_id) as 'seller', record_id , product_name , amounts, total_price, date from buyrecord join product where buyer_id = ? GROUP by  record_id";
            PreparedStatement prestate = conn.prepareStatement(sql);
            prestate.setString(1,user_id);
            rs = prestate.executeQuery();
            out.println("<table>");
            out.println("<tr><td>record id</td><td>product</td><td>seller</td><td>amounts</td><td>price</td><td>date</td><tr>");
            while(rs.next()){
                out.println("<tr>");
                out.println("<td>" + rs.getInt("record_id") + "</td>");
                out.println("<td>" + rs.getString("product_name") + "</td>");
                out.println("<td>" + rs.getString("seller") + "</td>");
                out.println("<td>" + rs.getString("amounts") + "</td>");
                out.println("<td>" + rs.getString("total_price") + "</td>");
                out.println("<td>" + rs.getString("date") + "</td>");
                out.print("</tr>");
            }
            out.println("</table>");
        }else if(role.equals("seller")){
            ResultSet summary = null;
            ResultSet detail = null;
            String summarySQL = "Select count(*) as 'number', sum(total_price) as 'price' , date_format(Date, '%Y-%m-%d') as 'DAY' from buyrecord where seller_id = ? group by DAY(Date)";
            String detailSQL = "Select record_id, (select username from user where user_id = buyer_id) as 'username' , product_id, product_name, price ,amounts, total_price from buyrecord NATURAL join product where seller_id = ? AND DATE(date) = ? Group by record_id";
            //summary
            PreparedStatement preSummary = conn.prepareStatement(summarySQL);
            preSummary.setString(1,user_id);
            summary = preSummary.executeQuery();
            //detail
            while(summary.next()){
                out.println("<details class='details'>");
                out.println("<summary>" + summary.getDate("DAY") + "</summary>");
                
                PreparedStatement preDetail = conn.prepareStatement(detailSQL);
                preDetail.setString(1,user_id);
                preDetail.setDate(2, summary.getDate("DAY"));
                detail = preDetail.executeQuery();
                
                out.println("<p><a>record id</a><a>| username</a><a>| product_id</a><a>| product_name</a><a>| price</a><a>| amount</a><a>| total price</a></p>");
                while(detail.next()){
                //printout one by one :
                    
                    out.println("<a>" + detail.getInt("record_id") + "</a>");
                    out.println("<a>| " + detail.getString("username") + "</a>");
                    out.println("<a>| " + detail.getInt("product_id") + "</a>");
                    out.println("<a>| " + detail.getString("product_name") + "</a>");
                    out.println("<a>| " + detail.getInt("price") + "</a>");
                    out.println("<a>| " + detail.getInt("amounts") + "</a>");
                    out.println("<a>| " + detail.getInt("total_price") + "</a><br>");
                }
                
                out.println("</details>");
            }
        }else if(role.equals("admin")){
           
            ResultSet rs = null;
            String sql = "Select (SELECT username from user where user_id = seller_id) as 'seller', (SELECT username from user where user_id = buyer_id) as 'buyer', `record_id`,`buyer_id`,`seller_id`,`product_id`,`amounts`,`Date`,`total_price`,product_name from buyrecord NATURAL join product";
            PreparedStatement prestate = conn.prepareStatement(sql);
            rs = prestate.executeQuery();
            out.println("<table>");
            out.println("<tr><td>record id</td><td>product</td><td>seller</td><td>amounts</td><td>price</td><td>date</td><tr>");
            while(rs.next()){
                out.println("<tr>");
                out.println("<td>" + rs.getInt("record_id") + "</td>");
                out.println("<td>" + rs.getString("product_name") + "</td>");
                out.println("<td>" + rs.getString("seller") + "</td>");
                out.println("<td>" + rs.getString("buyer") + "</td>");
                out.println("<td>" + rs.getString("amounts") + "</td>");
                out.println("<td>" + rs.getString("total_price") + "</td>");
                out.println("<td>" + rs.getString("date") + "</td>");
                out.print("</tr>");
            }
            out.println("</table>");
        
    }
}
%>