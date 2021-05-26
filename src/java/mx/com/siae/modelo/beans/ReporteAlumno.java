/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 *
 * @author danielhernandezreyes
 */
public class ReporteAlumno {
    private int idCurso;
    private String tipo;
    private int credito;
    private String estado;
    private String oportunidad;
    private int idAsignatura;
    private String asignatura;
    private String matricula;
    private String alumno;
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
     * Este método obtiene el estado de solicitud del alumno respecto al curso.
     * @return El estado del alumno respecto al curso
     * <dl>
     *  <dt><h3>SA</h3></dt><dd>Solicitud de alta</dd>
     *  <dt><h3>SB</h3></dt><dd>Solicitud de baja</dd>
     * </dl>
     */
    public String getEstado() {
        return estado;
    }
    /**
     * Este método asigna el estado de solicitud del alumno respecto al curso.
     * @param estado El estado del alumno
     * <dl>
     *  <dt><h3>SA</h3></dt><dd>Solicitud de alta</dd>
     *  <dt><h3>SB</h3></dt><dd>Solicitud de baja</dd>
     * </dl>
     */
    public void setEstado(String estado) {
        this.estado = estado;
    }
    /**
     * Este método obtiene el identificador de la asignatura asignada al curso.
     * @return El identificador de la asignatura.
     */
    public int getIdAsignatura() {
        return idAsignatura;
    }
    /**
     * Este método asigna el identificador de la asignatura asignada al curso.
     * @param idAsignatura Este es el identificador de la asignatura.
     */
    public void setIdAsignatura(int idAsignatura) {
        this.idAsignatura = idAsignatura;
    }
    /**
     * Este método obtiene el nombre de la asignatura asignada del curso
     * @return El nombre de la asignatura del curso.
     */
    public String getAsignatura() {
        return asignatura;
    }
    /**
     * Este método asigna el nombre de la asignatura asignada del curso.
     * @param asignatura El nombre de la asignatura del curso.
     */
    public void setAsignatura(String asignatura) {
        this.asignatura = asignatura;
    }
    /**
     * Este método obtiene el identificador del alumno.
     * @return El identificador del alumno.
     */
    public String getMatricula() {
        return matricula;
    }
    /**
     * Este método asigna el identificador del responsable del curso.
     * @param matricula Este es el identificador del responsable.
     */
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    /**
     * Este método obtiene el nombre del alumno.
     * @return El nombre del responsable.
     */
    public String getAlumno() {
        return alumno;
    }
    /**
     * Este método asigna el nombre del alumno.
     * @param alumno El nombre del alumno.
     */
    public void setAlumno(String alumno) {
        this.alumno = alumno;
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

    public String getOportunidad() {
        return oportunidad;
    }

    public void setOportunidad(String oportunidad) {
        this.oportunidad = oportunidad;
    }
    
}
