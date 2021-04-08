<%-- 
    Document   : error
    Created on : 22/03/2021, 10:51:06 PM
    Author     : sandr
--%>

<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
        %>
        <header class="content-header"></header>
        <center>
            <h1>¡Error en el sistema!</h1>
            <h2>Descripción:</h2>
            <p>
                <%= sec.getErrorMsj() %>
            </p>
            <p>
                <%= sec.getErrorType()%>
            </p>
            <%
                sec.setErrorType(null);
                sec.setErrorMsj(null);
            %>
            <a class="content-link" href="<%= sec.getErrorUrl() %>" >Regresar</a>
            <% sec.setErrorUrl(null); %>
        </center>
        <footer class="content-footer"></footer>
    </body>
</html>
