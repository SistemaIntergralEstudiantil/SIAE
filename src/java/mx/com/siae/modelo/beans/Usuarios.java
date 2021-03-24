/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 *
 * @author sandr
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
    private String contraseña;

    public Usuarios() {
    }

    public Usuarios(String idUsuario, String nombre1, String nombre2, String nombre3, String ApellidoPat, String ApellidoMat, String correo_inst, String rol, String contraseña) {
        this.idUsuario = idUsuario;
        this.nombre1 = nombre1;
        this.nombre2 = nombre2;
        this.nombre3 = nombre3;
        this.ApellidoPat = ApellidoPat;
        this.ApellidoMat = ApellidoMat;
        this.correo_inst = correo_inst;
        this.rol = rol;
        this.contraseña = contraseña;
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

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }
    
    
    
}
