/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 * Esta clase representa un reporte del curso de cada asignatura.
 * @version 12/04/2021A
 * @author danielhernandezreyes
 */
public class ReporteAsig {
    private String idCurso;
    private int cupo;
    private String dia;
    private String horario;
    private String asignatura;
    private int credito;
    private String docente;
    private int semestre;
    /**
     * Constructor por defecto de ReporteAsig.
     */
    public ReporteAsig() { }
    /**
     * Este método obtiene el identificador del curso.
     * @return El id del curso.
     */
    public String getIdCurso() {
        return idCurso;
    }
    /**
     * Este método asigna el identificador del curso.
     * @param idCurso Este es el Id del curso.
     */
    public void setIdCurso(String idCurso) {
        this.idCurso = idCurso;
    }
    /**
     * Este método obtiene el cupo actual de alumnos del curso.
     * @return El semestre de la asignatura.
     */
    public int getCupo() {
        return cupo;
    }
    /**
     * Este método asigna el cupo de alumnos del curso.
     * @param cupo La cantidad de lugares del curso.
     */
    public void setCupo(int cupo) {
        this.cupo = cupo;
    }
    /**
     * Este método obtiene el dia del curso.
     * @return El dia del curso.
     * <ul>
     * <li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li>
     * </ul>
     */
    public String getDia() {
        return dia;
    }
    /**
     * Este método asigna el dia del curso.
     * @param dia El dia del curso.
     * <ul>
     * <li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li>
     * </ul>
     */
    public void setDia(String dia) {
        this.dia = dia;
    }
    /**
     * Este método obtiene el rango del tiempo del curso.
     * @return El rango de la asesoria.<br>
     * HoraInicio - HoraFin (en formato de 24 horas)
     */
    public String getHorario() {
        return horario;
    }
    /**
     * Este método asigna el rango del horario del curso.
     * @param horario El rango en formato de 24 horas.<br>
     * HoraInicio - HoraFin
     */
    public void setHorario(String horario) {
        this.horario = horario;
    }
    /**
     * Este método obtiene el nombre de la asignatura.
     * @return El nombre de la asignatura.
     */
    public String getAsignatura() {
        return asignatura;
    }
    /**
     * Este método asigna el nombre de la asignatura.
     * @param asignatura El nombre de la asignatura.
     */
    public void setAsignatura(String asignatura) {
        this.asignatura = asignatura;
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
     * Este método obtiene el nombre del docente que imparte la asignatura.
     * @return El nombre del docente.
     */
    public String getDocente() {
        return docente;
    }
    /**
     * Este método asigna el nombre del docente que imparte la asignatura.
     * @param docente El nombre del docente.
     */
    public void setDocente(String docente) {
        this.docente = docente;
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
    
    
}
