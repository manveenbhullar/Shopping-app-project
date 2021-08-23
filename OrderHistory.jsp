<%-- 
    Document   : OrderHistory
    Created on : 18 Jan, 2020, 11:43:52 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="UserHeader.jsp" %>
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
                tab += "<tr><th>Order Id</th><th>Email Id</th><th>Date and Time</th><th>Total Amount</th><th>Status</th></tr>";
                for (var i = 0; i <= jsonar.length - 1; i++)
                {
                    var jobj = jsonar[i];
                    tab += "<tr><td>" + jobj.orderid + "</td>";
                    tab += "<td>" + jobj.emailid + "</td>";
                    tab += "<td>" + jobj.datetime + "</td>";
                    tab += "<td>" + jobj.totalamt + "</td>";
                    tab += "<td>" + jobj.status + "</td>";
                    tab += "<td><input type='button' onclick=\"details(" + jobj.orderid + ")\" value='Details' class='btn btn-warning' /></td></tr>";
                }
                tab += "</table>";
                document.getElementById("divorders").innerHTML = tab;
            }
        };
        xhr.open("GET", "./FetchOrderHistoryServlet?emailid="+'<%=session.getAttribute("emailid").toString()%>', true);
        xhr.send();
    }
    
    
     function details(orderid) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
                var mainjson = JSON.parse(response);
                jsonar = mainjson["ans"];
               var tab="<h1>Order Details</h1>";
                 tab += "<table class='table table-bordered'>";
                tab += "<tr><th>Product Name</th><th>Price</th><th>Quantity</th><th>Total Amount</th><th>Photo</th></tr>";
                        for (var i = 0; i <= jsonar.length - 1; i++)
                {
                    var jobj = jsonar[i];
                    tab += "<tr><td>" + jobj.pname + "</td>";
                    tab += "<td>" + jobj.price + "</td>";
                    tab += "<td>" + jobj.qty + "</td>";
                    tab += "<td>" + jobj.totalprice + "</td>";
                    tab += "<td><img src='" + jobj.photo + "' height=100 width=100 /></td></tr>";
                }
                tab += "</table>";
                document.getElementById("divorderdetails").innerHTML = tab;
            }
        };

        xhr.open("GET", "./DeatilsServlet?orderid="+orderid , true);
                xhr.send();

    }
    window.onload = fetchorders();
</script>
<div id="divorders">

</div>
<div id="divorderdetails">
   
</div>


    </body>
</html>


