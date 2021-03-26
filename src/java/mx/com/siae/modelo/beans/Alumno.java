/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

import java.sql.Date;

/**
 * Esta clase define a los alumnos, de los usuarios que acceden al sistema.
 * @version 26/03/2021/B
 * @author Sandra Monserrat B. L.
 * @see Usuarios
 */
public class Alumno {
    private String matricula;
    private Date fechaIngreso;
    /**
     * Constructor por defecto del alumno.
     */
    public Alumno() { }
    /**
     * Constructor para asignar los valores iniciales al alumno.
     * @param matricula Este es el valor de la matrícula del alumno.
     * @param fechaIngreso Este es el valor de la fecha de ingreso del alumno.
     */
    public Alumno(String matricula, Date fechaIngreso) {
        this.matricula = matricula;
        this.fechaIngreso = fechaIngreso;
    }
    /**
     * Este método obtiene la matrícula del alumno.
     * @return El valor de la matrícula.
     */
    public String getMatricula() {
        return matricula;
    }
    /**
     * Este método asigna la matrícula al alumno.
     * @param matricula Este es el valor de la matricula.
     */
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }
    /**
     * Este método obtiene la fecha de ingreso del alumno.
     * @return La fecha de ingreso del alumno.
     */
    public Date getFechaIngreso() {
        return fechaIngreso;
    }
    /**
     * Este método asigna la fecha de ingreso del alumno.
     * @param fechaIngreso Este es el valor de la fecha de ingreso.
     */
    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }
    /**
     * Este método obtiene una cadena representativa del alumno.
     * @return La cadena que representa al objeto.
     */
    @Override
    public String toString() {
        return "Alumno { Matricula= " + matricula + ", fechaIngreso= " + fechaIngreso + '}';
    }
}
