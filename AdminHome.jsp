<%-- 
    Document   : AdminHome
    Created on : 16 Jan, 2020, 1:02:29 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="Adminheader.jsp" %>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
       
    </head>
    <body>
        <h1>Welcome <%=session.getAttribute("username").toString()%></h1>     
    </body>
        
</html>
