<%-- 
    Document   : Customersignup
    Created on : 3 Jan, 2020, 12:41:26 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="Signupheader.jsp" %>
<html>
    <head>
        <title>Sign up form</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <body>
        <script>
            function readandPreview(input, imgid)
            {
                if (input.files && input.files[0])
                {
                    var reader = new FileReader();
                    reader.onload = function (e)
                    {
                        document.getElementById(imgid).src = e.target.result;
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            function signup()
            {
                var emailid = document.getElementById("emailid").value;
                var pass = document.getElementById("pass").value;
                var conpass = document.getElementById("conpass").value;
                var fname = document.getElementById("fname").value;
                var mobile = document.getElementById("mobile").value;
                var address = document.getElementById("address").value;
                var photo = document.getElementById("photo").files;
                if (emailid == "" || pass == "" || fname == "" || mobile == "" || address == "")
                {
                    alert("All fields are must!!");
                } else if (photo.length == 0)
                {
                    alert("Your photo is must");
                } else
                {
                    var formdata = new FormData();
                    var controls = document.getElementById("form1").elements;
                    var flag = 0;
                    for (var i = 0; i <= controls.length - 1; i++)
                    {
                        if (controls[i].name == "" || controls[i].name == null)
                        {
                            flag = 1;
                        }
                        if (controls[i].type == "file")
                        {
                            formdata.append(controls[i].name, controls[i].files[0]);
                        } else
                        {
                            formdata.append(controls[i].name, controls[i].value);
                        }
                    }
                    if (flag == 1)
                    {
                        alert("Give name attribute to all the form elements");
                    } else
                    {
//                        for (var pair of formdata.entries()) {
//                            console.log(pair[0] + ', ' + pair[1]);
//                        }
                        var xhr = new XMLHttpRequest();
                        xhr.onreadystatechange = function ()
                        {
                            if (xhr.readyState == 4 && xhr.status == 200)
                            {
                                var response = xhr.responseText.trim();
                                alert(response);
                                fetchdata();
                            }
                        };
                        xhr.open("POST", "./SignUpServlet", true);
                        xhr.send(formdata);

                    }
                }
            }
            function fetchdata()
            {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function ()
                {
                    if (xhr.readyState == 4 && xhr.status == 200)
                    {
                        var response = xhr.responseText.trim();
                        var mainjson = JSON.parse(response);
                        var jsonar = mainjson["ans"];

                        var tab = "<select name='emailid' id='emailid' class='form-control'>";
                        for (var i = 0; i <= jsonar.length - 1; i++)
                        {
                            var jobj = jsonar[i];
                            tab += "<option>" + jobj.name + "</option>";

                        }
                        tab += "</select>";

                        document.getElementById("div1").innerHTML = tab;
                    }
                };
                xhr.open("GET", "./fetchdataservlet", true);
                xhr.send();

            }

        </script>
    </head>
    <div class="container">
        <div class="jumbotron">
            <h1>Customer Sign up form</h1>
        </div>
        <div class="row">
            <div class="col-md-12">


                <form id ="form1" method="POST" enctype="multipart/form-data">

                    <table class="table table-bordered">
                        <tr>
                            <td><label for="emailid"><b>Email id</b></label></td>
                            <td>
                                <input type="email" id="emailid" name="emailid" class="form-control" placeholder="Enter email id" />
                            </td>
                        </tr>

                        <tr>
                            <td><label for="pass"><b>Password</b></label></td>
                            <td>
                                <input type="password" id="pass" name="pass" class="form-control" placeholder="Enter password"/>
                            </td>
                        </tr>   

                        <tr>
                            <td> <label for="conpass"><b>Confirm Password</b></label></td>
                            <td>
                                <input type="password" id="conpass" name="conpass" class ="form-control" placeholder="Re-enter password"/>
                            </td>
                        </tr>   
                        <tr>
                            <td><label for="fname"><b>Full Name</b></label></td>
                            <td>
                                <input type="text" id="fname" name="fname" class="form-control" placeholder="Enter your full name"/>
                            </td>
                        </tr>

                        <tr>
                            <td><label for="mobile"><b>Mobile No.</b></label></td>
                            <td>
                                <input type="text" id="mobile" name="mobile" class="form-control" placeholder="Enter mobile number"/>
                            </td>
                        </tr>

                        <tr>
                            <td><label for="address"><b>Address</b></label></td>
                            <td>
                                <textarea name="address" id="address" name="address" class="form-control" placeholder="Enter address"/></textarea>
                            </td>
                        </tr>


                        <tr>   
                            <td><b>Photo</b></td>
                            <td>
                                <input type="file" onchange="readandPreview(this, 'image1')" id="photo" name="photo" /><br/>
                                <img src="" id="image1" height="80" width="100" />
                            </td>
                        </tr>

                        <tr>
                          
                            <td>

                                <input name="btnadd" type="button" onclick="signup()" class="btn btn-primary btn-block" value="SIGNUP" /> <br/>
                            </td>
                        </tr>
                    </table>  
                </form>
            </div>
        </div>
    </div>
 <%@include file="Signupfooter.jsp"%>
