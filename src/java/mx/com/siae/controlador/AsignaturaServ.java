/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.controlador;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.siae.conector.config.Url;
import mx.com.siae.modelo.AsignaturaDAO;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.beans.Asignatura;

/**
 *
 * @author danielhernandezreyes
 */
@WebServlet(name = "AsignaturaServ", urlPatterns = {"/AsignaturaServ"})
public class AsignaturaServ extends HttpServlet {

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
        if(sec == null){
            sec = new Session();
            sec.setTypeSessionNull(0);
            sesion.setAttribute("user", sec);
            request.getRequestDispatcher(Url.URL_ERROR).forward(request, response);
        
        }else{
            try {
                String servicio = request.getParameter("servicio");
                if(servicio == null){
                    response.sendRedirect(Url.URL_CURRICULA_MENU);
                    // Redirecciona a la misma pagina
                }else{
                    if(servicio.equals("AC")){ // Control areas de conocimiento
                        AsignaturaDAO crl = new AsignaturaDAO();
                        ArrayList<Asignatura> list = crl.reporteAsignatura();
                        request.setAttribute("lista", list);
                        request.getRequestDispatcher(Url.URL_CURRICULA_AREAS).forward(request, response);
                    }else{
                        if(servicio.equals("TE")){ // Control tiempo de estudio
                            request.getRequestDispatcher("ControlCargaAcademica?clave=seg-ac").forward(request, response);
                        }else{
                            response.sendRedirect(Url.URL_CURRICULA_MENU);
                        }
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
