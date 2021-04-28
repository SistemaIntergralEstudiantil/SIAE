/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 * Esta clase representa la relzación entre el alumno y los cursos.
 * @author danielhernandezreyes
 * @version 21/04/2021A
 */
public class CursoAlumno {
    private int idCurso;
    private String estado;
    private String reporte;
    private String matricula;
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
     * Este método obtiene el estado de la petición del curso
     * @return 
     * <dl>
     *  <dt><h3>S</h3></dt><dd>Solicitado</dd>
     *  <dt><h3>R</h3></dt><dd>Rechazado</dd>
     *  <dt><h3>A</h3></dt><dd>Aceptado</dd>
     * </dl>
     */
    public String getEstado() {
        return estado;
    }
    /**
     * Este método asigna el estado de la petición del curso
     * @param estado El estado de la petición
     * <dl>
     *  <dt><h3>S</h3></dt><dd>Solicitado</dd>
     *  <dt><h3>R</h3></dt><dd>Rechazado</dd>
     *  <dt><h3>A</h3></dt><dd>Aceptado</dd>
     * </dl>
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }
    /**
     * Este método obtiene el reporte del docente para el alumno en el curso
     * @return 
     * <dl>
     *  <dt><h3>P</h3></dt><dd>Pendiente</dd>
     *  <dt><h3>R</h3></dt><dd>Reprobado</dd>
     *  <dt><h3>A</h3></dt><dd>Aprobado</dd>
     * </dl>
     */
    public String getReporte() {
        return reporte;
    }
    /**
     * Este método asigna el reporte del docente para el alumno en el curso
     * @param reporte El reporte para el alumno
     * <dl>
     *  <dt><h3>P</h3></dt><dd>Pendiente</dd>
     *  <dt><h3>R</h3></dt><dd>Reprobado</dd>
     *  <dt><h3>A</h3></dt><dd>Aprobado</dd>
     * </dl>
     */
    public void setReporte(String reporte) {
        this.reporte = reporte;
    }
    /**
     * Este método obtiene el identificador del alumno
     * @return El identificador del alumno
     */
    public String getMatricula() {
        return matricula;
    }
    /**
     * Este método asigna el identificador del alumno
     * @param matricula El identificador del alumno
     */
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    
}
