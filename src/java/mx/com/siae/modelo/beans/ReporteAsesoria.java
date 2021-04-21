/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo.beans;

/**
 * Esta clase define al reporte de las asesorias.
 * @version 12/04/2021B
 * @author danielhernandezreyes
 */
public class ReporteAsesoria {
    private int idAsesoria;
    private String docente;
    private String asignatura;
    private String dia;
    private String horario;
    private String url;
    private String codigo;
    private String estado;
    /**
     * Constructor por defecto de ReporteAsesoria.
     */
    public ReporteAsesoria() { }
    /**
     * Este método obtiene el nombre del docente que imparte la asesoria.
     * @return El nombre del docente.
     */
    public String getDocente() {
        return docente;
    }
    /**
     * Este método asigna el nombre del docente que imparte la asesoria.
     * @param docente El nombre del docente.
     */
    public void setDocente(String docente) {
        this.docente = docente;
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
     * Este método obtiene el dia de la asesoria.
     * @return El dia de asesoria.
     * <ul>
     * <li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li>
     * </ul>
     */
    public String getDia() {
        return dia;
    }
    /**
     * Este método asigna el dia de la asesoria.
     * @param dia El dia de la asesoria.
     * <ul>
     * <li>Lunes</li><li>Martes</li><li>Miercoles</li><li>Jueves</li>
     * <li>Viernes</li>
     * </ul>
     */
    public void setDia(String dia) {
        this.dia = dia;
    }
    /**
     * Este método obtiene el rango del tiempo de la asesoria.
     * @return El rango de la asesoria.<br>
     * HoraInicio - HoraFin (en formato de 24 horas)
     */
    public String getHorario() {
        return horario;
    }
    /**
     * Este método asigna el rango del horario de la asesoria.
     * @param horario El rango en formato de 24 horas.<br>
     * HoraInicio - HoraFin
     */
    public void setHorario(String horario) {
        this.horario = horario;
    }
    /**
     * Este método obtiene la URL de la reunión de asesoria.
     * @return La URL de la reunión.
     */
    public String getUrl() {
        return url;
    }
    /**
     * Este método asigna la URL de la asesoria.
     * @param url la URL de la reunión.
     */
    public void setUrl(String url) {
        this.url = url;
    }
    /**
     * Este método información de la reunión.
     * @return Información requerida para la intergración a la reunión.
     */
    public String getCodigo() {
        return codigo;
    }
    /**
     * Este método asigna información de la reunión.
     * @param codigo La información para integrarse a la reunión.
     */
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public int getIdAsesoria() {
        return idAsesoria;
    }

    public void setIdAsesoria(int idAsesoria) {
        this.idAsesoria = idAsesoria;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
}
