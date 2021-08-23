<!DOCTYPE html>
<%@include file="Adminheader.jsp"%>
<script>
    var pid = -1;
 
            var jsonar;
            function fetchproducts()
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
                        tab += "<tr><th>Product name</th><th>Product description</th><th>Product price</th><th>Category name</th><th>Photo</th></tr>";
                        for (var i = 0; i <= jsonar.length - 1; i++)
                        {
                            var jobj = jsonar[i];
                            tab += "<tr><td>" + jobj.pname + "</td>";
                            tab += "<td>" + jobj.description + "</td>";
                            tab += "<td>" + jobj.price + "</td>";
                            tab += "<td>" + jobj.category + "</td>";
                            tab += "<td><img src = '" + jobj.photo + "' height=100 width=100/></td>";
                            tab += "<td><input type='button' value='Edit' onclick='editproduct(" + i + ")' class='btn btn-warning' /></td>";
                            tab += "<td><input type='button' onclick='deleteproduct(\"" + jobj.pid + "\")' value='Delete' class='btn btn-danger' /></td></tr>";
                        }

                        tab += "</table>";
                        document.getElementById("divproducts").innerHTML = tab;
                    }
                };
                xhr.open("GET", "./FetchProducts", true);
                xhr.send();
            }
 
    fetchproducts();

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
    function manageproducts()
    {
        var categoryname = document.getElementById("categoryname").value;
        var productname = document.getElementById("productname").value;
        var productdesc = document.getElementById("productdesc").value;
        var price = document.getElementById("price").value;
        var photo = document.getElementById("photo").files;
        if (productname == "" || productdesc == "" || price == "")
        {
            alert("All fields are must!!");
        } else if (photo.length == 0)
        {
            alert("Category photo is must");
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

                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function ()
                {
                    if (xhr.readyState == 4 && xhr.status == 200)
                    {
                        var response = xhr.responseText.trim();
                        alert(response);
                        fetchproducts();
                    }
                };
                xhr.open("POST", "./ManageProductsServlet", true);
                xhr.send(formdata);

            }
        }
    }

    function deleteproduct(pid)
    {
        if (confirm("ARE YOU SURE YOU WANT TO DELETE?"))
        {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function ()
            {
                if (xhr.readyState == 4 && xhr.status == 200)
                {
                    var resp = xhr.responseText.trim();
                    if (resp == "Success")
                    {
                        alert("Product has been deleted");
                        fetchproducts();
                    } else
                    {
                        alert("Product can't be deleted");
                    }
                }
            };
            xhr.open("GET", "./DeleteProductsServlet?pid=" + pid, true);
            xhr.send();
        }
    }
    function editproduct(index)
    {
//                alert(jsonar.length);
        var jobj = jsonar[index];
        pid = jobj.pid;
//                alert(jsonar[index].pname);
        var categoryname = jobj.category;
        var productname = jobj.pname;
        var productdesc = jobj.description;
        var price = jobj.price;
        var photo = jobj.photo;

        document.getElementById("editcategoryname").value = categoryname;
        document.getElementById("editproductname").value = productname;
        document.getElementById("editproductdesc").value = productdesc;
        document.getElementById("editprice").value = price;
        document.getElementById("editimage1").src = photo;

        $("#editproductmodal").modal('show');
    }
    function editcategory()
    {
        var categoryname = document.getElementById("editcategoryname").value;
//                alert(categoryname);
        document.getElementById("pid").value = pid;
        var productname = document.getElementById("editproductname").value;
        var productdesc = document.getElementById("editproductdesc").value;
        var price = document.getElementById("editprice").value;


        if (productname == "" || productdesc == "" || price == "")
        {
            alert("Fields are must");
        } else
        {
            var formdata = new FormData();
            var controls = document.getElementById("form2").elements;
            var flag = 0;
            for (var i = 0; i <= controls.length - 1; i++)
            {
                if (controls[i].name == "" || controls[i].name == null)
                {
                    flag = 1;
                }
                if (controls[i].type == "file" && controls[i].files.length > 0)
                {
                    formdata.append(controls[i].name, controls[i].files[0]);
                }
                if (controls[i].type != "file")
                {
                    formdata.append(controls[i].name, controls[i].value);
                }
            }
            if (flag == 1)
            {
                alert("Give name attribute to all the form elements");
            } else
            {
                for (var pair of formdata.entries()) {
                    console.log(pair[0] + ', ' + pair[1]);
                }
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function ()
                {
                    if (xhr.readyState == 4 && xhr.status == 200)
                    {
                        var response = xhr.responseText.trim();
                        alert(response);
                        fetchproducts();
                        $("#editproductmodal").modal('hide');
                    }
                };
                xhr.open("POST", "./EditProductsServlet", true);
                xhr.send(formdata);
            }
        }
    }

