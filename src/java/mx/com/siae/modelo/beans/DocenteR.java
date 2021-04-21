/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 * Esta clase representa al reporte de los docentes de la BD
 * @author danielhernandezreyes
 * @version 21/04/2021A
 */
public class DocenteR {
    private String idUsuario;
    private String nombre;
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
     * Este método obtiene el nombre del docente
     * @return El nombre del responsable.
     */
    public String getNombre() {
        return nombre;
    }
    /**
     * Este método asigna el nombre del docente.
     * @param nombre El nombre del docente.
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
}
