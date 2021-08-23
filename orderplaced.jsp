<%-- 
    Document   : orderplaced
    Created on : 11 Jan, 2020, 12:18:07 PM
    Author     : Dell
--%>


<%@page import="VMM.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="VMM.DBLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="UserHeader.jsp" %>
<%

    String emailid = request.getParameter("emailid");
    String status = request.getParameter("status");
    int tprice = Integer.parseInt(request.getParameter("tprice").trim());

    System.out.println("in orderplaced");
    if (session.getAttribute("status") != null) {
        if (session.getAttribute("status").toString().equals("paid")) {
            try {
                ResultSet rs = DBLoader.executeStatment("select * from ordertable");
                if (session.getAttribute("cartlist") != null) {
                    rs.moveToInsertRow();
                    rs.updateInt("totalamt", tprice);
                    rs.updateString("emailid", emailid);
                    rs.updateString("status", status);
                    rs.insertRow();
                    System.out.println("inserted 1");
                }
                ResultSet rs2 = DBLoader.executeStatment("select MAX(orderid) As maxid from ordertable");
                if (rs2.next()) {
                    int maxid = rs2.getInt("maxid");
                    if (session.getAttribute("cartlist") != null) {
                        ArrayList<Product> al = (ArrayList<Product>) session.getAttribute("cartlist");
                        ResultSet rs3 = DBLoader.executeStatment("select * from orderdetails");

                        for (int i = 0; i < al.size(); i++) {
                            rs3.moveToInsertRow();
                            rs3.updateInt("orderid", maxid);
                            rs3.updateString("pname", al.get(i).pname);
                            rs3.updateInt("price", al.get(i).price);
                            rs3.updateInt("qty", al.get(i).quantity);
                            rs3.updateInt("totalprice", al.get(i).quantity * al.get(i).price);
                            rs3.updateInt("pid", al.get(i).pid);

                            rs3.insertRow();
                            System.out.println("inserted 2");

                        }
                        session.setAttribute("cartlist", null);
                        session.setAttribute("status", "pay");
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

        }
    }
%>
<h1>Order Placed Successfully !</h1>
<%@include file="Signupfooter.jsp" %>