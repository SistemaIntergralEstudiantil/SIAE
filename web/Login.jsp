<%-- 
    Document   : Login
    Created on : 22/03/2021, 12:11:40 PM
    Author     : sandr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" >
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Login </title>
        <link rel="shortcut icon" href="resource/images/logo_SIAE.png" />
        <!--<link rel="stylesheet" href="resource/css/Style-General.css"/>-->
        <link rel="stylesheet" href="resource/css/Style-Login.css"/>
    </head>
    <body style="background-image: url(/SIAE/resource/images/Login.png);background-size: 100% 150%;">
        <table width="100%">
            <tr>
                <td align="center" width="33%"><img src="resource/images/Logo-TecNM.png" height="80" width="180"></td>
                <td align="center" width="33%"><img src="resource/images/logo_tec.png" height="100" width="190"></td>
                <td align="center" width="33%"><img src="resource/images/logo_ISIC.png" height="80" width="150"></td>
            </tr>
        </table>
        <p align="center"><img src="resource/images/logo_SIAE.png" height="180" width="180"></p>
        <div class="content-form">
            <center>
                <form action="Login" method="POST">
                    <div>
                        <label for="user" class="lbl-user">Matricula o Número de control</label>
                        <input id="user" type="text" name="idUsuario"/>
                    </div><br>
                    <div>
                        <label for="pass" class="lbl-pass">Introduce tu contraseña</label>
                        <input  id="pass" type="password" name="contra" />
                    </div><br>
                    <div>
                        <input type="hidden" name="clave" value="log"/>
                        <input type="submit" value="Ingresar">
                    </div>
                </form>
            </center>
        </div>
        <a href="session/Home.jsp">Home</a>
        <a href="areas/Menu.jsp">Apoyo</a>
        <a href="areas/Asesorias.jsp">Asesorias</a>
        <a href="curricula/Menu.jsp">Curricula</a>
        <a href="areas/ServicioPsicologico.jsp">Servicio psicologico</a>
        <a href="Docente/Cursos.jsp">Docente</a>
        <a href="Control-G/Menu.jsp">Control</a>
        <a href="altasyBajas/AltasyBajas.jsp">Altas y Bajas de Materias</a>
        <a href="Control-G/Menu_3.jsp">Control Alta</a>
        <a href="verano/verano.jsp">Verano</a>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="resource/js/Script-Login.js"></script>
    </body>
</html>
