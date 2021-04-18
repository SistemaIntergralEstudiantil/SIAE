<%-- 
    Document   : altasYbajas
    Created on : 15/04/2021, 01:44:18 PM
    Author     : emeli
--%>

<%@page import="mx.com.siae.modelo.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Módulo Altas Y Bajas de materias</title>
        <link rel="shortcut icon" href="/SIAE/resource/images/logo_SIAE.png" />
        <link rel="stylesheet" href="/SIAE/resource/css/Style-General.css"/>
        
    </head>
    <body>
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
         <header>
            <nav>
                <ul class="content-G content">
                    <li>
                        
                    </li>
                    <li><h1 class="content-item-G content-item" >Módulo de Altas y Bajas de materias</h1></li>                    
                    <li>
                        <img class="content-item-G content-item content-img" src="/SIAE/resource/images/logo_SIAE.png" width="80" height="80" alt="alt"/>
                    </li>
                </ul>
            </nav>
             <img src="META-INF/123.jpg" alt=""/>
        </header>
        <br>
        <img src="123.jpeg"  width="150" height="150" align="right">
        <br>
        <p align="center">
        <select class="item-G-A-Selec content-selec" id="semestre" >
                            <option value="0" disabled selected>Semestre ...</option>
                            <option value="1">1</option> 
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option> 
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option> 
                            <option value="8">8</option>
                            <option value="9">9</option>
                            
        </select></p>
        <br>
        <br>
        <br>
        <table border="1" style="margin: 0 auto;"> 
          <tr>
            <td>Clave de la asignatura</th>
            <td>Nombre</th>
            <td>Créditos</th>
          </tr>
        </table>
        <table border="1" style="margin: 0 auto;"> 
          <tr>
            <td>Clave de la asignatura</th>
            <td>Nombre</th>
            <td>Créditos</th>
          </tr>
        </table>
        <p align="right"> <input type="submit" value="Menú Principal" style="font-size:100%" FACE="arial" /> </p>
        <table border="1" style="margin: 0 auto;"> 
          <tr>
            <td>Clave de la asignatura</th>
            <td>Nombre</th>
            <td>Créditos</th>
          </tr>
        </table>
        <table border="1" style="margin: 0 auto;"> 
          <tr>
            <td>Clave de la asignatura</th>
            <td>Nombre</th>
            <td>Créditos</th>
          </tr>
        </table>
        <p align="right"> <input type="submit" value="ENVIAR" style="font-size:100%" FACE="arial" /> </p>
        <table border="1" style="margin: 0 auto;"> 
          <tr>
            <td>Clave de la asignatura</th>
            <td>Nombre</th>
            <td>Créditos</th>
          </tr>
        </table><br>
        <table border="1" style="margin: 0 auto;"> 
          <tr>
            <td>Clave de la asignatura</th>
            <td>Nombre</th>
            <td>Créditos</th>
          </tr>
        </table>
    </body>
</html>
