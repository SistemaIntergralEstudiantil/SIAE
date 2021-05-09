/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 * Esta clase define a las asignaturas, que se encuentran en el sistema.
 * @version 12/04/2021A
 * @author danielhernandezreyes
 */
public class Asignatura {
    private int idAsignatura;
    private int semestre;
    private String nombre;
    private String area;
    private int credito;
    private String estado;
    private int solicitar;
    /**
     * Constructor por defecto de Asignatura.
     */
    public Asignatura() { }
    /**
     * Este método obtiene el identificador de la asignatura.
     * @return El valor del Id.
     */
    public int getIdAsignatura() {
        return idAsignatura;
    }
    /**
     * Este método asigna el identificador de la asignatura.
     * @param idAsignatura  Este es el valor del Id.
     */
    public void setIdAsignatura(int idAsignatura) {
        this.idAsignatura = idAsignatura;
    }
    /**
     * Este método obtiene el semestre al que pertenece la asignatura.
     * @return El semestre de la asignatura.
     */
    public int getSemestre() {
        return semestre;
    }
    /**
     * Este método asigna el semestre al que pertenece la asignatura.
     * @param semestre Este es del semestre.
     */
    public void setSemestre(int semestre) {
        this.semestre = semestre;
    }
    /**
     * Este método obtiene el nombre de la asignatura.
     * @return El nombre de la asignatura.
     */
    public String getNombre() {
        return nombre;
    }
    /**
     * Este método asigna el nombre de la asignatura.
     * @param nombre Este es el nombre de la asignatura.
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    /**
     * Este método obtiene el área de conocimiento<br> 
     * a la que pertenece la asignatura.
     * @return El área de conocimiento.
     */
    public String getArea() {
        return area;
    }
    /**
     * Este método asigna el área de conocimiento de la asignatura.
     * @param area Este es el área de conocimiento.
     */
    public void setArea(String area) {
        this.area = area;
    }
    /**
     * Este método obtiene los creditos la asignatura.
     * @return El credito.
     */
    public int getCredito() {
        return credito;
    }
    /**
     * Este método asigna el credito a la asignatura.<br>
     * Un valor entre 0 y 10 como maximo.
     * @param credito Este es el área de conocimiento.
     */
    public void setCredito(int credito) {
        this.credito = credito;
    }
    /**
     * Este método obtiene el estado actual la asignatura,<br>
     * en relación al semestre en curso.
     * @return El estado de la asignatura.
     */
    public String getEstado() {
        return estado;
    }
    /**
     * Este método asigna el credito a la asignatura.<br>
     * Dos posibles valores E y D.
     * <dl>
     *  <dt><h3>E</h3></dt><dd>Asignatura activa en el periodo</dd>
     *  <dt><h3>D</h3></dt><dd>Asignatura no impartida en el periodo </dd>
     * </dl>
     * @param estado Este es el estado de la materia.
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }
    /**
     * Este método obtiene la cantidad de veces que fue solicitada,<br>
     * para el curso de verano.
     * @return El número de veces solicitado.
     */
    public int getSolicitar() {
        return solicitar;
    }
    /**
     * Este método asigna el número de veces solicitada para verano.<br>
     * @param solicitar Este es el número de veces solicitada.
     */
    public void setSolicitar(int solicitar) {
        this.solicitar = solicitar;
    }
    
    
}
