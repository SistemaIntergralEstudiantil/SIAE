<%-- 
    Document   : ServicioPscologico
    Created on : 12/04/2021, 11:54:39 AM
    Author     : nazar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es" >
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="SIAE permite a los instructores y estudiantes consultar información sobre los diferentes servicios del instituto"/>
        <title>Servicio Psicologico </title>
        <link rel="stylesheet" href="resource/css/Style-General.css"/>
        <link rel="stylesheet" href="resource/css/Style-Login.css"/>
    </head>
    <body>
        <p align="right">
            <table width="100%">
                <tr>
                    <td align="center" width="33%"> <img src="resource/images/Logo-TecNM.png" height="80" width="180"> </td>
                    <td align="center" width="33%"> <img src="resource/images/logo_tec.png" height="100" width="190" </td>
                    <td align="center" width="33%"> <img src="resource/images/logo_ISIC.png" height="80" width="150"> </td>
                </tr>
            </table>
        </p>
        
            <form action="Servicio Psicológico" method="POST" >
                <center>            
                    <font size=6.5>
                <div  >
                    <label>SERVICIO PSICÓLOGICO </label>
                     </font>
                     </center> 
                </div><br>
                <font size=4.5>
                <div  >
                    <label> Si requieres atención legal o pscologica solicitala al correo redapoyo@itsoeh.edu.mx
                    enviendo los siguientes datos:
                    </label>
                    
                </div><br>
             
                    <label>Nombre completo</label>
                 </div><br>  
               
                    <label>Matricula</label>
                 </div><br>    
          
                    <label>Programa educativo</label>
                 </div><br>    
                
                    <label>Número telefónico</label>
                   
                </div><br>
                </font>
        <p align="center">
        <table width="100%" >
                <tr>
                    <td align="center" width="100%"> <img src="resource/images/serPsico.jpeg" height="350" width="550"> </td>
                </tr>
            </table>
        </p>
                <div  >
                    <input type="hidden" name="" value="log"/>
                    <input type="submit" value="Menú principal">
                </div>
            </form>
            <br>
            </form>
            <br>
  
        <script src="resource/js/Script-ServicioPscologico.js"></script>
    </body>
</html>
