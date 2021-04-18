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
        <meta name="description" content="SIAE permite a los instructores y
estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Altas y bajas</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
    </head>
    <body>
        <td align="left" width="33%"> <img src="resource/images/logo_ISIC.png" height="80" width="150"> </td>
       <select>
                            <option value="0" disabled selected>Semestre</option>
                            <option value="1">Primero</option> 
                            <option value="2">Segundo</option>
                            <option value="3">Tercero</option>
                            <option value="4">Cuarto</option> 
                            <option value="5">Quinto</option>
                            <option value="6">Sexto</option>
                            <option value="7">Septimo</option> 
                            <option value="8">Octavo</option>
                            <option value="9">Noveno</option>
                        </select>
        <%
            
            HttpSession sesion = request.getSession();
            Session sec = (Session) sesion.getAttribute("user");
            if(sec == null){
                sec = new Session();
                sec.setTypeSessionNull(1);
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher("/error/error.jsp").forward(request, response);   
            }
        %>
    <div class="content-table" >
            <table class="table" >
                    <thead>
                        <tr>
                <input type="checkbox" class="tableid" name="tableid" id="tableid" class="click">
                            <th>Clave de la asignatura</th>
                            <th>Nombre</th>
                            <th>Créditos</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" >
    <div class="content-table" >
            <table class="table" >
                    <thead>
                        <tr>
                        <input type="checkbox" class="tableid" name="tableid" id="tableid" class="click">
                            <th>Clave de la asignatura</th>
                            <td> <input type="checkbox"> </td> 
                            <th>Nombre</th>
                            <th>Créditos</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" >
    <div class="content-table" >
            <table class="table" >
                    <thead>
                        <tr>
                  <input type="checkbox" class="tableid" name="tableid" id="tableid" class="click">
                            <th>Clave de la asignatura</th>
                            <th>Nombre</th>
                            <th>Créditos</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" >
    <div class="content-table" >
            <table class="table" >
                    <thead>
                        <tr>
                            <input type="checkbox" class="tableid" name="tableid" id="tableid" class="click">
                            <th>Clave de la asignatura</th>
                            <th>Nombre</th>
                            <th>Créditos</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" ></tbody>
        <input type="submit" value="Menú Principal" style="font-size:100%" FACE="arial"><br><br>
                    
                    <div class="content-table" >
            <table class="table" >
                    <thead>
                        <tr>
                            <th>Clave de la asignatura</th>
                            <th>Nombre</th>
                            <th>Créditos</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" ></tbody>
                    <div class="content-table" >
            <table class="table" >
                    <thead>
                        <tr>
                            <th>Clave de la asignatura</th>
                            <th>Nombre</th>
                            <th>Créditos</th>
                        </tr>
                    </thead>
                    <tbody id="content-body" ></tbody>
        <input type="submit" value="Enviar Solicitud" style="font-size:100%" FACE="arial"><br><br>
    </body>
</html>
