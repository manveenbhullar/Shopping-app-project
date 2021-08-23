<%-- 
    Document   : ViewPendingOrders
    Created on : 16 Jan, 2020, 1:35:38 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@include file="Adminheader.jsp" %>
<script>
    var jsonar;
    function fetchorders()
    {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
                var mainjson = JSON.parse(response);
                jsonar = mainjson["ans"];

                var tab = "<table class='table table-bordered'>";
                tab += "<tr><th>OrderId </th><th>Emailid</th><th>DateTime</th><th>Total Amount</th></tr>";
                for (var i = 0; i <= jsonar.length - 1; i++)
                {
                    var jobj = jsonar[i];
                    tab += "<tr><td>" + jobj.orderid + "</td>";
                    tab += "<td>" + jobj.emailid + "</td>";
                    tab += "<td>" + jobj.datetime + "</td>";
                    tab += "<td>" + jobj.totalamt + "</td>";
                    //tab += "<td><img src = '" + jobj.photo + "' height=100 width=100/></td>";
                    tab += "<td><input type='button' value='Confirm' onclick=\"confirmcancel(" + jobj.orderid + ",'Confirmed')\" class='btn btn-info' /></td>";
                    tab += "<td><input type='button' value='Cancel' onclick=\"confirmcancel("+ jobj.orderid + ",'Cancelled')\" class='btn btn-warning' /></td>";
                    tab += "<td><input type='button' value='Details' onclick=\"details(" + jobj.orderid + ")\" class='btn btn-danger' /></td></tr>";
                }

                tab += "</table>";
                document.getElementById("divorders").innerHTML = tab;
            }
        };
        xhr.open("GET", "./FetchOrderServlet", true);
        xhr.send();
    }
    fetchorders();


    function confirmcancel(orderid, status)
    {
        alert(status);
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
                if (response == "success") {
                    fetchorders();
                }
            }
        };
        xhr.open("GET", "./ConfirmCancelServlet?orderid=" + orderid + "&status=" + status, true);
        xhr.send();
    }
    
    function details(orderid)
    {
   var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
                var mainjson = JSON.parse(response);
                jsonar = mainjson["ans"];
                var tab = "<table class='table table-bordered'>";
                tab += "<tr><th>Product Name</th><th>Product Price</th><th>Quantity</th><th>Total Amount</th><th>Photo</th></tr>";
                        for (var i = 0; i <= jsonar.length - 1; i++)
                {
                    var jobj = jsonar[i];
                    tab += "<tr><td>" + jobj.pname + "</td>";
                    tab += "<td>" + jobj.price + "</td>";
                    tab += "<td>" + jobj.qty + "</td>";
                    tab += "<td>" + jobj.totalprice + "</td>";
                    tab += "<td><img src='" + jobj.photo + "' height=150 width=150 /></td></tr>";
                }
                tab += "</table>";
                document.getElementById("divorderdetails").innerHTML = tab;
            }
        };

        xhr.open("GET", "./DeatilsServlet?orderid="+orderid , true);
                xhr.send();

    }
    
    




</script> 
<div id="divorders">

</div>
<h1>Order Details</h1>
<div id="divorderdetails">
   
</div>
<%@include file="footer.jsp" %>