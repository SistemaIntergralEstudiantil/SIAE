/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.siae.modelo.CursosDAO;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.beans.Curso;
import mx.com.siae.modelo.beans.ReporteCurso;

/**
 *
 * @author danielhernandezreyes
 */
@WebServlet(name = "Control", urlPatterns = {"/Control"})
public class Control extends HttpServlet {

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
            request.getRequestDispatcher("error/error.jsp").forward(request, response);
            // Redireccionamiento a la pagina de error.
        }else{
            try {
                String clave = request.getParameter("clave");
                CursosDAO crl;
                ArrayList<ReporteCurso> list;
                switch(clave){
                    case "add":
                        crl = new CursosDAO();
                        Curso nuevo = new Curso();
                        // idCurso&idResponsable&estado&cupo&tipo&idAsignatura
                        String idCurso = request.getParameter("idCurso");
                        String idResponsable = request.getParameter("idResponsable");
                        String estado = request.getParameter("estado");
                        String cupo = request.getParameter("cupo");
                        String tipo = request.getParameter("tipo");
                        String idAsignatura = request.getParameter("idAsignatura");
                        nuevo.setCupo(Integer.parseInt(cupo));
                        nuevo.setEstado(estado);
                        nuevo.setIdAsignatura(Integer.parseInt(idAsignatura));
                        nuevo.setIdCurso(Integer.parseInt(idCurso));
                        nuevo.setIdResponsable(idResponsable);
                        nuevo.setTipo(tipo);
                        boolean estatus = crl.addCurso(nuevo);
                        request.setAttribute("msj", (estatus)?"Curso registrado":"Curso no registrado");
                        list = crl.reporteCursos();
                        request.setAttribute("lista", list);
                        request.setAttribute("type", "Curso");
                        request.getRequestDispatcher("/Control/Menu.jsp").forward(request, response);
                    break;
                    case "course":
                        crl = new CursosDAO();
                        request.setAttribute("msj", "Consulta realizada");
                        list = crl.reporteCursos();
                        request.setAttribute("lista", list);
                        request.setAttribute("type", "Curso");
                        request.getRequestDispatcher("/Control/Menu.jsp").forward(request, response);
                    break;
                    case "asesor":
                        crl = new CursosDAO();
                        request.setAttribute("msj", "Consulta realizada");
                        list = crl.reporteCursos();
                        request.setAttribute("lista", list);
                        request.setAttribute("type", "Asesor");
                        request.getRequestDispatcher("/Control/Menu.jsp").forward(request, response);
                    break;
                    case "session":// Salida de la pagina
                        crl = new CursosDAO();
                        request.setAttribute("msj", "Consulta realizada");
                        list = crl.reporteCursos();
                        request.setAttribute("lista", list);
                        request.setAttribute("type", "Curso");
                        request.getRequestDispatcher("/Control/Menu.jsp").forward(request, response);
                    break;
                }
            } catch (ClassNotFoundException ex) {
                sesion.setAttribute("user", sec);
                sec.setErrorMsj("Error al declarar el conector a la SGBD:");
                sec.setErrorType(ex.toString());
                sec.setErrorUrl("/SIAE/session/Home.jsp");
                response.sendRedirect("error/error.jsp");
            } catch (SQLException ex) {
                sesion.setAttribute("user", sec);
                sec.setErrorMsj("Error en la conexión con el SGBD:");
                sec.setErrorType(ex.toString());
                sec.setErrorUrl("/SIAE/session/Home.jsp");
                response.sendRedirect("error/error.jsp");
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
