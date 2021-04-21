/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

import java.sql.Time;

/**
 * Esta clase define a las Asesorias registradas en la BD.
 * @version 12/04/2021A
 * @author danielhernandezreyes
 */
public class Asesoria {
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
     * Este método obtiene el identificador de la Asesoria.
     * @return El valor del identificador.
     */
    public int getIdAreasApoyo() {
        return idAreasApoyo;
    }
    /**
     * Este método asigna el identificador de la Asesoria.
     * @param idAreasApoyo Este es el valor del identificador.
     */
    public void setIdAreasApoyo(int idAreasApoyo) {
        this.idAreasApoyo = idAreasApoyo;
    }
    /**
     * Este método obtiene el identificador de la Asesoria.
     * @return El valor del identificador.
     */
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public Time getHora_inicio() {
        return hora_inicio;
    }

    public void setHora_inicio(Time hora_inicio) {
        this.hora_inicio = hora_inicio;
    }

    public Time getHora_fin() {
        return hora_fin;
    }

    public void setHora_fin(Time hora_fin) {
        this.hora_fin = hora_fin;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getIdResponsable() {
        return idResponsable;
    }

    public void setIdResponsable(String idResponsable) {
        this.idResponsable = idResponsable;
    }

    public int getIdAsignatura() {
        return idAsignatura;
    }

    public void setIdAsignatura(int idAsignatura) {
        this.idAsignatura = idAsignatura;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
}
