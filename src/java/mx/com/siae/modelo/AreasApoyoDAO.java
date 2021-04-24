/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.AreaApoyo;
import mx.com.siae.modelo.beans.ReporteAsesoria;

/**
 * Esta clase define las operaciones de las Áreas de apoyo a la base de datos.
 * @version 12/04/2021B
 * @author danielhernandezreyes
 * @see Conexion
 * @see ReporteAsesoria
 * @see AreaApoyo
 */
public class AreasApoyoDAO {
    /**
     * Método obtiene una lista de las Asesorias registradas en la BD.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista contiene los elementos encontrados.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>La lista contiene 0 elementos: no hay registros.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<ReporteAsesoria> reporteAsesorias() throws ClassNotFoundException, SQLException {
        String sql = "CALL proce_reporte_asesorias()";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<ReporteAsesoria> t = new ArrayList<>();
        while(cn.getResultado().next()){ // Recolectar todos los registros
            ReporteAsesoria rep = new ReporteAsesoria();
            rep.setDocente( cn.getResultado().getString("docente") );
            rep.setAsignatura( cn.getResultado().getString("asignatura") );
            rep.setDia( cn.getResultado().getString("dia") );
            rep.setHorario( cn.getResultado().getString("horario") );
            rep.setUrl( cn.getResultado().getString("url") );
            rep.setCodigo( cn.getResultado().getString("codigo") );
            t.add(rep); // Almacenar registros
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    /**
     * Método obtiene una lista de las Asesorias registradas en la BD, incluyendo<br>
     * información de su estado.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista contiene los elementos encontrados.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>La lista contiene 0 elementos: no hay registros.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<ReporteAsesoria> consultaAsesoria() throws ClassNotFoundException, SQLException {
        String sql = "CALL proce_consulta_asesoria()";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<ReporteAsesoria> t = new ArrayList<>();
        while(cn.getResultado().next()){ // Recolectar todos los registros
            ReporteAsesoria rep = new ReporteAsesoria();
            rep.setIdAsesoria( cn.getResultado().getInt("idAA"));
            rep.setAsignatura( cn.getResultado().getString("asignatura") );
            rep.setUrl( cn.getResultado().getString("url") );
            rep.setDia( cn.getResultado().getString("dia") );
            rep.setHorario( cn.getResultado().getString("horario") );
            rep.setEstado( cn.getResultado().getString("estado"));
            rep.setDocente( cn.getResultado().getString("docente") );
            rep.setCodigo( cn.getResultado().getString("extra") );
            t.add(rep); // Almacenar registros
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    /**
     * Método agrega una nueva asesoria a la BD.
     * @param nueva Los datos de la nueva asesoria a registrar.
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void addAsesoria(AreaApoyo nueva) throws ClassNotFoundException, SQLException{
        String sql = "CALL proce_nueva_area('Asesoria', ?, ?, ?, ?, ?, ?, ?, 'E');";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setString(1, nueva.getUrl());
        cn.getEstado().setString(2, nueva.getDia());
        cn.getEstado().setString(3, nueva.getHora_inicio().toString());
        cn.getEstado().setString(4, nueva.getHora_fin().toString());
        cn.getEstado().setString(5, nueva.getCodigo());
        cn.getEstado().setString(6, nueva.getIdResponsable());
        cn.getEstado().setInt(7, nueva.getIdAsignatura());
        cn.setResultado(cn.getEstado().executeQuery());
        cn.getEstado().close();
        cn.getConexion().close();
    }
    /**
     * Método cambia el estado de la asesoria asignada.
     * @param change Los datos de la asesoria.
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void changeStatusAsesoria(AreaApoyo change) throws ClassNotFoundException, SQLException{
        String sql = "{CALL proce_estado_asesoria( ?, ?)}";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareCallable(sql);
        cn.getEstadoProce().setInt(1, change.getIdAreasApoyo());
        cn.getEstadoProce().setString(2, change.getEstado());
        cn.getEstadoProce().executeUpdate();
        cn.getEstadoProce();
        cn.getConexion().close();
    }
    
}
