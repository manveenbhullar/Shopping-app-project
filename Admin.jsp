<%-- 
    Document   : Admin
    Created on : 16 Jan, 2020, 12:28:34 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
    </head>
    <script>
        function login()
            {
                var username = document.getElementById("username").value;
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
                            window.location.href = "AdminHome.jsp";

                        } else
                        {
                            alert("Login Failed");

                        }
                    }
                };
                xhr.open("GET", "./AdminLogin?username=" + username + "&pass=" + pass, true);
                xhr.send();
            }
    </script>
    <body>
        <div class="container">
            <div class="jumbotron">
                <h1>Login Form</h1>
            </div>
   <div class="row">
            <div class="col-md-12">
                <table class="table table-bordered">
                    <div class="form-group form-row">
                        <form action="./LoginServlet" method="POST">
                            <label class="col-md-3" for="emailid">Email id</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="username" id="username" placeholder="Enter Username" />
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
    </body>
</html>
