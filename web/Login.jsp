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
        <link rel="stylesheet" href="resource/css/Style-General.css"/>
        <link rel="stylesheet" href="resource/css/Style-Login.css"/>
    </head>
    <body style="background-image: url(/SIAE/resource/images/Login.png);background-size: 100% 150%;">
        <p align="right">
            <table width="100%">
                <tr>
                    <td align="center" width="33%"> <img src="resource/images/Logo-TecNM.png" height="80" width="180"> </td>
                    <td align="center" width="33%"> <img src="resource/images/logo_tec.png" height="100" width="190" </td>
                    <td align="center" width="33%"> <img src="resource/images/logo_ISIC.png" height="80" width="150"> </td>
                </tr>
            </table>
        </p>
        <p align="center"> <img src="resource/images/logo_SIAE.png" height="180" width="180"> </p>
        <center>
            <form action="Login" method="POST" >
                <div  >
                    <label  for="user">Usuario:</label>
                    <input  id="user" type="text" name="idUsuario" placeholder="Matricula o Número de control"/>
                </div><br>
                <div  >
                    <label  for="pass">Contraseña:</label>
                    <input  id="pass" type="password" name="contra" placeholder="Introduce tu contraseña" />
                </div><br>
                <div  >
                    <select name="TIPO DE USUARIO">
                        <option value="1">Alumno</option> 
                        <option value="2">Administrador</option>
                    </select>
                </div><br>
                <div  >
                    <input type="hidden" name="clave" value="log"/>
                    <input type="submit" value="Ingresar">
                </div>
            </form>
            <br>
        </center>
        <a href="session/Home.jsp">Home</a>
        <a href="areas/Menu.jsp">Apoyo</a>
        <a href="areas/Asesorias.jsp">Asesorias</a>
        <a href="curricula/Menu.jsp">Curricula</a>
        <a href="areas/ServicioPsicologico.jsp">Servicio psicologico</a>
        <a href="Docente/Cursos.jsp">Docente</a>
        <a href="Control/Menu.jsp">Control</a>
        <script src="resource/js/Script-Login.js"></script>
    </body>
</html>
