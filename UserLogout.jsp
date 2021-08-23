<%-- 
    Document   : UserLogout
    Created on : 18 Jan, 2020, 12:32:42 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.setAttribute("emailid",null);
%>

<script>
window.location.href="Customerlogin.jsp";
</script>