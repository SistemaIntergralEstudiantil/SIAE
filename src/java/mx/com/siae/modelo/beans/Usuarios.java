/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 * Esta clase define a todos los usuarios que acceden al sistema.
 * @version 26/03/2021/B
 * @author Sandra Monserrat B. L.
 */
public class Usuarios {
    private String idUsuario;
    private String nombre1;
    private String nombre2;
    private String nombre3;
    private String ApellidoPat;
    private String ApellidoMat;
    private String correo_inst;
    private String rol;
    private String password;
    /**
     * Constructor por defecto del usuario.
     */
    public Usuarios() {
    }
    /**
     * Constructor para asignar los valores iniciales al usuario.
     * @param idUsuario Este es el valor del identificador del usuario
     * @param nombre1 Este es el valor del 1° nombre del usuario.
     * @param nombre2 Este es el valor del 2° nombre del usuario.
     * @param nombre3 Este es el valor del 3° nombre del usuario.
     * @param ApellidoPat Este es el valor del apellido paterno del usuario.
     * @param ApellidoMat Este es el valor del apellido materno del usuario
     * @param correo_inst Este es el valor del correo del usuario.
     * @param rol Este es el valor del rol del usuario.
     * @param password Este es el valor de la contraseña del usuario.
     */
    public Usuarios(String idUsuario, String nombre1, String nombre2, String nombre3, String ApellidoPat, String ApellidoMat, String correo_inst, String rol, String password) {
        this.idUsuario = idUsuario;
        this.nombre1 = nombre1;
        this.nombre2 = nombre2;
        this.nombre3 = nombre3;
        this.ApellidoPat = ApellidoPat;
        this.ApellidoMat = ApellidoMat;
        this.correo_inst = correo_inst;
        this.rol = rol;
        this.password = password;
    }

    public String getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(String idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre1() {
        return nombre1;
    }

    public void setNombre1(String nombre1) {
        this.nombre1 = nombre1;
    }

    public String getNombre2() {
        return nombre2;
    }

    public void setNombre2(String nombre2) {
        this.nombre2 = nombre2;
    }

    public String getNombre3() {
        return nombre3;
    }

    public void setNombre3(String nombre3) {
        this.nombre3 = nombre3;
    }

    public String getApellidoPat() {
        return ApellidoPat;
    }

    public void setApellidoPat(String ApellidoPat) {
        this.ApellidoPat = ApellidoPat;
    }

    public String getApellidoMat() {
        return ApellidoMat;
    }

    public void setApellidoMat(String ApellidoMat) {
        this.ApellidoMat = ApellidoMat;
    }

    public String getCorreo_inst() {
        return correo_inst;
    }

    public void setCorreo_inst(String correo_inst) {
        this.correo_inst = correo_inst;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    
    
}
