<%-- 
    Document   : ShoppingCart
    Created on : 10 Jan, 2020, 11:08:58 AM
    Author     : Dell
--%>

<%@page import="VMM.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="Signupheader.jsp" %>

<script>
    var indexForEdit = -1;
    function deletecart(index)
    {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
                if (response == "Success")
                {
                    alert("Deleted Successfully");
                    window.location.href = "ShoppingCart.jsp";
                }

            }
        };
        xhr.open("GET", "./DeleteCartServlet?index=" + index, true);
        xhr.send();
    }

    function editcart(index)
    {

        $("#editqty").modal('show');
        indexForEdit = index;
    }

    function updatecart()
    {
//        document.getElementById("pid").value = pid;
        var qty = document.getElementById("quantity").value;
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
                alert(response);
                document.getElementById("qty" + indexForEdit).innerHTML = qty;
                document.getElementById("tprice" + indexForEdit).innerHTML = parseInt(qty) * parseInt(document.getElementById("price" + indexForEdit).innerHTML);
                alert(document.getElementById("tprice" + indexForEdit).innerHTML);
                $("#editqty").modal('hide');
                changeTotal();
            }
        };
        xhr.open("GET", "./EditCartServlet?index=" + indexForEdit + "&qty=" + qty, true);
        xhr.send();
    }

    function changeTotal() {
        var size = parseInt(document.getElementById("alsize").value);
        var totalprice = 0;
        for (var i = 0; i < size; i++) {
            var qty = document.getElementById("qty" + i).innerHTML;
            var price = document.getElementById("price" + i).innerHTML;
            var tprice = document.getElementById("tprice" + i).innerHTML;
            totalprice = totalprice + parseInt(tprice);
        }
        document.getElementById("totalprice").innerHTML = totalprice;
    }

    function login()
    {
        var emailid = document.getElementById("l_emailid").value;
        var pass = document.getElementById("l_pass").value;
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var resp = xhr.responseText.trim();
                if (resp == "Login Success!!")
                {

                    alert("Login Success");
                    $("#loginmodal").modal('hide');
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
<%
    if (session.getAttribute("cartlist") != null) {
        ArrayList<Product> al = (ArrayList<Product>) session.getAttribute("cartlist");
%>

<input type="hidden" id="alsize" value="<%=al.size()%>">

<h1>My Cart</h1>
<table class="table table-bordered">
    <thead>
        <tr>
            <th>Sr.No.</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Total price</th>
            <th>Photo</th>
            <th>Edit Data</th>
            <th>Delete Data</th>

        </tr>
    </thead>
    <tbody>
        <%
            int tp = 0;

            for (int i = 0; i < al.size(); i++) {
                tp = tp + (al.get(i).price * al.get(i).quantity);
        %>
        <tr id="singlerow<%=i%>">
            <td><%=i + 1%></td>
            <td><%=al.get(i).pname%></td>
            <td><label id="price<%=i%>"><%=al.get(i).price%> </td>
            <td><label id="qty<%=i%>"><%=al.get(i).quantity%></label> </td>
            <td><label id="tprice<%=i%>"><%=al.get(i).price * al.get(i).quantity%></label></td>
            <td><img src="<%=al.get(i).photo%>" width="100" height="100"> </td>
            <td><input type="button" class="btn-danger" value="Edit" onclick="editcart(<%=i%>)"</td>
            <td><input type="button" class="btn-primary" value="Delete" onclick="deletecart(<%=i%>)"</td>
        </tr>



        <%}%>
    </tbody>
</table>
<label id ="totalprice" style="border: 1px solid black; background-color:buttonface; color: black; float: right; padding: 10px; margin-right: 10%;">
    <%=tp%>

</label>
<input type="hidden" id="tprice2"/>


<!-- receive ur normal text data on next page , like we do regularly -->

<!--<input type="text"  name="t1" value="Make Payment and Place Order" />-->

<center><input type="button" class="btn btn-success active" value="Proceed To Payment" id="rzp-button1"/></center><br>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>

                document.getElementById('rzp-button1').onclick = function (e) {
//                            calculate();

                    var amount = parseInt(document.getElementById("totalprice").innerHTML);
                    alert(amount);
                    var xhr = new XMLHttpRequest();
                    xhr.onreadystatechange = function ()
                    {
                        if (xhr.readyState == 4 && xhr.status == 200)
                        {
                            var resp = xhr.responseText.trim();
                            alert(resp);
                            if (resp == "no")
                            {

                                $("#loginmodal").modal('show');
//                            alert("Login Success");


                            } else
                            {
                                var options = {
                                    "key": "rzp_test_dRWiKHS7zr2Gki",
                                    "amount": (amount * 100),
                                    "name": "Online Shopping",
                                    "description": "Online Payment System",
                                    "image": "http://ecourses.aec.edu.in/aditya/images/po4.png",
                                    "handler": function (response) {
                                        //alert(response.razorpay_payment_id);
                                        if (response.razorpay_payment_id == "")
                                        {
                                            alert('Failed');
//                                        window.location.href = "add_payment_details.php?status=failed";
                                        } else {
                                            alert('success');
    <%     session.setAttribute("status","paid");%>
                                  
                                            var tprice = document.getElementById("totalprice").innerHTML;
                                            var status = "Pending";
                                            
                                            window.location.href = "orderplaced.jsp?tprice=" + tprice + "&emailid=" + resp + "&status=" + status;
 
                                        }


                                    },

                                    "prefill": {
                                        "name": "",
                                        "email": ""
                                    },
                                    "notes": {
                                        "address": ""
                                    },
                                    "theme": {
                                        "color": "#F37254"
                                    }
                                };
                                var rzp1 = new Razorpay(options);
                                rzp1.open();
                                e.preventDefault();
                            }


                        }

                    };
                    xhr.open("GET", "./CheckLogin", true);
                    xhr.send();
                };</script>
<!-- Note that the amount is in paise = 500 INR -->
<!-- This script will show payment screen and block form submit until, payment is successful -->






<%
    }%>


<div id="editqty" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Edit product</h3>
                <button type="button" class="close" data-dismiss="modal">X</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <select name="quantity" id="quantity" class="form-control">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>


                    <input type="button" value="Update" onclick="updatecart()" class="btn btn-primary" />

                </div>
            </div>
        </div>
    </div>
</div>

<div id="loginmodal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Login</h3>
                <button type="button" class="close" data-dismiss="modal">X</button>
            </div>
            <div class="modal-body">
                <table class ="table table-bordered">

                        <tr>
                            <td>Email Id </td>
                            <td>
                                <input type ="text" id="l_emailid" class="form-control" placeholder="Enter Email"/>
                            </td>
                        </tr>


                        <tr>
                            <td>Password </td>
                            <td>
                                <input type ="password" id="l_pass" class="form-control" placeholder="Enter Password"/>
                            </td>
                        </tr>
                       
                     
                        <tr>
                               <td></td>
                               <td>  <input type="button" value="Login" onclick="login()" class="btn btn-primary" /></td>
                       </tr>

                </table>
                       </div>
                    </div>
            </div>
        </div>
 
    




    <%@include file="Signupfooter.jsp" %>