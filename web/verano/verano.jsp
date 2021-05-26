<%-- 
    Document   : verano
    Created on : 8/05/2021, 12:32:47 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.modelo.Session"%>
<%@page import="mx.com.siae.modelo.beans.Asignatura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.conector.config.Url"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Verano</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Verano.css"/>
    </head>
    <body>
    <%  HttpSession sesion = request.getSession();
        Session sec = (Session) sesion.getAttribute("user");
        if(sec == null){
            sec = new Session();
            sec.setTypeSessionNull(1);
            sesion.setAttribute("user", sec);
            request.getRequestDispatcher(Url.URL_ERROR).forward(request, response);   
        }
    %>
    <header>
    <nav>
    <ul class="content-G content">
        <li><a class="content-item-G content-item selec-none " href="#dia"></a></li>
        <li><a class="content-item-G content-item selec-none info" href="#dia">Solicitud de verano</a></li>
        <li><img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80"/></li>
    </ul>
    </nav>
    </header>
    <div class="description-p"><p>Aquí tendrás la oportunidad de solicitar dos materias para el curso de verano</p></div>
    <form>
    <div class="item-option" ><label>Asignatura 1: <select class="item-selec" name="idAsignatura_1">
            <option value="0" disabled selected>Seleccionar ...</option>
    <%  if(sec!=null) {
            ArrayList<Asignatura> la = (ArrayList<Asignatura>) request.getAttribute("lista");
            for(Asignatura a : la) { %> 
                <option value="<%=a.getIdAsignatura() %>"><%=a.getNombre() %></option> 
    <% } } %></select></label>
    </div>
    <div class="item-option" ><label>Asignatura 2: <select class="item-selec" name="idAsignatura_2">
            <option value="0" disabled selected>Seleccionar ...</option>
    <%  if(sec!=null) {
            ArrayList<Asignatura> la = (ArrayList<Asignatura>) request.getAttribute("lista");
            for(Asignatura a : la) { %> 
                <option value="<%=a.getIdAsignatura() %>"><%=a.getNombre() %></option> 
    <% } } %></select></label>
    </div>
    <input type="hidden" name="clave" value="registrar">
    
    <input class="input-submit" type="submit" value="Solicitar">
    </form>
    <div class="content-data_row" >
        <a class="item-G-A-Selec content-a" href="<%=Url.URL_HOME%>">Ménu principal</a></div>
    </body>
</html>
