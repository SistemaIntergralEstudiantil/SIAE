/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.controlador;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.siae.conector.config.Url;
import mx.com.siae.modelo.Correo;
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
                Usuarios alu = sec.getUser();
                CursosDAO crl = new CursosDAO();
                String clave = request.getParameter("clave");
                if(clave.equals("alta") ||clave.equals("baja")) {
                    String s = request.getParameter("size");
                    int size = Integer.parseInt(s);
                    if(clave.equals("alta")) {
                        String txt = "";
                        for (int i = 0; i < size; i++) {
                            String Asig_x = request.getParameter("Asig_"+i);
                            if(Asig_x!=null) {
                                String IdCurso = Asig_x.split(",")[0];
                                int curso = Integer.parseInt(IdCurso);
                                crl.registrarAltaAlumnoCurso(curso, alu.getIdUsuario());
                                txt +=Asig_x+":";
                            }
                        }
                        if(!txt.equals("")) {
                            Correo email = new Correo();
                            email.generar(alu,txt);
                            email.closePDF();
                            email.enviar();
                        }
                    }
                    if(clave.equals("baja")) {
                        //String txt = "";
                        for (int i = 0; i < size; i++) {
                            String Asig_x = request.getParameter("Asig_"+i);
                            if(Asig_x!=null) {
                                String IdCurso = Asig_x.split(",")[0];
                                int curso = Integer.parseInt(IdCurso);
                                crl.registrarBajaAlumnoCurso(curso, alu.getIdUsuario());
                                //txt +=Asig_x+":";
                            }
                        }
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
            } catch (MessagingException | UnsupportedEncodingException ex) {
                sesion.setAttribute("user", sec);
                sec.setErrorMsj("Error al generar y/o enviar el correo");
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
