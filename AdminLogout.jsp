<%-- 
    Document   : AdminLogout
    Created on : 18 Jan, 2020, 12:37:14 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.setAttribute("username",null);
%>

<script>
window.location.href="Admin.jsp";
</script>