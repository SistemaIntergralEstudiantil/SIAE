<%-- 
    Document   : menu
    Created on : 22/03/2021, 07:13:25 PM
    Author     : sandr
--%>

<%@page import="mx.com.siae.modelo.beans.Usuarios"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Home</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Home.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-inicio.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/style.css"/>
        <link rel="stylesheet" href="/SIAE/resource/fonts"/>
        <script src="https://kit.fontawesome.com/1703782d49.js" crossorigin="anonymous"></script>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            Usuarios user = null;
            if(sec == null){
                sec = new Session();
                sec.setTypeSessionNull(1);
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher("../error/error.jsp").forward(request, response);   
            }else 
                user = sec.getUser();
        %>
        <header>
            <nav>
                <ul class="content-G content">
                    <li><a class="content-item-G content-item" href="/SIAE/ReporteAsignatura">Asignaturas</a></li>                    
                    <li><a class="content-item-G content-item" href="/SIAE/areas/Menu.jsp">Áreas de apoyo</a></li>
                    <li><a class="content-item-G content-item" href="">Curso de verano</a></li>
                    <li><a class="content-item-G content-item" href="/SIAE/curricula/Menu.jsp">Curricula</a></li>
                    <li><a class="content-item-G content-item" href="">Altas y bajas</a></li>
                    <li><a class="content-item-G content-item" href="/GestionBiblioteca/TempControlServicio?cl=re">Ajustes</a></li>
                </ul>
            </nav>
        </header>
        <h1 class="title-header" >Mis datos generales</h1>
        <dl class="content-data" >
            <div class="content-data_row" >
                <dt class="data_dt data_d" >Rol:</dt>
                <dd class="data_dd data_d" ><%=(user== null)?"":user.getRol().equals("A")?"Alumno":"Representante" %></dd>
            </div>
            <div class="content-data_row" >
                <dt class="data_dt data_d" >Correo:</dt>
                <dd class="data_dd data_d" ><%=(user== null)?"":user.getCorreo_inst() %></dd>
            </div>
            <div class="content-data_row" >
                <dt class="data_dt data_d" >Usuario:</dt>
                <dd class="data_dd data_d" ><%=(user== null)?"":user.getIdUsuario() %></dd>
            </div>
            <div class="content-data_row" >
                <dt class="data_dt data_d" >Nombre:</dt>
                <dd class="data_dd data_d" ><%=(user== null)?"":user.getNombreCompleto() %></dd>
            </div>
            <div class="content-data_row" >
                <dt class="data_dt data_d" >Semestre:</dt>
                <dd class="data_dd data_d" ><%=(user== null)?"":user.toString() %></dd>
            </div>
        </dl>
        <form action="/SIAE/Login" method="POST">
            <input type="hidden" name="clave" value="exit"/>
            <input class="input-submit" type="submit" value="Cerrar sesión">
        </form>
            <div class="social">
		<ul>
			<li><a href="https://www.facebook.com/ING-Sistemas-Computacionales-ITSOEH-916964301664810/" target="_blank"  class="fab fa-facebook"></a></li>
			<li><a href="https://twitter.com/RolandoPorrasM?s=08" target="_blank"  class="fab fa-twitter" ></a></li>
			<li><a href="http://www.itsoeh.edu.mx/" target="_blank"   class="fas fa-globe"  ></a></li>
			<li><a href="http://conect.itsoeh.edu.mx/mix_21_alu" target="_blank"  class="fas fa-laptop-house"></a></li>
			
		</ul>
	</div>
    </body>
</html>
