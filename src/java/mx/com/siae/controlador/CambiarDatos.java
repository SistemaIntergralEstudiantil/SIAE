/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import mx.com.siae.conector.config.Url;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.UsuariosDAO;
import mx.com.siae.modelo.beans.Usuarios;

/**
 *
 * @author danielhernandezreyes
 */
@WebServlet(name = "CambiarDatos", urlPatterns = {"/CambiarDatos"})
public class CambiarDatos extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Session sec = (Session) sesion.getAttribute("user");
        if(sec == null) { // Control para el acceso no autorizado.
            sec = new Session();
            sec.setTypeSessionNull(0);
            sesion.setAttribute("user", sec);
            request.getRequestDispatcher(Url.URL_ERROR).forward(request, response);
            // Redireccionamiento a la pagina de error.
        } else {
            try {
                String clave = request.getParameter("clave");
                if(clave == null)
                        throw new Exception("La clave es null"); 
                if(clave.equals("change-foto")) {
                    // Obtención de los parametros de la interfaz
                    String contra = request.getParameter("contra");
                    if(contra == null)
                        throw new Exception("No se ingreso la contraseña"); 
                    Part foto = request.getPart("foto");
                    if(foto == null)
                        throw new Exception("No se selecciona una foto"); 
                    Usuarios userC = sec.getUser();
                    userC.gFoto = foto.getInputStream();
                    userC.setPassword(contra);
                    UsuariosDAO crlC = new UsuariosDAO();
                    
                    crlC.changeDataUser(userC);
                    Usuarios temp = crlC.iniciarSesion(userC);
                    // Realziar el cambio de los datos 
                    if(temp != null){ // Todos lo datos obtenidos.
                        sec.setUser(temp);
                        sesion.setAttribute("user", sec);
                        request.getRequestDispatcher("session/Home.jsp").forward(request, response);
                    } else {
                        throw new Exception("Las credenciales no se encontrarón."); 
                    }
                }
                if(clave.equals("change-pass")) {
                    // Obtención de los parametros de la interfaz
                    String contra = request.getParameter("contra");
                    String newContra = request.getParameter("newContra");
                    if(contra == null)
                        throw new Exception("No se ingreso la contraseña");
                    if(newContra == null)
                        throw new Exception("No se ingreso la nueva contraseña"); 
                    
                    Usuarios userC = sec.getUser();
                    userC.setPassword(contra);
                    userC.setPasswordNew(newContra);
                    UsuariosDAO crlC = new UsuariosDAO();
                    crlC.changeDataUser(userC);
                    userC.setPassword(userC.getPasswordNew());
                    userC.setPasswordNew(null);
                    // Reiniciar la sesión
                    Usuarios temp = crlC.iniciarSesion(userC);
                    // Realziar el cambio de los datos 
                    if(temp != null){ // Todos lo datos obtenidos.
                        sec.setUser(temp);
                        sesion.setAttribute("user", sec);
                        request.getRequestDispatcher("session/Home.jsp").forward(request, response);
                    } else {
                        throw new Exception("Las credenciales no se encontrarón."); 
                    }
                }
            } catch (ClassNotFoundException ex) {
                sesion.setAttribute("user", sec);
                sec.setErrorMsj("Error al declarar el conector a la SGBD:");
                sec.setErrorType(ex.toString());
                sec.setErrorUrl(Url.URL_HOME);
                response.sendRedirect(Url.URL_ERROR);
            } catch (SQLException ex) {
                sesion.setAttribute("user", sec);
                sec.setErrorMsj("Error en la conexión con el SGBD:");
                sec.setErrorType(ex.toString());
                sec.setErrorUrl(Url.URL_HOME);
                response.sendRedirect(Url.URL_ERROR);
            } catch (Exception ex) {
                sesion.setAttribute("user", sec);
                sec.setErrorMsj(ex.getMessage());
                sec.setErrorType("java.lang.Exception");
                sec.setErrorUrl(Url.URL_LOGIN);
                response.sendRedirect(Url.URL_ERROR);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
