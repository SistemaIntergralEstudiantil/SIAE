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
import mx.com.siae.modelo.beans.Usuarios;

/**
 *
 * @author danielhernandezreyes
 */
@WebServlet(name = "Verano", urlPatterns = {"/Verano"})
public class Verano extends HttpServlet {

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
        try {
            if(sec == null) { // Control para el acceso no autorizado.
                sec = new Session();
                sec.setTypeSessionNull(0);
                sesion.setAttribute("user", sec);
                request.getRequestDispatcher(Url.URL_ERROR).forward(request, response);
                // Redireccionamiento a la pagina de error.
            } else {
                String clave = request.getParameter("clave");
                // Asesorias
                AsignaturaDAO crlA = new AsignaturaDAO();
                Usuarios user = sec.getUser();
                if(clave.equals("registrar")) {
                    String idAsignatura_1 = request.getParameter("idAsignatura_1");
                    String idAsignatura_2 = request.getParameter("idAsignatura_2");
                    if(idAsignatura_1!=null && idAsignatura_2!=null) {
                        if(!idAsignatura_1.equals(idAsignatura_2) && !idAsignatura_1.equals("0") && !idAsignatura_2.equals("0")) {
                            int idAsignatura = 0;
                            idAsignatura = Integer.parseInt(idAsignatura_1);
                            crlA.solicitarVerano(idAsignatura, user.getIdUsuario(), "A");
                            idAsignatura = Integer.parseInt(idAsignatura_2);
                            crlA.solicitarVerano(idAsignatura, user.getIdUsuario(), "A");
                            crlA.solicitarVerano(10, user.getIdUsuario(), "T");
                        }
                    }
                }
                boolean estado = crlA.solicitarVerano(user.getIdUsuario());
                if(estado) {
                    ArrayList<Asignatura> lista = crlA.reporteAsignaturaActivas();
                    request.setAttribute("lista", lista);
                    // Redireccionar la petición a la interfaz
                    request.getRequestDispatcher(Url.URL_VERANO).forward(request, response);
                } else {
                    request.getRequestDispatcher("session/Home.jsp").forward(request, response);
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
