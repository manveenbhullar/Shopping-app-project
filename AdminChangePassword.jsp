<%-- 
    Document   : AdminChangePassword
    Created on : 16 Jan, 2020, 1:16:45 PM
    Author     : Dell
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Adminheader.jsp" %>
<!DOCTYPE html>

        <title>Create new password</title>
       
        <script>
            function changepassword()
            {
                var username = document.getElementById("username").value;
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
                            if (resp == "Password changed successfully")
                            {
                                alert("Password changed successfully")
                                window.location.href = "Admin.jsp";
                            } else
                            {
                                alert("Old password is wrong")
                            }
                        }

                    }
                }
                ;
                xhr.open("GET", "./AdminPasswordServlet?username=" + username + "&pass=" + pass + "&newpass=" + newpass, true);
                xhr.send();
            }

        </script>
    <div class="container">
        <div class="jumbotron">
            <h1>Create new password</h1>
        </div>
        <div class="row">
            <div class="col-md-12">


                <!--<form id ="form1" method="POST" enctype="multipart/form-data">-->

                    <table class="table table-bordered">
                        <tr>
                            <td><label for="name"><b>Username</b></label></td>
                            <td>
                                <input type="text" id="username" name="username" class="form-control"  value="<%=session.getAttribute("username").toString()%>" readonly=""/>

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

                        <tr>
                            <td></td>
                        <td>
                            <input type="button" onclick="changepassword()" class="btn btn-primary btn-block" value="Change Password"/> <br/>
                        </td>
                        </tr>


                        </div>
                        </div>
                <!--</form>-->

                </table>

                