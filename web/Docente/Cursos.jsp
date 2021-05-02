<%-- 
    Document   : Cursos
    Created on : 17/04/2021, 04:33:28 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.conector.config.Url"%>
<%@page import="mx.com.siae.modelo.beans.AlumnoRepoD"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Concentrado</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-D-Cursos.css"/>
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
                    <li><h1 class="content-item-G content-item" >Concentrado de Alumnos</h1></li>
                    <li>
                        <img class="content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/>
                    </li>
                </ul>
            </nav>
        </header>
        <div class="content-table" >
            <table class="table" >
                <thead>
                    <tr>
                        <th style="width: 1rem;">Id Curso</th>
                        <th style="width: 1rem;">Tipo</th>
                        <th style="width: 2rem;">Matricula</th>
                        <th style="width: 3rem;">Alumno</th>
                        <th style="width: 1rem;">Id Asignatura</th>
                        <th style="width: 3rem;">Asignatura</th>
                        <th style="width: 1rem;">Semestre</th>
                        <th style="width: 2rem;">Status</th>
                    </tr>
                </thead>
                <tbody id="content-body" >
                    <%
                        if(sec != null) {
                            ArrayList<AlumnoRepoD> l = (ArrayList<AlumnoRepoD>) request.getAttribute("lista");
                            for(AlumnoRepoD r : l) {
                    %>
                    <tr class="<%=r.getSemestre() %>" onclick="clickBuscar ( this )" >
                        <th class="curso" rowspan="1" ><%=r.getIdCurso() %></th>
                        <th rowspan="1" ><%=r.getTipo()%></th>
                        <th class="matricula" rowspan="1" ><%=r.getMatricula() %></th>
                        <th class="nombre" rowspan="1" ><%=r.getAlumno() %></th>
                        <th rowspan="1" ><%=r.getIdAsignatura() %></th>
                        <th rowspan="1" ><%=r.getAsignatura() %></th>
                        <th rowspan="1" ><%=r.getSemestre() %></th>
                        <th class="reporte" rowspan="1" ><%=r.getReporte() %></th>
                    </tr>
                    <%   
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        <div class="content-table" >
            
            <form action="Docente" method="POST">
                <dl class="two">
                    <strong><dt>Matricula: </dt></strong>
                <dt id="sel_matricula" ></dt>
                </dl>
                <dl class="two">
                    <strong><dt>Nombre: </dt></strong>
                <dt id="sel_nombre" ></dt>
                </dl>
                <select class="item-G-A-Selec content-selec" id="status" name="status">
                    <option value="P" disabled selected>Sin registro</option>
                    <option value="R">Reprobado</option>
                    <option value="A">Aprobado</option>
                </select>
                <input type="hidden" id="sel_mat" name="matricula" value="">
                <input type="hidden" id="sel_cur" name="idCurso" value="">
                <input type="hidden" name="clave" value="change">
                <input class="input-submit" type="submit" value="Realizar actualización">
            </form>
        </div>
        <script src="/SIAE/resource/js/Script-Cursos.js"></script>
    </body>
</html>
