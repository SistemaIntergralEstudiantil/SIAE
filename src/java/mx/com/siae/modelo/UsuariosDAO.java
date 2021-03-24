/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.Usuarios;

/**
 *
 * @author sandr
 */
public class UsuariosDAO {
    
    private boolean buscarV(Usuarios bus) throws SQLException, Exception{
        String sql = "select idUsuario tipo from Usuarios where idUsuario like ?;";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setString(1, bus.getIdUsuario());
        cn.setResultado(cn.getEstado().executeQuery());
        boolean estado = false;
        while(cn.getResultado().next()){
            estado = true;
            break;
        }
        if(estado){
            cn.getEstado().close();
            cn.getConexion().close();
            return true;
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return false;
    }
    
    public boolean nuevoUsuario(Usuarios user) throws SQLException, Exception{
        String sql_0 = "insert into usuarios values (?, ?, ?, ?, ?, ?, ?, ?, ?);";
        boolean estado = buscarV(user);
        if(!estado){
            Conexion cn = new Conexion();
            cn.conectar();
            cn.conectar();
            cn.prepareStatement(sql_0);
            cn.getEstado().setString(1, user.getIdUsuario());
            cn.getEstado().setString(2, user.getNombre1());
            cn.getEstado().setString(3, user.getNombre2());
            cn.getEstado().setString(4, user.getNombre3());
            cn.getEstado().setString(5, user.getApellidoPat());
            cn.getEstado().setString(6, user.getApellidoMat());
            cn.getEstado().setString(7, user.getCorreo_inst());
            cn.getEstado().setString(8, user.getRol());
            cn.getEstado().setString(9, user.getContraseña());
            cn.getEstado().executeUpdate();
            cn.getEstado().close();
            cn.getConexion().close();
            return true;
        }
        return false;
        
    }
    
    public ArrayList<Usuarios> buscar(Usuarios bus) throws SQLException, Exception{
        String sql = "select idUsuario, nombre1, nombre2, nombre3, ApellidoPat, ApellidoMat, correo_inst, rol, contraseña from usuarios where idUsuario like ?;";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setString(1, bus.getIdUsuario());
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<Usuarios> list = new ArrayList<>();
        while(cn.getResultado().next()){
            Usuarios u = new Usuarios();
            u.setIdUsuario(cn.getResultado().getString("idUsuario"));
            u.setNombre1(cn.getResultado().getString("nombre1"));
            u.setNombre2(cn.getResultado().getString("nombre2"));
            u.setNombre3(cn.getResultado().getString("nombre3"));
            u.setApellidoPat(cn.getResultado().getString("ApellidoPat"));
            u.setApellidoMat(cn.getResultado().getString("ApellidoMat"));
            u.setCorreo_inst(cn.getResultado().getString("correo_inst"));
            u.setRol(cn.getResultado().getString("rol"));
            u.setContraseña(cn.getResultado().getString("contraseña"));
            list.add(u);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return list;
        
    }
    
    public Usuarios iniciarSesion(Usuarios user) throws SQLException, Exception{
        String sql = "CALL proce_iniciar_sesion(?, ?)";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setString(1, user.getIdUsuario());
        cn.getEstado().setString(2, user.getContraseña());
        cn.setResultado(cn.getEstado().executeQuery());
        if(cn.getResultado().next()){
            if(cn.getResultado().getInt("act") == 1){
                user.setNombre1(cn.getResultado().getString("nombre1"));
                user.setNombre2(cn.getResultado().getString("nombre2"));
                user.setNombre3(cn.getResultado().getString("nombre3"));
                user.setApellidoPat(cn.getResultado().getString("ApellidoPat"));
                user.setApellidoMat(cn.getResultado().getString("ApellidoMat"));
                user.setCorreo_inst(cn.getResultado().getString("correo_inst"));
                user.setRol(cn.getResultado().getString("rol"));
                user.setContraseña(cn.getResultado().getString("contraseña"));
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

    public Usuarios buscarU(Usuarios bus) throws SQLException, Exception{
        String sql = "select idUsuario, nombre1, nombre2, nombre3, ApellidoPat, ApellidoMat, correo_inst, rol, contraseña from usuarios where idUsuario = ?;";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setString(1, bus.getIdUsuario());
        cn.setResultado(cn.getEstado().executeQuery());
        while(cn.getResultado().next()) {
            bus.setNombre1(cn.getResultado().getString("nombre1"));
            bus.setNombre2(cn.getResultado().getString("nombre2"));
            bus.setNombre3(cn.getResultado().getString("nombre3"));
            bus.setApellidoPat(cn.getResultado().getString("ApellidoPat"));
            bus.setApellidoMat(cn.getResultado().getString("ApellidoMat"));
            bus.setCorreo_inst(cn.getResultado().getString("correo_inst"));
            bus.setRol(cn.getResultado().getString("rol"));
            bus.setContraseña(cn.getResultado().getString("contraseña"));
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return bus;
    }
    
}
