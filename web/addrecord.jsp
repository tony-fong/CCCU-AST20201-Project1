<jsp:useBean id="cart" class="AST20201.Cartdata" scope="session"/>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("role") == null || session.getAttribute("role").toString() == "seller"){
        out.println(session.getAttribute("role").toString());
        out.println("please login as buyer");
    }else{      
        out.println(session.getAttribute("role").toString());
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
        String buyer_id = session.getAttribute("user_id").toString();
        boolean flag = false;
        ArrayList<String> seller_id = cart.getSellerId();
        ArrayList<String> product_id = cart.getProductId();
        ArrayList<String> price = cart.getPrice();
        ArrayList<String> number = cart.getNumber();
        
        //sql
        for(int i=0;i<product_id.size();i++){
            double a = Integer.parseInt(price.get(i));
            int b = Integer.parseInt(number.get(i));
            double c = a*b;
            String totalprice = Double.toString(c);
            String seller = seller_id.get(i);
            String product = product_id.get(i);
            String num = number.get(i);
            out.println("[" + buyer_id + " " + seller + " " + product + " " + num + " " + totalprice + " " + "]");
            String sql = "INSERT INTO `buyrecord`(`buyer_id`, `seller_id`, `product_id`, `amounts`, `total_price`) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement prestate = conn.prepareStatement(sql);
            prestate.setString(1, buyer_id);
            prestate.setString(2, seller);
            prestate.setString(3, product);
            prestate.setString(4, num);
            prestate.setString(5, totalprice);
            int result = prestate.executeUpdate();
            if(result == 1){
                flag = true;
            }
        }
        if(flag){
            out.println("order successful");
            cart.clear();
            out.println("<script>parent.location.reload();</script>");
        }
    }
%>
