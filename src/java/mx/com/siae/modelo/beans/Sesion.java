/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

import java.sql.Time;

/**
 *
 * @author danielhernandezreyes
 */
public class Sesion {
    private int idSesion;
    private int idCurso;
    private String dia;
    private Time hora_inicio;
    private Time hora_fin;
    /**
     * Este método obtiene el identificador la sesión
     * @return El identificador de la sesión
     */
    public int getIdSesion() {
        return idSesion;
    }
    /**
     * Este método asigna el identificador de la sesión
     * @param idSesion El identificador de la sesión
     */
    public void setIdSesion(int idSesion) {
        this.idSesion = idSesion;
    }
    /**
     * Este método obtiene el identificador del curso.
     * @return El identificador del curso
     */
    public int getIdCurso() {
        return idCurso;
    }
    /**
     * Este método asigna el identificador del curso.
     * @param idCurso El identificador del curso.
     */
    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }
    /**
     * Este método obtiene el dia de la sesión.
     * @return El nombre del dia.
     * <ul><li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li></ul>
     */
    public String getDia() {
        return dia;
    }
    /**
     * Este método asigna el dia de la sesión.
     * @param dia Este es el nombre del dia
     * <ul><li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li></ul>
     */
    public void setDia(String dia) {
        this.dia = dia;
    }
    /**
     * Este método obtiene la hora de inicio la sesión.
     * @return La hora de inicio de la sesión.
     */
    public Time getHora_inicio() {
        return hora_inicio;
    }
    /**
     * Este método asigna la hora de inicio de la sesión.
     * @param hora_inicio La hora de inicio de la sesión.
     */
    public void setHora_inicio(Time hora_inicio) {
        this.hora_inicio = hora_inicio;
    }
    /**
     * Este método obtiene la hora final de la sesión.
     * @return La hora final de la sesión.
     */
    public Time getHora_fin() {
        return hora_fin;
    }
    /**
     * Este método asigna la hora final de la sesión.
     * @param hora_fin La hora final de la sesión.
     */
    public void setHora_fin(Time hora_fin) {
        this.hora_fin = hora_fin;
    }
    
    
}
