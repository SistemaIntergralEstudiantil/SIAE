/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.DocenteR;
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
                user.setNumTel(cn.getResultado().getString("numTel"));
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
    /**
     * Método obtiene un lista de todos las docentes que estan registrados<br>
     * en la base de datos.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista de las docentes.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>No hay docentes registrados.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<DocenteR> reporteDocentes() throws SQLException, ClassNotFoundException {
        String sql = "CALL proce_consulta_docente()";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<DocenteR> t = new ArrayList<>();
        while(cn.getResultado().next()){
            DocenteR a = new DocenteR();
            a.setIdUsuario(cn.getResultado().getString("idUsuario") );
            a.setNombre( cn.getResultado().getString("nombre") );
            t.add(a);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    /**
     * Método cambia los datos del usaurio<br>
     * @param user Datos del a modificar
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void changeDataUser(Usuarios user) throws SQLException, ClassNotFoundException {
        String sql = "{CALL proce_update_usuario(?, ?)}";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareCallable(sql);
        cn.getEstadoProce().setString(1, user.getIdUsuario());
        cn.getEstadoProce().setBlob(2, user.gFoto);
        cn.getEstadoProce().executeUpdate();
        cn.getEstadoProce().close();
        cn.getConexion().close();
    }
}
