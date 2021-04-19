/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.controlador;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.siae.modelo.AreasApoyoDAO;
import mx.com.siae.modelo.AsignaturaDAO;
import mx.com.siae.modelo.CursosDAO;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.UsuariosDAO;
import mx.com.siae.modelo.beans.Asesoria;
import mx.com.siae.modelo.beans.Asignatura;
import mx.com.siae.modelo.beans.DocenteR;
import mx.com.siae.modelo.beans.ReporteAsesoria;
import mx.com.siae.modelo.beans.ReporteCurso;

/**
 *
 * @author danielhernandezreyes
 */
@WebServlet(name = "CambiosCA", urlPatterns = {"/CambiosCA"})
public class CambiosCA extends HttpServlet {

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
            request.getRequestDispatcher("error/error.jsp").forward(request, response);
            // Redireccionamiento a la pagina de error.
        } else {
            try {
                String clave = request.getParameter("clave");
                // Asesorias
                if(clave.equals("asesor") || clave.equals("add-A") || clave.equals("change-A") ) {
                    AreasApoyoDAO crlA = new AreasApoyoDAO();
                    // Solo consultar Consulta
                    if(clave.equals("asesor")) {
                        request.setAttribute("msj", "Consulta registro de asesoria");
                    }
                    
                    // Agregar una asesoria
                    if(clave.equals("add-A")) {
                        String url = request.getParameter("url");
                        String dia = request.getParameter("dia");
                        String hora_inicio = request.getParameter("hora_inicio");
                        String hora_fin = request.getParameter("hora_fin");
                        String codigo = request.getParameter("codigo");
                        String idAsignaturaA = request.getParameter("idAsignatura");
                        String idResponsableA = request.getParameter("idResponsable");
                        Asesoria nueva = new Asesoria();
                        nueva.setUrl(url);
                        nueva.setDia(dia);
                        nueva.setHora_inicio(convertStringToTime(hora_inicio));
                        nueva.setHora_fin(convertStringToTime(hora_fin));
                        nueva.setCodigo((codigo==null)?"":codigo);
                        nueva.setIdAsignatura(Integer.parseInt(idAsignaturaA));
                        nueva.setIdResponsable(idResponsableA);
                        crlA.addAsesoria(nueva); // Registrar la nueva Asesoria
                        request.setAttribute("msj", "Asesoria registrada");
                    }
                    
                    if(clave.equals("change-A")) {
                        String idAsesoria = request.getParameter("idAsesoria");
                        String estado = request.getParameter("estado");
                        // Crear el objeto del cambio
                        Asesoria change = new Asesoria();
                        change.setIdAreasApoyo(Integer.parseInt(idAsesoria));
                        change.setEstado((estado=="E")?"D":"E");
                        crlA.changeStatusAsesoria(change);
                        request.setAttribute("msj", "Operación asesoria");
                    }
                    
                    ArrayList<ReporteAsesoria> listRA = crlA.consultaAsesoria();
                    request.setAttribute("lista-RA", listRA);
                    request.setAttribute("lista-AA", consultarA());
                    request.setAttribute("lista-DA", consultarD());
                    request.getRequestDispatcher("Control-G/Menu_2.jsp").forward(request, response);
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
    
    private Time convertStringToTime(String time){
        String[] in = time.split(":");
        int h = Integer.parseInt(in[0]);
        int m = Integer.parseInt(in[1]);
        Time ini = new Time( h, m, 0);
        return ini;
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
