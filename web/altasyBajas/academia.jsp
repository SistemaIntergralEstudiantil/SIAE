<%-- 
    Document   : academia
    Created on : 9/05/2021, 12:53:23 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.modelo.beans.Asignatura"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page import="mx.com.siae.conector.config.Url"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Seguimiento</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Academia.css"/>
    </head>
    <body style="background-image: url(/SIAE/resource/images/Login.png);background-size: 100% 100%;">
    <%  HttpSession sesion = request.getSession();
        Session sec = (Session) sesion.getAttribute("user");
        if(sec == null){
            sec = new Session();
            sec.setTypeSessionNull(1);
            sesion.setAttribute("user", sec);
            request.getRequestDispatcher("/error/error.jsp").forward(request, response);   
        } %>
    <header>
    <nav>
    <ul class="content-G content">
        <li><h1 class="content-item-G content-item" >Seguimiento académico</h1></li>
        <li><img class="content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/></li>
    </ul>
    </nav>
    </header>
    <div class="container-body">
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Primer semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-1");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %><div class="item-body-item item-repro" >Complementaria</div>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Segundo semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-2");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %><div class="item-body-item item-repro" >Complementaria</div>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Tercer semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-3");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %><div class="item-body-item item-repro" >Complementaria</div>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Cuarto semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-4");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %><div class="item-body-item item-repro" >Complementaria</div>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Quinto semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-5");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %><div class="item-body-item item-repro" >Complementaria</div>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Sexto semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-6");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %><div class="item-body-item item-repro" >Complementaria</div>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Septimo semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-7");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Octavo semestre</div>
        <%  if(sec!=null) {
                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista-8");
            for(Asignatura a : l) {
        %>
        <div class="item-body-item <%=a.getEstado().equals("A")?"item-apro":a.getEstado().equals("R")?"item-repro":"item-nocur" %>" 
             ><%=a.getNombre() %><br><%=a.getIdAsignatura() %> | <%=a.getCredito() %></div>
        <% } } %><div class="item-body-item item-repro" >Servicio social</div>
    </div>
    <div class="item-body" >
        <div class="item-body-item item-body-item-t" >Noveno semestre</div>
        <div class="item-body-item item-repro" >Residencia profecional</div>
    </div>
    </div>
    <div class="content-data_row" >
        <a class="item-G-A-Selec content-a" href="<%=Url.URL_HOME%>">Ménu principal</a></div>
    </body>
</html>
