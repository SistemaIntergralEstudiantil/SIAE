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
    /**
     * Este método obtiene el identificador del usuario.
     * @return El valor del identificador.
     */
    public String getIdUsuario() {
        return idUsuario;
    }
    /**
     * Este método asigna el identificador del usuario.
     * @param idUsuario Este es el valor de identificador.
     */
    public void setIdUsuario(String idUsuario) {
        this.idUsuario = idUsuario;
    }
    /**
     * Este método obtiene el 1° nombre del usuario.
     * @return El valor del 1° nombre.
     */
    public String getNombre1() {
        return nombre1;
    }
    /**
     * Este método asina el 1° nombre del usuario.
     * @param nombre1 Este es el 1° nombre.
     */
    public void setNombre1(String nombre1) {
        this.nombre1 = nombre1;
    }
    /**
     * Este método obtiene el 2° nombre del usuario.
     * @return El valor del 2° nombre.
     */
    public String getNombre2() {
        return nombre2;
    }
    /**
     * Este método asina el 1° nombre del usuario.
     * @param nombre2 Este es el 1° nombre.
     */
    public void setNombre2(String nombre2) {
        this.nombre2 = nombre2;
    }
    /**
     * Este método obtiene el 3° nombre del usuario.
     * @return El valor del 3° nombre.
     */
    public String getNombre3() {
        return nombre3;
    }
    /**
     * Este método asina el 3° nombre del usuario.
     * @param nombre3 Este es el 3° nombre.
     */
    public void setNombre3(String nombre3) {
        this.nombre3 = nombre3;
    }
    /**
     * Este método obtiene el apellido paterno del usuario.
     * @return El apellido paterno.
     */
    public String getApellidoPat() {
        return ApellidoPat;
    }
    /**
     * Este método asigna el apellido paterno del usuario.
     * @param ApellidoPat Este es el valor del apellido paterno.
     */
    public void setApellidoPat(String ApellidoPat) {
        this.ApellidoPat = ApellidoPat;
    }
    /**
     * Este método obtiene el apellido materno del usuario.
     * @return El apellido materno.
     */
    public String getApellidoMat() {
        return ApellidoMat;
    }
    /**
     * Este método asigna el apellido materno del usuario.
     * @param ApellidoMat Este es el valor del apellido materno.
     */
    public void setApellidoMat(String ApellidoMat) {
        this.ApellidoMat = ApellidoMat;
    }
    /**
     * Este método obtiene el correo del usuario.
     * @return El valor del correo.
     */
    public String getCorreo_inst() {
        return correo_inst;
    }
    /**
     * Este método signa el correo del usuario.
     * @param correo_inst Este es el valor del correo.
     */
    public void setCorreo_inst(String correo_inst) {
        this.correo_inst = correo_inst;
    }
    /**
     * Este método obtiene el rol del usuario.
     * @return El valor del rol.
     */
    public String getRol() {
        return rol;
    }
    /**
     * Este método asigna el valor del rol del usuario.
     * @param rol Este es el valor del rol.
     */
    public void setRol(String rol) {
        this.rol = rol;
    }
    /**
     * Este método obtiene el valor de la contraseña del usuario.
     * @return El valor de la contraseña.
     */
    public String getPassword() {
        return password;
    }
    /**
     * Este método signa el valor la contraseña del usuario.
     * @param password Este es el valor de la contraseña.
     */
    public void setPassword(String password) {
        this.password = password;
    }
    /**
     * Este método obtiene una cadena representativa del usuario.
     * @return La cadena que representa al objeto.
     */
    @Override
    public String toString() {
        String name = "nombre1= " + nombre1 + ", nombre2= " + nombre2 + ", nombre3= " + nombre3;
        return "Usuarios {idUsuario= " + idUsuario + ", " + name + ", ApellidoPat= " 
                + ApellidoPat + ", ApellidoMat= " + ApellidoMat 
                + ", correo_inst= " + correo_inst + ", rol= " + rol 
                + ", password= " + password + '}';
    }
    
    
    
}
