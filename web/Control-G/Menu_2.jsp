<%-- 
    Document   : Menu_2
    Created on : 18/04/2021, 10:40:15 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.conector.config.Url"%>
<%@page import="mx.com.siae.modelo.beans.ReporteAsesoria"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page import="mx.com.siae.modelo.beans.DocenteR"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.beans.Asignatura"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Menu de control asesorias</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Control.css"/>
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
                <li><a class="content-item-G content-item" href="/SIAE/Control?clave=course">Control Cursos</a></li>
                <li><a class="content-item-G content-item" href="/SIAE/CambiosCA?clave=asesor">Control Asesorias</a></li>
                <li><img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80"/></li>
            </ul>
        </nav>
        </header>
        <div class="content-center">
        <div class="content-left">
            <form action="CambiosCA" method="POST" onsubmit="return validarForm2();" >
                <div><label>URL: <input class="input-number" id="url" type="url" name="url" maxlength="200" /></label></div>
                <div><label>Dia: <select class="item-selec" id="dia" name="dia">
                    <option value="0" disabled selected>Dia ...</option>
                    <option value="Lunes">Lunes</option><option value="Martes">Martes</option><option value="Miercoles">Miercoles</option>
                    <option value="Lunes">Jueves</option><option value="Lunes">Viernes</option>
                </select></label>
                </div>
                <div><label>Hora inicio: <input class="input-number" type="time" name="hora_inicio" id="hora_inicio" min="07:00" max="21:00" value="08:00" ></label></div>
                <div><label>Hora fin: <input class="input-number" type="time" name="hora_fin" id="hora_fin" min="07:00" max="21:00" value="08:00" ></label></div>
                <div><label>Código: <input class="input-number" id="codigo" type="text" maxlength="100" name="codigo" /></label></div>
                <div class="item-option" ><label>Asignatura: <select class="item-selec" id="idAsignatura" name="idAsignatura">
                        <option value="0" disabled selected>Asignatura ...</option>
                <% if(sec != null) { 
                        ArrayList<Asignatura> la = (ArrayList<Asignatura>) request.getAttribute("lista-AA");
                        for(Asignatura a : la) { %> 
                        <option value="<%=a.getIdAsignatura() %>"><%=a.getNombre() %></option>
                <% } } %></select></label>
                </div>
                <div class="item-option" ><label>Docente: <select class="item-selec" id="idResponsable" name="idResponsable">
                        <option value="0" disabled selected>Docente ...</option>
                <% if(sec != null) {
                        ArrayList<DocenteR> ld = (ArrayList<DocenteR>) request.getAttribute("lista-DA");
                        for(DocenteR d : ld) { %>
                        <option value="<%=d.getIdUsuario() %>"><%=d.getNombre() %></option>
                <% } } %></select></label>
                </div>
                <div><input type="hidden" name="clave" value="add-A">
                    <input class="input-submit" id="add" type="submit" value="Agregar Asesoria" ></div>
            </form>
        </div>
        <div class="content-right content-table-dimanyc" >
            <table class="table" >
            <thead><tr>
                    <th style="width: 1rem;">Id Asesoria</th>
                    <th style="width: 1rem;">Asignatura</th>
                    <th style="width: 2rem;">URL</th>
                    <th style="width: 2rem;">Dia</th>
                    <th style="width: 6rem;">Horario</th>
                    <th style="width: 1rem;">Estado</th>
                    <th style="width: 10rem;">Docente</th>
                    <th style="width: 6rem;">Información</th>
                </tr>
            </thead>
            <tbody>
                <%  if(sec != null) {
                        ArrayList<ReporteAsesoria> l = (ArrayList<ReporteAsesoria>) request.getAttribute("lista-RA");
                        for(ReporteAsesoria r : l) { %><tr>
                    <th><%=r.getIdAsesoria() %></th>
                    <th><%=r.getAsignatura() %></th>
                    <th><a href="<%=r.getUrl() %>" target="_blank" style="text-decoration: none;" >Enlace</a></th>
                    <th><%=r.getDia() %></th>
                    <th><%=r.getHorario() %></th>
                    <th><form action="CambiosCA" method="POST" >
                        <input type="hidden" name="clave" value="change-A">
                        <input type="hidden" name="idAsesoria" value="<%=r.getIdAsesoria() %>">
                        <input type="hidden" name="estado" value="<%=r.getEstado() %>">
                        <input class="input-submit-table <%=(r.getEstado().equals("E"))?"input-T-E":"input-T-D" %> " type="submit" value="<%=(r.getEstado().equals("E"))?"Disable":"Enable" %>">
                        </form></th>
                    <th><%=r.getDocente() %></th>
                    <th><%=r.getCodigo() %></th></tr><% } } %>
            </tbody>
            </table>
        </div>
        </div>
        <footer class="footer">
        <nav>
            <ul class="content-footer">
                <li><a class="item-footer" href="<%=Url.URL_HOME%>">Menu principal</a></li>
                <li><%String mensaje = (String) request.getAttribute("msj");%>
                    <label class="item-mensaje"><%=(mensaje==null)?"-":mensaje %></label>
                </li>
            </ul>
        </nav>
        </footer>
        <script src="/SIAE/resource/js/Script-Control.js"></script>
    </body>
</html>
