<%-- 
    Document   : Login
    Created on : 22/03/2021, 12:11:40 PM
    Author     : sandr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" >
    <head>
        <title>Login </title>
        <link rel="shortcut icon" href="images/logo_SIAE.png" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <link rel="stylesheet" href="resource/css/Style-Login.css"/>
    </head>
    <body>
        <p align="right">
            <table width="100%">
                <tr>
                    <td align="center" width="33%"> <img src="images/Logo-TecNM.png" height="80" width="180"> </td>
                    <td align="center" width="33%"> <img src="images/logo_tec.png" height="100" width="190" </td>
                    <td align="center" width="33%"> <img src="images/logo_ISIC.png" height="80" width="150"> </td>
                </tr>
            </table>
        </p>
        <p align="center"> <img src="images/logo_SIAE.png" height="220" width="220"> </p>
        <center>
            <form action="Login" method="POST" >
                <div  >
                    <label  for="user">Usuario:</label>
                    <input  id="user" type="text" name="idUsuario" />
                </div><br>
                <div  >
                    <label  for="pass">Contraseña:</label>
                    <input  id="pass" type="password" name="contra" />
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
        <script src="resource/js/Script-Login.js"></script>
    </body>
</html>
