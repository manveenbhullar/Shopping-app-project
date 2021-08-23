<%-- 
    Document   : Adminheader
    Created on : 3 Jan, 2020, 11:46:35 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              rel="stylesheet" type="text/css" />
        <script src="js/jquery-3.4.1.min.js" type="text/javascript"></script>
        <script src="js/popper.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
       
    </head>
    <body>
        <nav class="navbar navbar-expand-md bg-success  navbar-light">
            <a href="#" class="navbar-brand">Online Shopping</a>
            <button type="button" class="navbar-toggler" data-toggle="collapse"
                    data-target="#menubar1">
                <span class="navbar-toggler-icon"></span>          
            </button>
            <div class="collapse navbar-collapse" id="menubar1">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="AdminHome.jsp">Home</a></li>


                    <li class="nav-item"><a class="nav-link" href="ManageProducts.jsp">Manage Products </a></li>

                    <li class="nav-item"><a class="nav-link" href="AdminChangePassword.jsp">Change Password </a></li>

                    <li class="nav-item"><a class="nav-link" href="ViewPendingOrders.jsp">Pending Orders </a></li>
                    <li class="nav-item"><a class="nav-link" href="AdminLogout.jsp">Logout</a></li>






                </ul>
            </div>
        </nav>
