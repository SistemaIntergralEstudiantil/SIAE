package mx.com.siae.controlador;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clave = request.getParameter("clave");
        HttpSession sesion = request.getSession();
        Session sec = new Session();
        try {
            UsuariosDAO crl;
            Usuarios user;
            switch(clave){
                case "log":
                    user = new Usuarios();
                    user.setIdUsuario(request.getParameter("idUsuario"));
                    user.setPassword(request.getParameter("contra"));
                    System.out.println(user.getIdUsuario() + user.getPassword());
                    validarData(user);
                    crl = new UsuariosDAO();
                    user = crl.iniciarSesion(user);
                    if(user != null){ // Todos lo datos obtenidos.
                        sec.setUser(user);
                        sesion.setAttribute("user", sec);
                        response.sendRedirect("session/Home.jsp");
                    } else
                        throw new Exception("Las credenciales no se encontrarón.");
                    break;
                case "exit":
                    cerrarSesion(request);
                    response.sendRedirect("Login.jsp");
                    break;
            }
        } catch (SQLException ex) {
            sesion.setAttribute("user", sec);
            sec.setErrorMsj("Error en la conexión con el SGBD:");
            sec.setErrorType(ex.toString());
            sec.setErrorUrl("/SIAE/Login.jsp");
            response.sendRedirect("error/error.jsp");
        } catch (Exception ex) {
            sesion.setAttribute("user", sec);
            sec.setErrorMsj(ex.getMessage());
            sec.setErrorType(ex.toString());
            sec.setErrorUrl("/SIAE/Login.jsp");
            response.sendRedirect("error/error.jsp");
        }
    }
    
    private void validarData(Usuarios user) throws Exception {
        if(user.getIdUsuario() == null || user.getPassword()== null )
            throw new Exception("No agrego caracteres a el usuario y/o contraseña.");
        if(user.getIdUsuario().equals("") || user.getPassword().equals("") )
            throw new Exception("No hay registro de usuario y/o contraseña.");
        if(user.getIdUsuario().length() > 12 && user.getPassword().length() > 20)
            throw new Exception("La longitud del usuario y/o contraseña son incorrectas.");
    }
    
    private void cerrarSesion(HttpServletRequest request) throws Exception{
        HttpSession sesion = request.getSession();
        Session sec = (Session) sesion.getAttribute("user");
        //crl.cerrarSesion(sec.getUser());
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
