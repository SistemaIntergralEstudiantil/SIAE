<%-- 
    Document   : Asignaturas
    Created on : 7/04/2021, 08:09:27 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.modelo.beans.ReporteAsig"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.beans.Usuarios"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Asignaturas</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Asignatura.css"/>
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
                    <li>
                        <select class="item-G-A-Selec content-selec" id="semestre">
                            <option value="0" disabled selected>Semestre ...</option>
                            <option value="1">Primero</option> 
                            <option value="2">Segundo</option>
                            <option value="3">Tercero</option>
                            <option value="4">Cuarto</option> 
                            <option value="5">Quinto</option>
                            <option value="6">Sexto</option>
                            <option value="7">Septimo</option> 
                            <option value="8">Octavo</option>
                            <option value="9">Noveno</option>
                            <option value="10">Todos</option>
                        </select>
                    </li>
                    <li><h1 class="content-item-G content-item" >Asignaturas</h1></li>                    
                    <li>
                        <img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/>
                    </li>
                </ul>
            </nav>
        </header>
        <div class="content-table" >
            <table class="table" >
                    <thead>
                        <tr>
                            <th style="width: 1rem;">Clave</th>
                            <th style="width: 1rem;">Cupo</th>
                            <th style="width: 1rem;">Dia</th>
                            <th style="width: 4rem;">Horario</th>
                            <th style="width: 10rem;">Asignatura</th>
                            <th style="width: 1rem;">Creditos</th>
                            <th style="width: 6rem;">Docente</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" >
                        <%
                            if(sec != null){
                                ArrayList<ReporteAsig> l = (ArrayList<ReporteAsig>) request.getAttribute("lista");
                                for(ReporteAsig r : l){
                        %>
                        <tr class="<%=r.getSemestre() %>" >
                            <th><%=r.getIdCurso() %></th>
                            <th><%=r.getCupo() %></th>
                            <th><%=r.getDia() %></th>
                            <th><%=r.getHorario() %></th>
                            <th><%=r.getAsignatura() %></th>
                            <th><%=r.getCredito() %></th>
                            <th><%=r.getDocente() %></th>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
        </div>
        <a class="item-G-A-Selec content-a" href="session/Home.jsp" >Menu principal</a>
        <script src="/SIAE/resource/js/Script-Asignaturas.js"></script>
    </body>
</html>
