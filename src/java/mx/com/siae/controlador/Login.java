package mx.com.siae.controlador;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Arrays;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.com.siae.modelo.Session;
import mx.com.siae.modelo.UsuariosDAO;
import mx.com.siae.modelo.beans.Usuarios;
import org.apache.tomcat.util.codec.binary.Base64;

/**
 *
 * @author sandr
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {
    
    private final Key key = new SecretKeySpec("}u#n@c]l{&v4-D3E16$<yt_>s[".getBytes(),  0, 16, "AES");
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
            switch(clave){
                case "log":
                    Usuarios user = new Usuarios();
                    user.setIdUsuario(request.getParameter("idUsuario"));
                    user.setPassword(request.getParameter("contra"));
                    validarData(user);
                    // Encriptar contraseña
                    //encriptar(user);
                    
                    UsuariosDAO crl = new UsuariosDAO();
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
                    request.getRequestDispatcher("Login.jsp").forward(request, response);
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
            sec.setErrorType("java.lang.Exception");
            sec.setErrorUrl("/SIAE/Login.jsp");
            response.sendRedirect("error/error.jsp");
        }
    }
    /**
     * Este método valida los datos enviados por el usuario.
     * @param user El objeto usuario creado para la sesión.
     * @throws Exception Cuando no hay datos en el usuario y contraseña.
     */
    private void validarData(Usuarios user) throws Exception {
        if(user.getIdUsuario() == null || user.getPassword() == null )
            throw new Exception("No agrego caracteres a el usuario y/o contraseña.");
        if(user.getIdUsuario().equals("") || user.getPassword().equals("") )
            throw new Exception("No hay registro de usuario y/o contraseña.");
        if(user.getIdUsuario().length() > 20 && user.getPassword().length() > 20)
            throw new Exception("La longitud del usuario y/o contraseña son incorrectas.");
    }
    /**
     * Este método cierra la sesión del usuario dentro del servidor.
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
    
    
    private void encriptar(Usuarios user) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        String pass = user.getPassword();
        Cipher aes = Cipher.getInstance("AES/ECB/PKCS5Padding");
        aes.init(Cipher.ENCRYPT_MODE, key);
        byte[] encriptado = aes.doFinal(pass.getBytes());
        String tempPass = "";
        for (byte b : encriptado) {
           tempPass += Integer.toHexString(0xFF & b);
        }
        System.out.println(tempPass);
        // user.setPassword(tempPass);
    }
}
