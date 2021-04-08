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
        <link rel="shortcut icon" href="resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="../resource/css/Style-Home.css"/>
        <link rel="stylesheet" href="../resource/css/Style-General.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Home</title>
    </head>
    <body>
        <%
            //HttpSession sesion = request.getSession();
            //Session sec = (Session) sesion.getAttribute("user");
            //Usuario user = sec.getUser();
        %>
        <header>
            <nav>
                <ul class="content">
                    <li><a class="content-item" href="../Asignaturas.jsp">Asignaturas</a></li>                    
                    <li><a class="content-item" href="../areas/Menu.jsp">Áreas de apoyo</a></li>
                    <li><a class="content-item" href="../visit/changeVisit.jsp">Curso de verano</a></li>
                    <li><a class="content-item" href="../service/service.jsp">Curricula</a></li>
                    <li><a class="content-item" href="../career/career.jsp">Altas y bajas</a></li>
                    <li><a class="content-item" href="/GestionBiblioteca/TempControlServicio?cl=re">Ajustes</a></li>
                </ul>
            </nav>
        </header>
        <h1 class="title-header" >Mis datos generales</h1>
    </body>
</html>
