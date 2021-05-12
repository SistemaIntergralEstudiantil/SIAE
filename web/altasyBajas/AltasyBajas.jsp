<%-- 
    Document   : AltasyBajas
    Created on : 18/04/2021, 12:54:56 AM
    Author     : emeli
--%>

<%@page import="mx.com.siae.modelo.beans.ReporteCurso"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.conector.config.Url"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Altas y bajas de materias</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-AltasYbajas.css"/>
    </head>
    <body style="background-image: url(/SIAE/resource/images/Login.png);background-size: 100% 150%;">
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
            <li><h1 class="content-item-G content-item" >Altas y bajas de materias</h1></li>
            <li>
                <img class="content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/>
            </li>
        </ul>
        </nav>
        </header>
        <div class="description-p"><p>Aquí tendrás la oportunidad de solicitar tus altas y bajas de materias</p></div>
        <div class="content-table" >
        <form method="POST" action="ControlCargaAcademica">
            <table class="table">
            <caption class="description-p" >Lista de asignaturas disponibles para cargar</caption>
            <thead>
                <tr>
                <th style="width: 1.5rem;">Solicitar</th>
                <th style="width: 4rem;">Id del curso</th>
                <th style="width: 4rem;">Tipo</th>
                <th style="width: 4rem;">Clave asignatura</th>
                <th style="width: 1.5rem;">Semestre</th>
                <th style="width: 10rem;">Asignatura</th>
                <th style="width: 1.5rem;">Créditos</th>
                <th style="width: 2.5rem;">Cupo</th>
                </tr>
            </thead>
            <tbody>
                <%  int i = 0;
                    if(sec!=null) {
                    ArrayList<ReporteCurso> l = (ArrayList<ReporteCurso>) request.getAttribute("lista-rca");
                    for(ReporteCurso rc : l) {
                %>
                <tr>
                <th><input type="checkbox" name="Asig_<%=i%>" value="<%=rc.getIdCurso()+","+rc.getAsignatura()%>" ></th>
                <th><%=rc.getIdCurso()%></th>
                <th><%=rc.getTipo().equals("O")?"Ordinario":"Verano"%></th>
                <th><%=rc.getIdAsignatura()%></th>
                <th><%=rc.getSemestre()%></th>
                <th><%=rc.getAsignatura()%></th>
                <th><%=rc.getCredito()%></th>
                <th><%=rc.getCupo()%></th>
                </tr> <% i++; } } %>
            </tbody>
            </table>
            <input type="hidden" name="clave" value="alta">
            <input type="hidden" name="size" value="<%=String.valueOf(i)%>">
            <input class="input-submit" type="submit" value="Enviar solicitud de alta">
        </form>
        </div>
        <div class="content-table" >
        <form method="POST" action="ControlCargaAcademica">
        <table class="table" >
        <caption class="description-p" >Lista de las asignaturas que han sido cargadas</caption>
        <thead>
            <tr>
            <th style="width: 1.5rem;">Baja</th>
            <th style="width: 4rem;">Id del curso</th>
            <th style="width: 4rem;">Tipo</th>
            <th style="width: 4rem;">Clave asignatura</th>
            <th style="width: 1.5rem;">Semestre</th>
            <th style="width: 10rem;">Asignatura</th>
            <th style="width: 1.5rem;">Créditos</th>
            <th style="width: 2.5rem;">Cupo</th>
            </tr>
        </thead>
        <tbody>
            <% if(sec!=null) { 
                    ArrayList<ReporteCurso> l = (ArrayList<ReporteCurso>) request.getAttribute("lista-rcb");
                    i = 0;
                    for(ReporteCurso rc : l) {
                %>
                <tr>
                <th><input type="checkbox" name="Asig_<%=i%>" value="<%=rc.getIdCurso()+","+rc.getAsignatura()%>" ></th>
                <th><%=rc.getIdCurso()%></th>
                <th><%=rc.getTipo().equals("O")?"Ordinario":"Verano"%></th>
                <th><%=rc.getIdAsignatura()%></th>
                <th><%=rc.getSemestre()%></th>
                <th><%=rc.getAsignatura()%></th>
                <th><%=rc.getCredito()%></th>
                <th><%=rc.getCupo()%></th>
                </tr> <% i++; } } %>
        </tbody>
        </table>
        <input type="hidden" name="clave" value="baja">
        <input type="hidden" name="size" value="<%=String.valueOf(i)%>">
        <input class="input-submit" type="submit" value="Enviar solicitud de baja">
        </form>
        </div>
        <div class="content-data_row" >
            <a class="item-G-A-Selec content-a" href="ControlCargaAcademica?clave=seg-ac">Avance de curricula</a></div>
        <div class="content-data_row" >
            <a class="item-G-A-Selec content-a" href="<%=Url.URL_HOME%>">Ménu principal</a></div>
    </body>
</html>
