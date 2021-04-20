<%-- 
    Document   : Menu
    Created on : 17/04/2021, 10:04:53 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.modelo.beans.ReporteAsesoria"%>
<%@page import="mx.com.siae.modelo.beans.DocenteR"%>
<%@page import="mx.com.siae.modelo.beans.Asignatura"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.beans.ReporteCurso"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Menu de control cursos</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Control.css"/>
    </head>
    <body>
        <% HttpSession sesion = request.getSession();
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
                    <li><a class="content-item-G content-item" href="/SIAE/Control?clave=course">Control Cursos</a></li>
                    <li><a class="content-item-G content-item" href="/SIAE/CambiosCA?clave=asesor">Control Asesorias</a></li>
                    <li>
                        <img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80"/>
                    </li>
                </ul>
            </nav>
        </header>
        <div class="content-center">
        <div class="content-left">
            <form action="Control" method="POST" onsubmit="return validarForm();" >
                <div class="item-option" ><label>Id Curso: <input class="input-number" type="number" name="idCurso" value="1" id="idCurso" min="1"></label></div>
                <div class="item-option" ><label>Habilitado: <input id="estado" type="checkbox" name="estado" value="E" checked="checked" /></label></div>
                <div class="item-option" ><label>Curso de ordinal: <input id="ordinario" type="radio" name="tipo" value="O" checked="checked" /></label></div>
                <div class="item-option" ><label>Curso de verano: <input type="radio" name="tipo" value="V" /></label></div>
                <div class="item-option" ><label>Cupo de estudiantes: <input class="input-number" type="number" value="1" min="1" name="cupo" id="cupo" > </label></div>
                <div class="item-option" ><label>Asignatura: <select class="item-selec" id="asignatura" name="idAsignatura">
                        <option value="0" disabled selected>Asignatura ...</option>
                <%  if(sec != null) {
                        ArrayList<Asignatura> la = (ArrayList<Asignatura>) request.getAttribute("lista-A");
                        for(Asignatura a : la) { %> 
                            <option value="<%=a.getIdAsignatura() %>"><%=a.getNombre() %></option> 
                <% } } %></select></label>
                </div>
                <div class="item-option" ><label>Docente: <select class="item-selec" id="responsable" name="idResponsable">
                        <option value="0" disabled selected>Docente ...</option>
                <% if(sec != null) {
                        ArrayList<DocenteR> ld = (ArrayList<DocenteR>) request.getAttribute("lista-D");
                        for(DocenteR d : ld) { %> 
                            <option value="<%=d.getIdUsuario() %>"><%=d.getNombre() %></option> 
                <% } } %></select></label>
                </div>
                <div class="item-option" ><input type="hidden" name="clave" value="add">
                <input class="input-submit" id="add" type="submit" value="Agregar Curso"></div>
            </form>
        </div>
        <div class="content-right content-table-dimanyc" >
            <table class="table" >
            <thead>
                <tr>
                    <th style="width: 1rem;">Id Curso</th>
                    <th style="width: 1rem;">Tipo</th>
                    <th style="width: 1rem;">Estado</th>
                    <th style="width: 2rem;">Cupo</th>
                    <th style="width: 6rem;">Asignatura</th>
                    <th style="width: 6rem;">Docente</th>
                    <th style="width: 6rem;">Sesiones</th>
                </tr>
            </thead>
            <tbody>
                <%  if(sec != null) {
                        ArrayList<ReporteCurso> l = (ArrayList<ReporteCurso>) request.getAttribute("lista");
                        for(ReporteCurso r : l) { %>
                <tr><th><%=r.getIdCurso() %></th>
                    <th><%=r.getTipo() %></th>
                    <th><form action="Control" method="POST" >
                        <input type="hidden" name="clave" value="change-c">
                        <input type="hidden" name="idCurso" value="<%=r.getIdCurso()%>">
                        <input type="hidden" name="estado" value="<%=r.getEstado()%>">
                        <input type="submit" value="<%=(r.getEstado().equals("E"))?"Disable":"Enable" %>">
                        </form></th>
                    <th><%=r.getCupo() %></th>
                    <th><%=r.getAsignatura() %></th>
                    <th><%=r.getResponsable() %></th>
                    <th><form action="Control" method="POST" onsubmit="return <%=(r.getEstado().equals("E"))?true:false %>;" >
                        <input type="hidden" name="clave" value="session-c">
                        <input type="hidden" name="idCurso" value="<%=r.getIdCurso() %>">
                        <input type="hidden" name="responsable" value="<%=r.getResponsable() %>">
                        <input type="hidden" name="asignatura" value="<%=r.getAsignatura() %>">
                        <input type="submit" value="Sesiones">
                        </form></th>
                </tr><% } } %>
            </tbody>
            </table>
        </div>
        </div>
        <footer class="footer">
        <nav>
            <ul class="content-footer">
                <li><a class="item-footer" href="/SIAE/session/Home.jsp">Menu principal</a></li>
                <li><%String mensaje = (String) request.getAttribute("msj");%>
                    <label class="item-mensaje"><%=(mensaje==null)?"-":mensaje %></label>
                </li>
            </ul>
        </nav>
        </footer>
        <script src="/SIAE/resource/js/Script-Control.js"></script>
    </body>
</html>
