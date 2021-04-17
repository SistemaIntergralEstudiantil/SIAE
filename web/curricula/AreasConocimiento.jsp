<%-- 
    Document   : AreasConocimiento
    Created on : 8/04/2021, 11:10:57 PM
    Author     : danielhernandezreyes
--%>
<%@page import="mx.com.siae.modelo.beans.ReporteAsig"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.beans.Asignatura"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Áreas de conocimiento curricular</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-AreasConocimiento.css"/>
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
                <ul class="content">
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
                    <li>
                        <select class="content-selec" id="area">
                            <option value="0" disabled selected>Áreas existentes ...</option>
                            <option value="CB">Ciencias Básicas</option> 
                            <option value="CI">Ciencias de la Ingeniería</option>
                            <option value="DI">Diseño en Ingeniería</option>
                            <option value="CS">Ciencias Sociales y Humanidades</option> 
                            <option value="CC">Cursos Complementarios</option>
                            <option value="CE">Ciencias Económico Administrativas</option>
                            <option value="AL">Todas</option>
                        </select>
                    </li>
                    <li><h1 class="content-item" >Áreas de conocimiento curricular</h1></li>                    
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
                            <th style="width: 1rem;">Clave</th>
                            <th style="width: 1rem;">Semestre</th>
                            <th style="width: 1rem;">Asignatura</th>
                            <th style="width: 1rem;">Creditos</th>
                            <th style="width: 6rem;">Temario</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" >
                        <% 
                            if(sec != null) {
                                ArrayList<Asignatura> l = (ArrayList<Asignatura>) request.getAttribute("lista");
                                for(Asignatura a : l){
                        %>
                        <tr class="<%=a.getArea() %> <%=a.getSemestre() %>" >
                            <th><%=a.getIdAsignatura() %></th>
                            <th><%=a.getSemestre() %></th>
                            <th><%=a.getNombre() %></th>
                            <th><%=a.getCredito() %></th>
                            <th><a href="/SIAE/resource/pdf/<%=a.getIdAsignatura() %>.pdf" target="_blank">PDF</a></th>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
        </div>
                    <script src="/SIAE/resource/js/Script-Asignaturas.js"></script>
    </body>
</html>
