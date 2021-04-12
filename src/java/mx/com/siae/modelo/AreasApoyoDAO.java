/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.ReporteAsesoria;

/**
 * Esta clase define las operaciones de las Áreas de apoyo a la base de datos.
 * @version 12/04/2021A
 * @author danielhernandezreyes
 * @see Conexion
 * @see ReporteAsesoria
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
    
}
