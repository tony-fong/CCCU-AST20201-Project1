<%-- 
    Document   : logout
    Created on : 2020年5月2日, 下午05:04:55
    Author     : tonyf
--%>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% session.invalidate(); %>
<% out.println("<script>parent.location.reload();</script>");%>