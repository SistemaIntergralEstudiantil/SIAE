/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

import java.sql.Time;

/**
 * Esta clase define a las Áreas de Apoyo registradas en la BD.
 * @version 12/04/2021A
 * @author danielhernandezreyes
 */
public class AreaApoyo {
    private int idAreasApoyo;
    private String nombre;
    private String url;
    private String dia;
    private Time hora_inicio;
    private Time hora_fin;
    private String codigo;
    private String estado;
    private String idResponsable;
    private int idAsignatura;
    /**
     * Este método obtiene el identificador de la área de apoyo.
     * @return El valor del identificador.
     */
    public int getIdAreasApoyo() {
        return idAreasApoyo;
    }
    /**
     * Este método asigna el identificador de la área de apoyo.
     * @param idAreasApoyo Este es el valor del identificador.
     */
    public void setIdAreasApoyo(int idAreasApoyo) {
        this.idAreasApoyo = idAreasApoyo;
    }
    /**
     * Este método obtiene el nombre asignado al tipo de área de apoyo.
     * @return El valor del identificador.
     */
    public String getNombre() {
        return nombre;
    }
    /**
     * Este método asigna el nombre al tipo de área de apoyo.
     * @param nombre Este es el nombre del tipo de área.
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    /**
     * Este método obtiene el url del área de apoyo.
     * @return El url del área de apoyo.
     */
    public String getUrl() {
        return url;
    }
    /**
     * Este método asigna el url del área de apoyo.
     * @param url Este es el url del área de apoyo.
     */
    public void setUrl(String url) {
        this.url = url;
    }
    /**
     * Este método obtiene el dia de atención del área de apoyo.
     * @return El nombre del dia.
     * <ul><li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li></ul>
     */
    public String getDia() {
        return dia;
    }
    /**
     * Este método asigna el dia de atención del área de apoyo.
     * @param dia Este es el nombre del dia
     * <ul><li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li></ul>
     */
    public void setDia(String dia) {
        this.dia = dia;
    }
    /**
     * Este método obtiene la hora de inicio de atención de la área de apoyo.
     * @return La hora de inicio de atención.
     */
    public Time getHora_inicio() {
        return hora_inicio;
    }
    /**
     * Este método asigna la hora de inicio de atención del área de apoyo.
     * @param hora_inicio La hora de inicio de atención.
     */
    public void setHora_inicio(Time hora_inicio) {
        this.hora_inicio = hora_inicio;
    }
    /**
     * Este método obtiene la hora final de atención de la área de apoyo.
     * @return La hora final de atención.
     */
    public Time getHora_fin() {
        return hora_fin;
    }
    /**
     * Este método asigna la hora final de atención del área de apoyo.
     * @param hora_fin La hora final de atención.
     */
    public void setHora_fin(Time hora_fin) {
        this.hora_fin = hora_fin;
    }
    /**
     * Este método obtiene el codigo del enlace del área de apoyo.
     * @return El codigo de enlace.
     */
    public String getCodigo() {
        return codigo;
    }
    /**
     * Este método asigna la hora final de atención del área de apoyo.
     * @param codigo Este es el codigo de enlace.
     */
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }
    /**
     * Este método obtiene el identificador del responsable del área de apoyo.
     * @return El identificador del responsable.
     */
    public String getIdResponsable() {
        return idResponsable;
    }
    /**
     * Este método asigna el identificador del responsable del área de apoyo.
     * @param idResponsable Este es el identificador del responsable.
     */
    public void setIdResponsable(String idResponsable) {
        this.idResponsable = idResponsable;
    }
    /**
     * Este método obtiene el identificador de la asignatura asignada al área de apoyo.
     * @return El identificador de la asignatura.
     */
    public int getIdAsignatura() {
        return idAsignatura;
    }
    /**
     * Este método asigna el identificador de la asignatura asignada al área de apoyo.
     * @param idAsignatura Este es el identificador de la asignatura.
     */
    public void setIdAsignatura(int idAsignatura) {
        this.idAsignatura = idAsignatura;
    }
    /**
     * Este método obtiene el estado del área de apoyo
     * @return 
     * <dl>
     *  <dt><h3>E</h3></dt><dd>Habilitada</dd>
     *  <dt><h3>D</h3></dt><dd>Desabilitada</dd>
     * </dl>
     */
    public String getEstado() {
        return estado;
    }
    /**
     * Este método asigna el estado del área de apoyo
     * @param estado El estado del área
     * <dl>
     *  <dt><h3>E</h3></dt><dd>Habilitada</dd>
     *  <dt><h3>D</h3></dt><dd>Desabilitada</dd>
     * </dl>
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }
    
}
