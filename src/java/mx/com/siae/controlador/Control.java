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
import mx.com.siae.conector.config.Url;
import mx.com.siae.modelo.AsignaturaDAO;
import mx.com.siae.modelo.CursosDAO;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.UsuariosDAO;
import mx.com.siae.modelo.beans.Asignatura;
import mx.com.siae.modelo.beans.Curso;
import mx.com.siae.modelo.beans.DocenteR;
import mx.com.siae.modelo.beans.ReporteCurso;
import mx.com.siae.modelo.beans.Sesion;

/**
 * Esta clase representa el control de las peticiones para la administración de
 * las respuestas, para las páginas de control de cursos y sesiones.
 * @author danielhernandezreyes
 * @version 21/04/2021A
 * @see AsignaturaDAO
 * @see CursosDAO
 * @see Session
 * @see UsuariosDAO
 * @see Asignatura
 * @see Curso
 * @see DocenteR
 * @see ReporteCurso
 * @see Sesion
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
            request.getRequestDispatcher(Url.URL_ERROR).forward(request, response);
            // Redireccionamiento a la pagina de error.
        }else{
            try {
                String clave = request.getParameter("clave");
                response.resetBuffer();
                ArrayList<ReporteCurso> list;
                
                // Cursos
                if(clave.equals("add") || clave.equals("course") || clave.equals("change-c")) {
                    CursosDAO crl = new CursosDAO();
                    
                    if(clave.equals("course")) {
                        // Asignación de un mensage para la interfaz
                        request.setAttribute("msj", "Consulta registro de cursos");
                    }
                    // Cambio de estado de un curso
                    if(clave.equals("change-c")) {
                        // Obtenicón de los parametros de la interfaz
                        String idCurso = request.getParameter("idCurso");
                        String estado = request.getParameter("estado");
                        Curso c = new Curso();
                        c.setIdCurso(Integer.parseInt(idCurso));
                        c.setEstado(estado.equals("E")?"D":"E");
                        // Registrar cambios
                        crl.changeStatusCurso(c);
                        // Asignar mensaje para la interfaz
                        request.setAttribute("msj", "Operación curso");
                    }
                    // Agregar un nuevo curso
                    if(clave.equals("add")) {
                        // Leer los datos de la interfaz
                        String idCurso = request.getParameter("idCurso");
                        String idResponsable = request.getParameter("idResponsable");
                        String estado = request.getParameter("estado");
                        String cupo = request.getParameter("cupo");
                        String tipo = request.getParameter("tipo");
                        String idAsignatura = request.getParameter("idAsignatura");
                        Curso nuevo = addDataCurso(idCurso,idResponsable,estado,cupo,tipo,idAsignatura);
                        // Resutado de la consulta con la base de datos
                        crl.addCurso(nuevo);
                        request.setAttribute("msj", "Operación de curso");
                    }
                    list = crl.reporteCursos();
                    request.setAttribute("lista", list); // Enviar los datos obtenidos
                    // Consultar Asignaturas activas y los docentes
                    request.setAttribute("lista-A", consultarA());
                    request.setAttribute("lista-D", consultarD());
                    request.setAttribute("type", "Curso");
                    // Redireccionar a la interfaz
                    request.getRequestDispatcher(Url.URL_CONTROLG_MENU).forward(request, response);
                }
                // Control de sesion
                if(clave.equals("session-c") || clave.equals("session-add") || clave.equals("session-delete")) {
                    CursosDAO crl = new CursosDAO();
                    ReporteCurso repoC = new ReporteCurso();
                    // Obtener los parametros de la interfaz
                    String idCurso = request.getParameter("idCurso");
                    String asignatura = request.getParameter("asignatura");
                    String responsable = request.getParameter("responsable");
                    repoC.setIdCurso(Integer.parseInt(idCurso));
                    repoC.setAsignatura(asignatura);
                    repoC.setResponsable(responsable);
                    // Mensaje para la interfaz
                    request.setAttribute("msj", "Consulta registro de sesiones");
                    // Eliminar la sesión
                    if(clave.equals("session-delete")) {
                        String idSesion = request.getParameter("idSesion");
                        Sesion change = new Sesion();
                        change.setIdSesion(Integer.parseInt(idSesion));
                        // Realizar la operación de eliminación
                        crl.deleteSessionCurso(change);
                        request.setAttribute("msj", "Eliminación de sesión");
                    }
                    // Agregar una sesión
                    if(clave.equals("session-add")) {
                        // Obtener los datos de la interfaz
                        String dia = request.getParameter("dia");
                        String hora_inicio = request.getParameter("hora_inicio");
                        String hora_fin = request.getParameter("hora_fin");
                        Sesion change = new Sesion();
                        change.setIdCurso(Integer.parseInt(idCurso));
                        change.setDia(dia);
                        change.setHora_inicio(hora_inicio);
                        change.setHora_fin(hora_fin);
                        crl.newSessionCurso(change);
                        // Mensaje para la interfaz
                        request.setAttribute("msj", "Nueva sesión");
                    }
                    Curso curso = new Curso();
                    curso.setIdCurso(repoC.getIdCurso());
                    ArrayList<Sesion> lista = crl.reporteToSesiones(curso);
                    request.setAttribute("idCurso", idCurso);
                    request.setAttribute("asignatura", asignatura);
                    request.setAttribute("responsable", responsable);
                    request.setAttribute("lista-S", lista);
                    request.getRequestDispatcher(Url.URL_CONTROLG_SESIONES).forward(request, response);
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
     * Método agrega los datos a un objeto Curso
     * @param idCurso El identificador del curso
     * @param idResponsable El identificador del responsable
     * @param estado El estado del curso
     * @param cupo El cupo del curso
     * @param tipo El tipo de curso
     * @param idAsignatura El identificador de la asignatura
     * @return El objeto curso con los datos espesificados.
     */
    private Curso addDataCurso(String idCurso, String idResponsable, String estado, String cupo, String tipo, String idAsignatura){
        Curso nuevo = new Curso();
        nuevo.setCupo(Integer.parseInt(cupo));
        nuevo.setEstado((estado==null)?"D":"E");
        nuevo.setIdAsignatura(Integer.parseInt(idAsignatura));
        nuevo.setIdCurso(Integer.parseInt(idCurso));
        nuevo.setIdResponsable(idResponsable);
        nuevo.setTipo(tipo);
        return nuevo;
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
