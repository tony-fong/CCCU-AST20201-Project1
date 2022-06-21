<jsp:useBean id="obj" class ="AST20201.imghash" />
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page session="true"%>


<html>
<head>

</head>
<body>
<%
   if(session.getAttribute("username") == null){
       out.println("please login");
   }else{
   File file ;
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   String filePath = "d:\\AST20201\\Lab\\gpproject\\web\\img";
   String fileName = new String();
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
 
      DiskFileItemFactory factory = new DiskFileItemFactory();
      factory.setSizeThreshold(maxMemSize);
      factory.setRepository(new File("d:\\AST20201\\Lab\\gpproject\\web\\img"));
      ServletFileUpload upload = new ServletFileUpload(factory);
      upload.setSizeMax( maxFileSize );
        try{ 
         List fileItems = upload.parseRequest(request);
         Iterator i = fileItems.iterator();

            while (i.hasNext()){
                FileItem fi = (FileItem)i.next();
                if (!fi.isFormField()){

                    String fieldName = fi.getFieldName();
                    fileName = fi.getName();
                    fileName = obj.imgname(fileName);
                    if(fileName != ""){
                        session.setAttribute("filename" , fileName);
                    }
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    file = new File( filePath + "/" + fileName) ;
                    fi.write(file);
                    //out.println("Uploaded Filename: " + filePath + "\\" + fileName + "<br>");
                }else{
                }     
            }
            
        }catch(Exception ex) {
            System.out.println(ex);
        }
          
   }else{
      out.println("upload fall");
   }
 
    //get data    
    String file_name = session.getAttribute("filename").toString();
    String user_id = session.getAttribute("user_id").toString();
    String product_name = (String)session.getAttribute("create_Product_name");
    String type = (String)session.getAttribute("create_Product_type");
    String price = (String)session.getAttribute("create_Product_price");
    String info = (String)session.getAttribute("create_Product_info");
    String img = "img\\" + file_name; 
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
        
    //sql
    String sql = "INSERT INTO `product`(`type`, `product_name`, `price`, `info`, `user_id`,`img`) VALUES (?, ?, ?, ?, ?,?)";
    PreparedStatement prestate = conn.prepareStatement(sql);
    prestate.setString(1, type);
    prestate.setString(2, product_name);
    prestate.setString(3, price);
    prestate.setString(4, info);
    prestate.setString(5, user_id);
    prestate.setString(6, img);
    int result = prestate.executeUpdate();
    out.println("<script>parent.location.reload();</script>");
    if(result == 1){
        out.println("upload successful");
    }
   }
%>
</body>
</html>
 