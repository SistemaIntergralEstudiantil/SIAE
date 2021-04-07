/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import mx.com.siae.modelo.beans.Usuarios;

/**
 * Clase que representa la Sesión establecida por un usuario dentro de un navegador.
 * @version 07/04/2021/B
 * @author sandr
 */
public class Session {
    private Usuarios user;
    private String errorMsj;
    private String errorType;
    private String errorUrl;
    /**
     * Constructor de la clase por defecto. No hay datos agregados.
     */
    public Session() { }
    /**
     * Constructor de la clase para agregar datos por defecto.
     * @param user El usuario de la sesión.
     */
    public Session(Usuarios user) {
        this.user = user;
    }
    /**
     * Método obtener el usuario de la sesión.
     * @return El usuario.
     */
    public Usuarios getUser() {
        return user;
    }
    /**
     * Método asignar el usuario de la sesión.
     * @param user El usuario.
     */
    public void setUser(Usuarios user) {
        this.user = user;
    }
    /**
     * Método asigna el mensaje de error dentro de la sesión.<br>
     * <h3>Error</h3>
     * <dl>
     *  <dt><h3>Tipo:</h3></dt><dd>La excepción ocurrida.</dd>
     *  <dt><h3>Mensaje:</h3></dt><dd>Personalizado.</dd>
     *  <dt><h3>Url:</h3></dt><dd>Dirección de la redirección.</dd>
     * </dl><br>
     * <h3>Mensaje</h3>
     * <p>Mensaje personalizado para cada caso, espesifica el tipo error para el usuario.</p>
     * @return El mensaje de error.
     */
    public String getErrorMsj() {
        return errorMsj;
    }
    /**
     * Método obtiene el mensaje de error de la sesión.<br>
     * <h3>Mensaje</h3>
     * <p>Mensaje personalizado para cada caso, espesifica el tipo error para el usuario.</p>
     * @param errorMsj El mensaje de error.
     */
    public void setErrorMsj(String errorMsj) {
        this.errorMsj = errorMsj;
    }
    /**
     * Método obtiene el tipo del error ocurrido dentro de la sesión.<br>
     * <h3>Error</h3>
     * <dl>
     *  <dt><h3>Tipo:</h3></dt><dd>La excepción ocurrida.</dd>
     *  <dt><h3>Mensaje:</h3></dt><dd>Personalizado.</dd>
     *  <dt><h3>Url:</h3></dt><dd>Dirección de la redirección.</dd>
     * </dl><br>
     * <h3>Tipo</h3>
     * <p>Espesifica el tipo de excepción ocurrida dentro de la sesión (La excepción encontrada).</p>
     * @return El tipo de error.
     */
    public String getErrorType() {
        return errorType;
    }
    /**
     * Método asigna el tipo de error dentro de la sesión.<br>
     * <h3>Tipo</h3>
     * <p>Espesifica el tipo de excepción ocurrida dentro de la sesión (La excepción encontrada).</p>
     * @param errorType El tipo de error.
     */
    public void setErrorType(String errorType) {
        this.errorType = errorType;
    }
    /**
     * Método obtiene la dirección de redirección despues de presentar el error.<br>
     * <h3>Error</h3>
     * <dl>
     *  <dt><h3>Tipo:</h3></dt><dd>La excepción ocurrida.</dd>
     *  <dt><h3>Mensaje:</h3></dt><dd>Personalizado.</dd>
     *  <dt><h3>Url:</h3></dt><dd>Dirección de la redirección.</dd>
     * </dl><br>
     * <h3>Url</h3>
     * <p>La dirección a la cual se redireccionara el usuario, despues de presentar el error al usuario.</p>
     * @return La dirección de redirección.
     */
    public String getErrorUrl() {
        return errorUrl;
    }
    /**
     * Método asigna la direción de redirección despues de presentar el error.<br>
     * <h3>Url</h3>
     * <p>La dirección a la cual se redireccionara el usuario, despues de presentar el error al usuario.</p>
     * @param errorUrl La dirección de redirección.
     */
    public void setErrorUrl(String errorUrl) {
        this.errorUrl = errorUrl;
    }
    
}
