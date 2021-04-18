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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.siae.modelo.AsignaturaDAO;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.beans.AlumnoRepoD;

/**
 *
 * @author danielhernandezreyes
 */
@WebServlet(name = "Docente", urlPatterns = {"/Docente"})
public class Docente extends HttpServlet {

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
                switch(clave){
                    case "inicio":
                        String idUsuario = sec.getUser().getIdUsuario();
                        AsignaturaDAO crl = new AsignaturaDAO();
                        ArrayList<AlumnoRepoD> list = crl.reporteAlumnoCursoD(idUsuario);
                        request.setAttribute("lista", list);
                        request.getRequestDispatcher("/Docente/Cursos.jsp").forward(request, response);
                    break;
                    case "change":
                        String matricula = request.getParameter("matricula");
                        String idCurso = request.getParameter("idCurso");
                        String status = request.getParameter("status");
                        /* Realizar el enlace a la base de datos cuando termine redireccionar a la misma pagina. 
                        Para volver a realizar los cambios*/
                        System.out.println(matricula +" dsa "+idCurso + "sad"+ status);
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
