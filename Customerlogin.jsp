<%-- 
    Document   : Customerlogin
    Created on : 6 Jan, 2020, 10:45:37 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="Signupheader.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <body>
        <script>
            function login()
            {
                var emailid = document.getElementById("emailid").value;
                var pass = document.getElementById("pass").value;
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function ()
                {
                    if (xhr.readyState == 4 && xhr.status == 200)
                    {
                        var resp = xhr.responseText.trim();
                        if (resp == "Login Success!!")
                        {

                            alert("Login Success");

                            window.location.href = "HomePage.jsp";
                        } else
                        {
                            alert("Login Failed");

                        }
                    }
                };
                xhr.open("GET", "./LoginServlet?emailid=" + emailid + "&pass=" + pass, true);
                xhr.send();
            }
        </script>
    </head>
    <div class="container">
        <div class="jumbotron">
            <h1>Customer Login form</h1>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered">
                    <div class="form-group form-row">
                        <form action="./LoginServlet" method="POST">
                            <label class="col-md-3" for="emailid">Email id</label>
                            <div class="col-md-9">
                                <input type="email" class="form-control" name="emailid" id="emailid" placeholder="Enter Email-id" />
                            </div>
                    </div>
                    <div class="form-group form-row">
                        <label class="col-md-3" for="pass">Password</label>
                        <div class="col-md-9">
                            <input type="password" class="form-control" name="pass" id="pass" placeholder="Enter password" />
                        </div>
                    </div>
                    
                    <div class="form-group form-row">
                        <div class="offset-md-3 col-md-9">
                            <input type="button" class="btn btn-primary btn-block" value="Login" onclick="login()"/> <br/>
                        </div>
                    </div>
            </div>
        </div>
    </div>
    <%@include file="Signupfooter.jsp"%>
