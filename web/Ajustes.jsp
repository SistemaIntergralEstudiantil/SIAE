<%-- 
    Document   : Ajustes
    Created on : 7/04/2021, 08:13:44 PM
    Author     : danielhernandezreyes
--%>

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
    <body>
        <%  HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            if (sec == null) {
                sec = new Session();
                sec.setTypeSessionNull(1);
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher("/error/error.jsp").forward(request, response);
            }%>
        <header>
            <nav>
                <ul class="content-G content">
                    <li><h1 class="content-item-G content-item" >Configuración del perfil del usuario</h1></li>                    
                    <li><img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/></li>
                </ul>
            </nav>
        </header>
          <div class = "profile-pic-div">
              <img src="resource/images/profile_pic.jpg" id="foto"/>
        <input type="file" id="file">
        <b><label for ="file" id="subirFoto">Seleccionar foto de perfil</b></label></div>
        <abbr title="Seleccione el ícono del avatar para modificar su foto de perfil">
            
            <img src="/SIAE/resource/images/help.png" width="40" height="40" style="float: right"/>  
        </abbr>
         <a class="item-G-A-Selec content-a" href="session/Home.jsp">Menú principal</a>
        <script src="/SIAE/resource/js/Script-ProfilePic.js"></script>
    </body>
</html>

