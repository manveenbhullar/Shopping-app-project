<%-- 
    Document   : ForgotPassword
    Created on : 6 Jan, 2020, 12:14:59 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Create new password</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />

    <body>
        <script>
            function changepassword()
            {
                var email = document.getElementById("emailid").value;
                var pass = document.getElementById("pass").value;
                var newpass = document.getElementById("newpass").value;
                var conpass = document.getElementById("conpass").value;
                if (pass == "" || newpass == "" || conpass == "")
                {
                    alert("All fields are must!!");
                } else if (newpass != conpass)
                {
                    alert("Passwords don't match")
                } else
                {
                    var xhr = new XMLHttpRequest();
                    xhr.onreadystatechange = function ()
                    {
                        if (xhr.readyState == 4 && xhr.status == 200)
                        {
                            var resp = xhr.responseText.trim();
//                            alert(resp);
                            if(resp=="Password changed successfully")
                            {
                                alert("Password changed successfully")
                                window.location.href = "Customerlogin.jsp";
                            }
                            else
                            {
                                alert("Old password is wrong")
                            }
                        }

                    }
                }
                ;
                xhr.open("GET", "./PasswordServlet?emailid=" + email + "&pass=" + pass + "&newpass=" + newpass, true);
                xhr.send();
            }

        </script>
    </head>
    <div class="container">
        <div class="jumbotron">
            <h1>Create new password</h1>
        </div>
        <div class="row">
            <div class="col-md-12">


                <form id ="form1" method="POST" enctype="multipart/form-data">

                    <table class="table table-bordered">
                        <tr>
                            <td><label for="name"><b>E-Mail Id</b></label></td>
                            <td>
                                <input type="text" id="emailid" name="emailid" class="form-control"  value="<%=session.getAttribute("emailid").toString()%>" readonly=""/>

                            </td>
                        </tr>

                        <tr>
                            <td><label for="pass"><b> Old Password</b></label></td>
                            <td>
                                <input type="password" id="pass" name="pass" class="form-control" placeholder="Enter old password"/>
                            </td>
                        </tr>   


                        <tr>
                            <td><label for="pass"><b> New Password</b></label></td>
                            <td>
                                <input type="password" id="newpass" name="newpass" class="form-control" placeholder="Enter new password"/>
                            </td>
                        </tr>   


                        <tr>
                            <td> <label for="conpass"><b>Confirm Password</b></label></td>
                            <td>
                                <input type="password" id="conpass" name="conpass" class ="form-control" placeholder="Re-enter new password"/>
                            </td>
                        </tr>   

                        
                            <td>
                            <input type="button" onclick="changepassword()" class="btn btn-primary btn-block" value="Change Password"/> <br/>
                        </td>
                        


                        </div>
                        </div>
                </form>

                </table>
                </body>
                </html>
