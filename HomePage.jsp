<%-- 
    Document   : HomePage
    Created on : 6 Jan, 2020, 11:39:02 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="UserHeader.jsp" %>
<script>
            
//            function changepassword(){
//                window.location.href="ChangePassword.jsp";
//            }
        </script>
        <h1>Welcome <%=session.getAttribute("name").toString()%></h1>       
        
<!--           <div class="form-group form-row">
           <div class="col-md-2">-->
                   <!--<input type="button" class="btn btn-primary btn-block" value="Change Password" onclick="changepassword()"/>-->
<!--                    </div>
                    </div>
       -->
        <%@include file="footer.jsp" %>