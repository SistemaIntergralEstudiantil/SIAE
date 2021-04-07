<%-- 
    Document   : menu
    Created on : 22/03/2021, 07:13:25 PM
    Author     : sandr
--%>

<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="shortcut icon" href="images/logo_SIAE.png" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Home</title>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            Usuario user = sec.getUser();
        %>
        <h1 style="color: tomato; animation-direction: alternate">Aqui se encontrara el menu</h1>
    </body>
</html>
