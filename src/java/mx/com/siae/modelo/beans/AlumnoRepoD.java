/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 * Esta clase representa el reporte de los alumnos registrados en un curso.
 * @author danielhernandezreyes
 * @version 21/04/2021A
 */
public class AlumnoRepoD {
    private int idCurso;
    private String tipo;
    private String matricula;
    private String alumno;
    private int idAsignatura;
    private String asignatura;
    private int semestre;
    private String reporte;
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
     * Este método obtiene el tipo de curso
     * @return El tipo del curso
     * <dl>
     *  <dt><h3>V</h3></dt><dd>Curso de verano</dd>
     *  <dt><h3>O</h3></dt><dd>Curso ordinal</dd>
     * </dl>
     */
    public String getTipo() {
        return tipo;
    }
    /**
     * Este método asigna el tipo del curso.
     * @param tipo 
     * <dl>
     *  <dt><h3>V</h3></dt><dd>Curso de verano</dd>
     *  <dt><h3>O</h3></dt><dd>Curso ordinal</dd>
     * </dl>
     */
    public void setTipo(String tipo) {
        this.tipo = tipo;
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
    /**
     * Este método obtiene el nombre del alumno,
     * @return El nombre del alumno
     */
    public String getAlumno() {
        return alumno;
    }
    /**
     * Este método asigna el nombre del alumno
     * @param alumno El nombr
     */
    public void setAlumno(String alumno) {
        this.alumno = alumno;
    }
    /**
     * Este método obtiene el identificador de la asignatura.
     * @return El identificador de la asignatura.
     */
    public int getIdAsignatura() {
        return idAsignatura;
    }
    /**
     * Este método asigna el identificador de la asignatura.
     * @param idAsignatura Este es el identificador de la asignatura.
     */
    public void setIdAsignatura(int idAsignatura) {
        this.idAsignatura = idAsignatura;
    }
    /**
     * Este método obtiene el nombre de la asignatura
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
     * Este método obtiene el semestre de la materia
     * @return el semestre de la materia
     */
    public int getSemestre() {
        return semestre;
    }
    /**
     * Este método asigna el semestre de la materia.
     * @param semestre Es semestre de la materia
     */
    public void setSemestre(int semestre) {
        this.semestre = semestre;
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
    
}
