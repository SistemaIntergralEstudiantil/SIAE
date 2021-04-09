<%-- 
    Document   : menu
    Created on : 7/04/2021, 08:12:02 PM
    Author     : danielhernandezreyes
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Áreas de apoyo</title>
        <link rel="shortcut icon" href="resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="../resource/css/Style-General.css"/>
        <link rel="stylesheet" href="../resource/css/Style-AreasApoyo.css"/>
    </head>
    <body>
        <form action="/SIAE/Asesorias" method="POST" >
            <h1>Areas de apoyo</h1>
            <div  >
                <select name="servicio">
                    <option value="" disabled selected>Áreas</option>
                    <option value="A">Asesorias</option> 
                    <option value="S">Servicio psicologico</option>
                </select>
            </div><br>
            <div  >
                <input type="hidden" name="clave" value="menu">
                <input type="submit" value="Consultar">
            </div>
        </form>
    </body>
</html>
