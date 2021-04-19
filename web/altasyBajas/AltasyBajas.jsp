<%-- 
    Document   : AltasyBajas
    Created on : 18/04/2021, 12:54:56 AM
    Author     : emeli
--%>

<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Altas y bajas de Materias</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
    </head>
    <body>
        <header>
        <nav>
        <ul class="content-G content" >
            <li><h1 class="content-item-G content-item" >Altas y Bjas de Materias</h1></li>
            <li><img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="100" height="100" alt="alt"/></li>
        </ul>
        </nav>
        </header>
        <center>
            <img src="/SIAE/resource/images/logo_ISIC.png"  width="100" height="100" align="left">
            <h2 style="font-size:2rem;" > Aquí tendrás la oportunidad de solicitar tus Altas y bajas de Materias</h2>
        </center>
        <center>
            <select style="font-size:1.3rem" >
                <option value="0" disabled selected>Semestre</option>
                <option value="1">Primero</option> 
                <option value="2">Segundo</option>
                <option value="3">Tercero</option>
                <option value="4">Cuarto</option> 
                <option value="5">Quinto</option>
                <option value="6">Sexto</option>
                <option value="7">Séptimo</option> 
                <option value="8">Octavo</option>
                <option value="9">Noveno</option>
            </select>
        </center>
        <div class="content-table" >
            <table class="table" >
            <thead><tr>
                    <th>Solicitar</th>
                    <th>Clave de la Asignatura</th>
                    <th>Nombre</th>
                    <th>Créditos</th></tr>
            </thead>
            <tbody><tr>
                <th><input type="checkbox" ></th>
                <th>Asignatura</th>
                <th>Nombre</th>
                <th>Créditos</th>
                </tr>
            </tbody>
            </table>
            <br><br>
            <center><input type="submit" value="Enviar Solicitud" style="font-size:100%"></center>
            <br><br>
            <table class="table" >
            <thead>
                <tr>
                    <th>Clave de la asignatura</th>
                    <th>Nombre</th>
                    <th>Créditos</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th>Clave de la asignatura</th>
                    <th>Nombre</th>
                    <th>Créditos</th>
                </tr>
            </tbody>
            </table>
            <br>
            <p align="right"><input type="button" value="Menú Principal" style="font-size:1.1rem"/></p>
        </div>
    </body>
</html>
