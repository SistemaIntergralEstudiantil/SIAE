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
 *
 * @author danielhernandezreyes
 */
public class AreasApoyoDAO {
    
    public ArrayList<ReporteAsesoria> reporteAsesorias() throws ClassNotFoundException, SQLException {
        String sql = "CALL proce_reporte_asesorias()";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<ReporteAsesoria> t = new ArrayList<>();
        while(cn.getResultado().next()){
            ReporteAsesoria rep = new ReporteAsesoria();
            rep.setDocente( cn.getResultado().getString("docente") );
            rep.setAsignatura( cn.getResultado().getString("asignatura") );
            rep.setDia( cn.getResultado().getString("dia") );
            rep.setHorario( cn.getResultado().getString("horario") );
            rep.setUrl( cn.getResultado().getString("url") );
            rep.setCodigo( cn.getResultado().getString("codigo") );
            t.add(rep);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    
}