</script>

<div class="container">
    <div class="jumbotron">
        <h1>Add shopping products</h1>
    </div>
    <div class="row">
        <div class="col-md-12">


            <form id ="form1" method="POST" enctype="multipart/form-data">
                <table class="table table-bordered">
                    <tr>
                        <td>Category Name</td>
                        <td>

                            <select name="products" id="categoryname">
                                <option value="Clothes">Clothes</option>
                                <option value="Footwear">Footwear</option>
                                <option value="Accessories">Accessories</option>
                                <option value="Elecronics">Electronics</option>

                            </select>


                        </td>
                    </tr>
                    <tr>
                        <td>Product name</td>
                        <td>
                            <input type="text" name="productname" id="productname" class="form-control" placeholder="Enter product name" >
                        </td>
                    </tr>
                    <tr>
                        <td>Product Description</td>
                        <td>
                            <textarea name="productdesc" id="productdesc" class="form-control" placeholder="Enter product description" ></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Price</td>
                        <td>
                            <input type="text" name="price" id="price" class="form-control" placeholder="Enter product price" >
                        </td>
                    </tr>

                    <tr>
                        <td>Photo</td>
                        <td>
                            <input type="file" onchange="readandPreview(this, 'image1')" id="photo" name="photo" /><br/>
                            <img src="" id="image1" height="80" width="100" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>

                            <input name="btnadd" type="button" onclick="manageproducts()" class="btn btn-primary btn-block" value="Add Product" /> <br/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>


    <div class="row">
        <div class="col-md-12">
            <h2 class="text-center text-success">View products</h2>
            <div id="divproducts">

            </div>
        </div>
    </div>
    <div id="editproductmodal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Edit product</h3>
                    <button type="button" class="close" data-dismiss="modal">X</button>
                </div>
                <div class="modal-body">
                    <form  id="form2" method="POST" enctype="multipart/form-data">
                        <table class="table table-bordered">
                            <tr>
                                <td>Category Name</td>
                                <td>
                                    <select name="products" id="editcategoryname">
                                        <option value="Clothes">Clothes</option>
                                        <option value="Footwear">Footwear</option>
                                        <option value="Accessories">Accessories</option>
                                        <option value="Elecronics">Electronics</option>

                                    </select>


                                </td>
                            </tr>
                            <tr>
                            <tr>
                                <td>Product name</td>
                                <td>
                                    <input type="text" name="editproductname" id="editproductname" class="form-control" placeholder="Enter product name" >
                                </td>
                            </tr>
                            <td>Product Description</td>
                            <td>
                                <input type="textarea" name="editproductdesc" id="editproductdesc" class="form-control" placeholder="Enter product description" ></textarea>
                            </td>
                            </tr>
                            <tr>
                                <td>Price</td>
                                <td>
                                    <input type="text" name="editprice" id="editprice" class="form-control" placeholder="Enter product price" ></input>
                                </td>
                            </tr>

                            <tr>
                                <td>Photo</td>
                                <td>
                                    <input type="file" onchange="readandPreview(this, 'editimage1')" id="editproductphoto" name="editproductphoto" /><br/>
                                    <img src="" id="editimage1" height="80" width="100" />
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <input type="hidden" id="pid" name="pid"/>
                                    <input type="button" name="btnedit" onclick="editcategory()" value="Edit details" class="btn btn-primary" />

                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-danger" data-dismiss="modal" >Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
