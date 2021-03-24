<%-- 
    Document   : Login
    Created on : 22/03/2021, 12:11:40 PM
    Author     : sandr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login </title>
        <link rel="shortcut icon" href="images/logo_SIAE.png" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <div class="content-margin content-linea" >
            <label class="content-linea_label_uno" for="user">Usuario:</label>
            <input class="content-linea_input" id="user" type="text" name="idUsuario" />
        </div><br>
        <div class="content-margin content-linea" >
            <label class="content-linea_label_dos" for="pass">Contraseña:</label>
            <input class="content-linea_input" id="pass" type="password" name="contraseña" />
        </div><br>
        <div class="content-margin content-linea" >
            <select name="TIPO DE USUARIO">
                <option value="1">Alumno</option> 
                <option value="2">Administrador</option>
            </select>
        </div><br>
        <div class="content-margin content-linea" >
            <input type="hidden" name="clave" value="log"/>
            <input class="content-margin content-padding content-linea_tres" type="submit" value="Ingresar">
        </div>
    </form>
    <br></center>
</center>
</body>
</html>
