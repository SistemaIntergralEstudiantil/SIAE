/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import mx.com.siae.modelo.beans.Usuarios;

/**
 * Esta clase define las operaciones de los usuarios a la base de datos.
 * @version 26/03/2021/C
 * @author Sandra Monserrat B. L.
 * @see Conexion
 * @see Usuarios
 */
public class UsuariosDAO {
    
    /**
     * Método obtiene el usuario: el cual iniciara sesión dentro del sistema.
     * @param user El usuario con los datos de inicio.
     * @return
     * <dl>
     *  <dt><h3>Objeto Usuario</h3></dt><dd>El usuario con todos los datos del usuario.</dd>
     *  <dt><h3>null</h3></dt><dd>No se encontro el usuario.</dd>
     * </dl>
     * @throws SQLException Excepción al realizar la conexión con la BD.
     * @throws java.lang.ClassNotFoundException Excepción al establecer el conector.
     */
    public Usuarios iniciarSesion(Usuarios user) throws SQLException, ClassNotFoundException{
        String sql = "CALL proce_iniciar_sesion(?, ?)";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setString(1, user.getIdUsuario());
        cn.getEstado().setString(2, user.getPassword());
        cn.setResultado(cn.getEstado().executeQuery());
        if(cn.getResultado().next()){
            if(cn.getResultado().getInt("act") == 1){
                user.setNombre1(cn.getResultado().getString("nombre_1"));
                user.setNombre2(cn.getResultado().getString("nombre_2"));
                user.setNombre3(cn.getResultado().getString("nombre_3"));
                user.setApellidoPat(cn.getResultado().getString("apellido_pat"));
                user.setApellidoMat(cn.getResultado().getString("apellido_mat"));
                user.setCorreo_inst(cn.getResultado().getString("correo_inst"));
                user.setRol(cn.getResultado().getString("rol"));
                user.setPassword(cn.getResultado().getString("contra"));
                user.setSemestre(cn.getResultado().getInt("sem"));
                user.aFoto = cn.getResultado().getBytes("foto");
                cn.getEstado().close();
                cn.getConexion().close();
                return user;
            } else {
                cn.getEstado().close();
                cn.getConexion().close();
                return null;
            }
        }else{
            cn.getEstado().close();
            cn.getConexion().close();
            return null;
        }
    }

    
}
