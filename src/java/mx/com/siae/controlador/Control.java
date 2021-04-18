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
import mx.com.siae.modelo.AsignaturaDAO;
import mx.com.siae.modelo.CursosDAO;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.UsuariosDAO;
import mx.com.siae.modelo.beans.Asignatura;
import mx.com.siae.modelo.beans.Curso;
import mx.com.siae.modelo.beans.DocenteR;
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
                        nuevo.setEstado((estado==null)?"D":"E");
                        nuevo.setIdAsignatura(Integer.parseInt(idAsignatura));
                        nuevo.setIdCurso(Integer.parseInt(idCurso));
                        nuevo.setIdResponsable(idResponsable);
                        nuevo.setTipo(tipo);
                        boolean estatus = crl.addCurso(nuevo);
                        request.setAttribute("msj", (estatus)?"Curso registrado":"Curso no registrado");
                        list = crl.reporteCursos();
                        // Obtener la lista de las asignaturas habilitadas
                        ArrayList<Asignatura> listaA = consultarA();
                        // Obtener la lista de los docentes
                        ArrayList<DocenteR> listaD = consultarD();
                        // Enviar los datos obtenidos
                        request.setAttribute("lista", list);
                        request.setAttribute("lista-A", listaA);
                        request.setAttribute("lista-D", listaD);
                        request.setAttribute("type", "Curso");
                        //response.reset();
                        //request.removeAttribute("clave");
                        request.getRequestDispatcher("Control-G/Menu.jsp").forward(request, response);
                    break;
                    case "course":
                        crl = new CursosDAO();
                        request.setAttribute("msj", "Consulta registro de cursos");
                        list = crl.reporteCursos();
                        // Enviar los datos obtenidos
                        request.setAttribute("lista", list);
                        // Consultar Asignaturas activas y los docentes
                        request.setAttribute("lista-A", consultarA());
                        request.setAttribute("lista-D", consultarD());
                        request.setAttribute("type", "Curso");
                        request.getRequestDispatcher("/Control-G/Menu.jsp").forward(request, response);
                    break;
                    case "asesor":
                        crl = new CursosDAO();
                        request.setAttribute("msj", "Consulta realizada");
                        list = crl.reporteCursos();
                        request.setAttribute("lista", list);
                        request.setAttribute("type", "Asesor");
                        request.getRequestDispatcher("/Control-G/Menu.jsp").forward(request, response);
                    break;
                    case "change":// Habilitar o desabilitar un curso
                        crl = new CursosDAO();
                        request.setAttribute("msj", "Consulta realizada"); // 
                        list = crl.reporteCursos();
                        request.setAttribute("lista", list);
                        request.setAttribute("type", "Curso");
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
                response.sendRedirect("/SIAE/error/error.jsp");
            } catch (SQLException ex) {
                sesion.setAttribute("user", sec);
                sec.setErrorMsj("Error en la conexión con el SGBD:");
                sec.setErrorType(ex.toString());
                sec.setErrorUrl("/SIAE/session/Home.jsp");
                response.sendRedirect("/SIAE/error/error.jsp");
            }
        }
        
    }
    
    private ArrayList<Asignatura> consultarA() throws SQLException, ClassNotFoundException {
        AsignaturaDAO crlA = new AsignaturaDAO();
        ArrayList<Asignatura> listaA = crlA.reporteAsignaturaActivas();
        return listaA;
    }
    
    private ArrayList<DocenteR> consultarD() throws SQLException, ClassNotFoundException {
        UsuariosDAO crlU = new UsuariosDAO();
        ArrayList<DocenteR> listaD = crlU.reporteDocentes();
        return listaD;
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
