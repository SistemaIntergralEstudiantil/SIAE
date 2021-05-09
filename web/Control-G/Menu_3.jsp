<%-- 
    Document   : Menu_3
    Created on : 7/05/2021, 06:03:18 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.conector.config.Url"%>
<%@page import="mx.com.siae.modelo.beans.ReporteAlumno"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Menu de control carga academica</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Control-Alta.css"/>
    </head>
    <body>
    <%  HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            if(sec == null){
                sec = new Session();
                sec.setTypeSessionNull(1);
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher("/error/error.jsp").forward(request, response); } %>
    <header>
    <nav>
    <ul class="content-G content">
        <li><a class="content-item-G content-item selec-none " href="#dia"></a></li>
        <li><a class="content-item-G content-item selec-none info" href="#dia">Control carga Academica</a></li>
        <li><img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80"/></li>
    </ul>
    </nav>
    </header>
    <div class="description-p"><p>Aquí tendrás la oportunidad de aceptar y/o rechazar las altas y bajas de materias</p></div>
    <div class="content-table" >
    <table class="table">
    <caption class="description-p" >Lista de las asignaturas de alumnos para altas</caption>
    <thead>
        <tr>
        <th style="width: 1rem;">Curso</th>
        <th style="width: 1rem;">Tipo</th>
        <th style="width: 1rem;">Clave asignatura</th>
        <th style="width: 10rem;">Asignatura</th>
        <th style="width: 1rem;">Créditos</th>
        <th style="width: 1rem;">Matricula</th>
        <th style="width: 10rem;">Alumno</th>
        <th style="width: 2.5rem;">Aceptar</th>
        <th style="width: 2.5rem;">Rechazar</th>
        </tr>
    </thead>
    <tbody>
        <%  if(sec != null) {
                ArrayList<ReporteAlumno> l = (ArrayList<ReporteAlumno>) request.getAttribute("lista-a");
                for(ReporteAlumno s : l) { %>
        <tr><th><%=s.getIdCurso() %></th>
            <th><%=s.getTipo().equals("O")?"Ordinario":"Verano" %></th>
            <th><%=s.getIdAsignatura() %></th>
            <th><%=s.getAsignatura()%></th>
            <th><%=s.getCredito() %></th>
            <th><%=s.getMatricula() %></th>
            <th><%=s.getAlumno() %></th>
            <th><form action="ControlAltaBaja" method="POST" >
                <input type="hidden" name="clave" value="registro-a">
                <input type="hidden" name="idCurso" value="<%=s.getIdCurso()%>">
                <input type="hidden" name="matricula" value="<%=s.getMatricula()%>">
                <input type="hidden" name="estado" value="A">
                <input class="input-submit-table input-T-E" type="submit" value="Alta">
                </form></th>
            <th><form action="ControlAltaBaja" method="POST" >
                <input type="hidden" name="clave" value="registro-a">
                <input type="hidden" name="idCurso" value="<%=s.getIdCurso()%>">
                <input type="hidden" name="matricula" value="<%=s.getMatricula()%>">
                <input type="hidden" name="estado" value="R">
                <input class="input-submit-table input-T-D" type="submit" value="Rechazar">
                </form></th>
        </tr><% } } %>
    </tbody>
    </table>
    </div>
    <div class="content-table" >
    <table class="table">
    <caption class="description-p" >Lista de las asignaturas de alumnos para bajas</caption>
    <thead>
        <tr>
        <th style="width: 1rem;">Curso</th>
        <th style="width: 1rem;">Tipo</th>
        <th style="width: 1rem;">Clave asignatura</th>
        <th style="width: 10rem;">Asignatura</th>
        <th style="width: 1rem;">Créditos</th>
        <th style="width: 1rem;">Matricula</th>
        <th style="width: 10rem;">Alumno</th>
        <th style="width: 2.5rem;">Aceptar</th>
        <th style="width: 2.5rem;">Rechazar</th>
        </tr>
    </thead>
    <tbody>
    <%  if(sec != null) {
                ArrayList<ReporteAlumno> l = (ArrayList<ReporteAlumno>) request.getAttribute("lista-b");
                for(ReporteAlumno s : l) { %>
        <tr><th><%=s.getIdCurso() %></th>
            <th><%=s.getTipo().equals("O")?"Ordinario":"Verano" %></th>
            <th><%=s.getIdAsignatura() %></th>
            <th><%=s.getAsignatura()%></th>
            <th><%=s.getCredito() %></th>
            <th><%=s.getMatricula() %></th>
            <th><%=s.getAlumno() %></th>
            <th><form action="ControlAltaBaja" method="POST" >
                <input type="hidden" name="clave" value="registro-b">
                <input type="hidden" name="idCurso" value="<%=s.getIdCurso()%>">
                <input type="hidden" name="matricula" value="<%=s.getMatricula()%>">
                <input type="hidden" name="estado" value="A">
                <input class="input-submit-table input-T-E" type="submit" value="Baja">
                </form></th>
            <th><form action="ControlAltaBaja" method="POST" >
                <input type="hidden" name="clave" value="registro-b">
                <input type="hidden" name="idCurso" value="<%=s.getIdCurso()%>">
                <input type="hidden" name="matricula" value="<%=s.getMatricula()%>">
                <input type="hidden" name="estado" value="R">
                <input class="input-submit-table input-T-D" type="submit" value="Rechazar">
                </form></th>
        </tr><% } } %>
    </tbody>
    </table>
    <form method="POST" action="ControlAltaBaja">
        <input type="hidden" name="clave" value="consultar">
        <input class="input-submit input-submit-ft" type="submit" value="Actualizar datos">
    </form>
    </div>
    <form method="POST" action="ControlAltaBaja">
        <input type="hidden" name="clave" value="verano">
        <%String l = (String) request.getAttribute("status-v");%>
        <input type="hidden" name="status-v" value="<%=l.equals("A")?"D":"A"%>">
        <input class="input-submit input-submit-f" type="submit" value="<%=l.equals("A")?"Desabilitar":"Habilitar"%> solicitudes de verano">
    </form>
    <form method="POST" action="ReporteAsignatura">
        <input type="hidden" name="clave" value="verano">
        <input class="input-submit input-submit-f" type="submit" value="Reporte de solicitudes de verano">
    </form>
    <div class="content-data_row" >
            <a class="item-G-A-Selec content-a" href="<%=Url.URL_HOME%>">Ménu principal</a></div>
    </body>
</html>
