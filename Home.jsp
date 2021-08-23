<%-- 
    Document   : Home
    Created on : 7 Jan, 2020, 11:24:28 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Signupheader.jsp"%> 

<script>
    var jsonar = "";
    function view()

    {
        var cat = document.getElementById("categoryname").value;
        console.log("cat" + cat);
        var data = "";
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
//                alert(response);
                var mainjson = JSON.parse(response);
                jsonar = mainjson["ans"];
                for (var i = 0; i < jsonar.length; i++) {
                    data += "<div class='col-md-3' style='border: 1px solid black; position: relative;margin: 2%;'>";
                    data += "<label>" + jsonar[i].pname + "</label><br>";
                    data += "<img src='" + jsonar[i].photo + "' width='200' height='200' style='border: 1px solid black;' onmouseenter=\"showtext(" + i + ")\" onmouseout=\"hidetext(" + i + ")\"><br>";

                    data += "<label>Price:" + jsonar[i].price + "</label><br>";
                    data += "<span id=" + i + " style='display: none;position: absolute;padding: 2%;z-index:1;top:40%;left:40%;background-color:black;color: white;'>" + jsonar[i].description + "</span>"
                    data += "<button type='button' class='btn btn-success btn-block' onclick='AddToCart(" + i + ")'>Add to cart</button>";
                    data += "</div>";
                }
                document.getElementById("mydiv").innerHTML = data;
            }
        };
        xhr.open("GET", "./HomeServlet?category=" + cat, true);
        xhr.send();
    }
    function showtext(index) {
        document.getElementById(index).style.display = "inline";
    }
    function hidetext(index) {
        document.getElementById(index).style.display = "none";
    }

    function AddToCart(index) {
        var category = jsonar[index].category;
//        var category = document.getElementById("category").value;
        var pid = jsonar[index].pid;
        var productname = jsonar[index].pname;
//        var productdesc = document.getElementById("productdesc").value;
        var price = jsonar[index].price;
        var photos = jsonar[index].photo;

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function ()
        {
            if (xhr.readyState == 4 && xhr.status == 200)
            {
                var response = xhr.responseText.trim();
                alert(response);
            }
        };
        xhr.open("GET", "./AddtocartServlet?category=" + category + "&pname=" + productname + "&price=" + price +"&photo=" + photos + "&pid=" + pid , true);
                xhr.send();
    }
</script>

<div class="container">
    <div class="row">
        <div class="col-md-12">

            <table class="table table-striped">
                <tr>
                    <td>Category Name</td>
                    <td>

                        <select name="products" id="categoryname" class="form-control">
                            <option>--Select Category--</option>
                            <option value="Clothes">Clothes</option>
                            <option value="Footwear">Footwear</option>
                            <option value="Accessories">Accessories</option>
                            <option value="Elecronics">Electronics</option>
                        </select>
                    </td>
                </tr>


                <tr>

                    <td>
                        <input type="button" value="View" onclick="view()" class="btn btn-primary" />
                    </td>
                </tr>
            </table>

            <!--<div class="row">-->
            <div id="mydiv" class="row">

            </div>
        </div>
    </div>
    <!--</div>-->
</div>

<%@include file="footer.jsp" %>












