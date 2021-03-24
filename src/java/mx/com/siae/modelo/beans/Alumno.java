/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

import java.sql.Date;

/**
 *
 * @author sandr
 */
public class Alumno {
    private String matricula;
    private Date fechaIngreso;

    public Alumno() {
    }

    public Alumno(String matricula, Date fechaIngreso) {
        this.matricula = matricula;
        this.fechaIngreso = fechaIngreso;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }
    
    
}
