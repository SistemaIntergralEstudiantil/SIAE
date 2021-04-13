<%-- 
    Document   : menu
    Created on : 7/04/2021, 08:12:02 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.modelo.Session"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Áreas de apoyo</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-AreasApoyo.css"/>
    </head>
    <body>
        <%
            
            HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            if(sec == null){
                sec = new Session();
                sec.setTypeSessionNull(1);
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher("/error/error.jsp").forward(request, response);   
            }
        %>
        <header>
            <nav>
                <ul class="content-G content">
                    <li><h1 class="content-item-G content-item" >Areas de apoyo</h1></li>                    
                    <li>
                        <img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/>
                    </li>
                </ul>
            </nav>
        </header>
        <form action="/SIAE/Asesorias" method="POST" >
            <div class="content-data_row" >
                <select name="servicio" class="data_d">
                    <option value="" disabled selected>Áreas</option>
                    <option value="A">Asesorias</option> 
                    <option value="S">Servicio psicologico</option>
                </select>
            </div>
            <div class="content-data_row" >
                <input type="hidden" name="clave" value="menu">
                <input class="data_d input-submit" type="submit" value="Consultar">
            </div>
        </form>
    </body>
</html>
