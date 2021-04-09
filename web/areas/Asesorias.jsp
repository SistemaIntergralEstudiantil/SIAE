<%-- 
    Document   : Asesorias
    Created on : 8/04/2021, 06:42:43 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.modelo.beans.ReporteAsesoria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Asesorias</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Asesorias.css"/>
    </head>
    <body>
        <%
            
            HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            if(sec == null){
                sec = new Session();
                sec.setErrorMsj("No a iniciado sesión");
                sec.setErrorType("Cuenta no encontrada");
                sec.setErrorUrl("/SIAE/Login.jsp");
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher("/error/error.jsp").forward(request, response);   
            }
        %>
        <header>
            <nav>
                <ul class="content">
                    <li><h1 class="content-item" >Asesorías</h1></li>                    
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
                            <th style="width: 6rem;">Docente</th>
                            <th style="width: 14rem;">Asignatura</th>
                            <th style="width: 2rem;">Dia</th>
                            <th style="width: 10rem;">Horario</th>
                            <th style="width: 6rem;">URL</th>
                            <th style="width: 6rem;">Código</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" >
                        <%
                            if(sec != null){
                                ArrayList<ReporteAsesoria> l = (ArrayList<ReporteAsesoria>) request.getAttribute("lista");
                                for(ReporteAsesoria r : l){
                        %>
                        <tr >
                            <th><%=r.getDocente() %></th>
                            <th><%=(r.getAsignatura()==null)?"No espesificado":r.getAsignatura() %></th>
                            <th><%=r.getDia() %></th>
                            <th><%=r.getHorario() %></th>
                            <th><%=r.getUrl() %></th>
                            <th><%=r.getCodigo() %></th>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
        </div>
    </body>
</html>
