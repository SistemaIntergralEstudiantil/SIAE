package mx.com.siae.controlador;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.siae.conector.config.Url;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.UsuariosDAO;
import mx.com.siae.modelo.beans.Usuarios;

/**
 *
 * @author sandr
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {
    
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String clave = request.getParameter("clave");
        HttpSession sesion = request.getSession();
        Session sec = new Session();
        try {
            switch(clave){
                case "log":
                    Usuarios user = new Usuarios();
                    user.setIdUsuario(request.getParameter("idUsuario"));
                    user.setPassword(request.getParameter("contra"));
                    validarData(user);
                    UsuariosDAO crl = new UsuariosDAO();
                    user = crl.iniciarSesion(user);
                    if(user != null){ // Todos lo datos obtenidos.
                        sec.setUser(user);
                        sesion.setAttribute("user", sec);
                        response.sendRedirect(Url.URL_HOME);
                    } else
                        throw new Exception("Las credenciales no se encontrar??n.");
                    break;
                case "exit":
                    cerrarSesion(request);
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
                    break;
            }
        } catch (SQLException ex) {
            sesion.setAttribute("user", sec);
            sec.setErrorMsj("Error en la conexi??n con el SGBD:");
            sec.setErrorType(ex.toString());
            sec.setErrorUrl(Url.URL_LOGIN);
            response.sendRedirect(Url.URL_ERROR);
        } catch (Exception ex) {
            sesion.setAttribute("user", sec);
            sec.setErrorMsj(ex.getMessage());
            sec.setErrorType("java.lang.Exception");
            sec.setErrorUrl(Url.URL_LOGIN);
            response.sendRedirect(Url.URL_ERROR);
        }
    }
    /**
     * Este m??todo valida los datos enviados por el usuario.
     * @param user El objeto usuario creado para la sesi??n.
     * @throws Exception Cuando no hay datos en el usuario y contrase??a.
     */
    private void validarData(Usuarios user) throws Exception {
        if(user.getIdUsuario() == null || user.getPassword() == null )
            throw new Exception("No agrego caracteres a el usuario y/o contrase??a.");
        if(user.getIdUsuario().equals("") || user.getPassword().equals("") )
            throw new Exception("No hay registro de usuario y/o contrase??a.");
        if(user.getIdUsuario().length() > 20 && user.getPassword().length() > 20)
            throw new Exception("La longitud del usuario y/o contrase??a son incorrectas.");
    }
    /**
     * Este m??todo cierra la sesi??n del usuario dentro del servidor.
     * @param request servelt request
     */
    private void cerrarSesion(HttpServletRequest request) {
        HttpSession sesion = request.getSession();
        sesion.invalidate();
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
