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
import mx.com.siae.modelo.CursosDAO;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.beans.ReporteAlumno;

/**
 *
 * @author danielhernandezreyes
 */
@WebServlet(name = "ControlAltaBaja", urlPatterns = {"/ControlAltaBaja"})
public class ControlAltaBaja extends HttpServlet {

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
        if(sec == null){ // Control para el acceso no autorizado.
            sec = new Session();
            sec.setTypeSessionNull(0);
            sesion.setAttribute("user", sec);
            request.getRequestDispatcher(Url.URL_ERROR).forward(request, response);
            // Redireccionamiento a la pagina de error.
        }else{
            try { // Operaciones a la BD.
                
                CursosDAO crl = new CursosDAO();
                String clave = request.getParameter("clave");
                if(clave.equals("registro-a") || clave.equals("registro-b")) {
                    String idC = request.getParameter("idCurso");
                    String estado = request.getParameter("estado");
                    String matricula = request.getParameter("matricula");
                    int idCurso = Integer.parseInt(idC);
                    if(clave.equals("registro-a")) {
                        crl.registrarComprobacionBajaAlta(idCurso, matricula, "A", estado);
                    }
                    if(clave.equals("registro-b")) {
                        crl.registrarComprobacionBajaAlta(idCurso, matricula, "B", estado);
                    }
                }
                if(clave.equals("verano")) {
                    String status_v = request.getParameter("status-v");
                    crl.activarVerano(status_v.equals("A"));
                }
                
                ArrayList<ReporteAlumno> data = crl.reporteAlumnos();
                ArrayList<ReporteAlumno> list_b = new ArrayList<>();
                ArrayList<ReporteAlumno> list_a = new ArrayList<>();
                for (ReporteAlumno ra : data) {
                    if(ra.getEstado().equals("SA")) {
                        list_a.add(ra);
                    } else {
                        list_b.add(ra);
                    }
                }
                boolean statu = crl.estadoVerano();
                request.setAttribute("status-v", statu?"A":"D");
                request.setAttribute("lista-a", list_a);
                request.setAttribute("lista-b", list_b);
                request.getRequestDispatcher(Url.URL_CONTROLG_MENU_3).forward(request, response);
                // Redirección a la pagina de control academica.
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
