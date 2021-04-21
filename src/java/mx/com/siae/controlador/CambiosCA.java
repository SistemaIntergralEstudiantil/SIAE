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
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.UsuariosDAO;
import mx.com.siae.modelo.beans.AreaApoyo;
import mx.com.siae.modelo.beans.Asignatura;
import mx.com.siae.modelo.beans.DocenteR;
import mx.com.siae.modelo.beans.ReporteAsesoria;

/**
 * Esta clase representa el control de las peticiones para la administración de
 * las respuestas, para las páginas de control se asesorias.
 * @version 21/04/2021A
 * @author danielhernandezreyes
 * @see Session
 * @see UsuariosDAO
 * @see AreaApoyo
 * @see Asignatura
 * @see DocenteR
 * @see ReporteAsesoria
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
                    // Mensaje de respuesta para la vista
                    request.setAttribute("msj", "Consulta registro de asesoria");
                }
                // Agregar una asesoria
                if(clave.equals("add-A")) {
                    // Obtención de los parametros de la interfaz
                    String url = request.getParameter("url");
                    String dia = request.getParameter("dia");
                    String hora_inicio = request.getParameter("hora_inicio");
                    String hora_fin = request.getParameter("hora_fin");
                    String codigo = request.getParameter("codigo");
                    String idAsignaturaA = request.getParameter("idAsignatura");
                    String idResponsableA = request.getParameter("idResponsable");
                    // Cración del objeto a registrar
                    AreaApoyo nueva = new AreaApoyo();
                    nueva.setUrl(url);
                    nueva.setDia(dia);
                    nueva.setHora_inicio(convertStringToTime(hora_inicio));
                    nueva.setHora_fin(convertStringToTime(hora_fin));
                    nueva.setCodigo((codigo==null)?"":codigo);
                    nueva.setIdAsignatura(Integer.parseInt(idAsignaturaA));
                    nueva.setIdResponsable(idResponsableA);
                    // Registrar la nueva AreaApoyo
                    crlA.addAsesoria(nueva);
                    // Asignación de un mensaje de visualización en la interfaz
                    request.setAttribute("msj", "Asesoria registrada");
                }
                // Cambiar el estado de una AreaApoyo
                if(clave.equals("change-A")) {
                    String idAsesoria = request.getParameter("idAsesoria");
                    String estado = request.getParameter("estado");
                    // Crear el objeto del cambio
                    AreaApoyo change = new AreaApoyo();
                    change.setIdAreasApoyo(Integer.parseInt(idAsesoria));
                    change.setEstado((estado.equals("E"))?"D":"E");
                    // Reagistrar el cambio de estado
                    crlA.changeStatusAsesoria(change);
                    request.setAttribute("msj", "Operación asesoria");
                }
                // Consultar el registro de las Asesorias
                ArrayList<ReporteAsesoria> listRA = crlA.consultaAsesoria();
                // Enviar los datos consultados a la interfaz
                request.setAttribute("lista-RA", listRA);
                request.setAttribute("lista-AA", consultarA());
                request.setAttribute("lista-DA", consultarD());
            }
            // Redireccionar la petición a la interfaz
            request.getRequestDispatcher("Control-G/Menu_2.jsp").forward(request, response);
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
    /**
     * Método convierte una cadena de texto, para horas y minutos<br>
     * a un objeto tipo Time.
     * @param time La cadena de texto, la cual contiene el tiempo<br>
     * en un formato:HH:MM
     * @return El objeto Time con la hora espesificada el la cadena. 
     */
    private Time convertStringToTime(String time){
        String[] in = time.split(":");
        int h = Integer.parseInt(in[0]);
        int m = Integer.parseInt(in[1]);
        Time ini = new Time( h, m, 0);
        return ini;
    }
    /**
     * Método consulta el reporte de las Asignaturas, las cuales se encuentra<br>
     * habilidatas en el semestre en curso.
     * @return 
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt>
     *      <dd>Los datos de las Asignaturas habilitadas</dd>
     *  <dt><h3>ArrayList(0)</h3></dt>
     *      <dd>Se reportara una lista vacia, cuando no existan registros</dd>
     * </dl>
     * @throws SQLException Error en la execución o conexión a la BD
     * @throws ClassNotFoundException Error en el establecimento del conector
     */
    private ArrayList<Asignatura> consultarA() throws SQLException, ClassNotFoundException {
        AsignaturaDAO crlA = new AsignaturaDAO();
        ArrayList<Asignatura> listaA = crlA.reporteAsignaturaActivas();
        return listaA;
    }
    /**
     * Método consulta el reporte de los docentes, existentes en la BD.
     * @return 
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt>
     *      <dd>Los datos de los Docentes registrados</dd>
     *  <dt><h3>ArrayList(0)</h3></dt>
     *      <dd>Se reportara una lista vacia, cuando no existan registros</dd>
     * </dl>
     * @throws SQLException Error en la execución o conexión a la BD
     * @throws ClassNotFoundException Error en el establecimento del conector
     */
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
