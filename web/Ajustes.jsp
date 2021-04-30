<%-- 
    Document   : Ajustes
    Created on : 7/04/2021, 08:13:44 PM
    Author     : danielhernandezreyes
--%>

<%@page import="mx.com.siae.modelo.beans.Usuarios"%>
<%@page import="java.util.Base64"%>
<%@page import="mx.com.siae.conector.config.Url"%>
<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes modificar los datos que fueron ingresados, así como actualizar una foto de perfil en caso de que el alumno así lo requiera"/>
        <title>Ajustes</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        <link rel="stylesheet" href="/SIAE/resource/css/Style-Ajustes.css"/>
    </head>
   
    <body style="background-image: url(/SIAE/resource/images/menuPrincipal.png);background-size: 100% 130%;background-repeat: no-repeat">

    
        <%  HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            Usuarios user = null;
            if (sec == null) {
                sec = new Session();
                sec.setTypeSessionNull(1);
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher(Url.URL_ERROR).forward(request, response);
            } else {
                user = sec.getUser(); }
            %>
        <header>
            <nav>
                <ul class="content-G content">
                    <li><h1 class="content-item-G content-item" >Configuración del perfil del usuario</h1></li>                    
                    <li><img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/></li>
                </ul>
            </nav>
        </header>
        <form action="CambiarDatos" method="POST" enctype="multipart/form-data" >
            <div class = "profile-pic-div">
                <% if(user != null) { 
                    if(user.aFoto != null) { %>
                <img src="data:image/png;base64,<%= Base64.getEncoder().encodeToString(user.aFoto)%>" id="foto"/>
                <% } else { %><img src="../resource/images/ISIC-Circulo.png" id="foto"/><% } }%>
                <input name="foto" type="file" id="file" required />
                <label for ="file" id="subirFoto">Seleccionar foto de perfil</label>
            </div>
            <abbr title="Seleccione el ícono del avatar para modificar su foto de perfil">
                <img src="/SIAE/resource/images/help.png" width="40" height="40" style="float: right"/>  
            </abbr>
        </form>
                <form>
                <dl class="content-data" >
                    <strong><div class="content-data_row"><dt class="data_dt data_d" >Usuario:</dt></div></strong>
                    <strong><div class="content-data_row"><dt class="data_dt data_d" >Contraseña actual:     <input type="password" name="contra" required /></dt></div></strong>
                    <strong><div class="content-data_row"><dt class="data_dt data_d" >Contraseña nueva:     <input type="password" name="nuevaContra"  /></dt></div></strong>
                    <strong><div class="content-data_row"><dt class="data_dt data_d" >Confirmar contraseña:     <input type="password" name="ConfirmarContra" /></dt></div></strong>
            
                    <div class="content-data_row"><dt><input type="hidden" name="clave" value="change"/></dt></div>
                    <div class="content-data_row"><dt><input type="password" name="contra" required /></dt></div>
                    <div class="content-data_row"><dt><input type="submit" id= "btnSubmit" value="Modificar"/></dt></div>
            
            
                </dl>
         <a class="item-G-A-Selec content-a" href="session/Home.jsp">Menú principal</a>
        <script src="/SIAE/resource/js/Script-ProfilePic.js"></script>
    </body>
</html>

