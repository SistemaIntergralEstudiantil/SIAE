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
import mx.com.siae.modelo.beans.ReporteCurso;
import mx.com.siae.modelo.beans.Usuarios;

/**
 *
 * @version 1/05/2021/A
 * @author danielhernandezreyes
 */
@WebServlet(name = "ControlCargaAcademica", urlPatterns = {"/ControlCargaAcademica"})
public class ControlCargaAcademica extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
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
                Usuarios alu = sec.getUser();
                CursosDAO crl = new CursosDAO();
                String clave = request.getParameter("clave");
                if(clave.equals("alta")) {
                    String Asig_x = request.getParameter("Asig_0");
                    int index = 1;
                    while(Asig_x!=null) {
                        String IdCurso = Asig_x.split(",")[0];
                        String Asignatura = Asig_x.split(",")[1];
                        int curso = Integer.parseInt(IdCurso);
                        crl.registrarAltaAlumnoCurso(curso, alu.getIdUsuario());
                        Asig_x = request.getParameter("Asig_"+index);
                        index++;
                    }
                }
                if(clave.equals("baja")) {
                    String Asig_x = request.getParameter("Asig_0");
                    int index = 1;
                    while(Asig_x!=null) {
                        String IdCurso = Asig_x.split(",")[0];
                        String Asignatura = Asig_x.split(",")[1];
                        int curso = Integer.parseInt(IdCurso);
                        crl.registrarBajaAlumnoCurso(curso, alu.getIdUsuario());
                        Asig_x = request.getParameter("Asig_"+index);
                        index++;
                    }
                }
                ArrayList<ReporteCurso> list_rca = crl.reporteCursosAltas(alu.getIdUsuario());
                ArrayList<ReporteCurso> list_rcb = crl.reporteCursosBajas(alu.getIdUsuario());
                request.setAttribute("lista-rca", list_rca);
                request.setAttribute("lista-rcb", list_rcb);
                request.getRequestDispatcher(Url.URL_ALTAS_Y_BAJAS).forward(request, response);
                // Redirección a la pagina de asignaturas.
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
