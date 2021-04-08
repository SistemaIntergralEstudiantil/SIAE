/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.ReporteAsig;

/**
 *
 * @author danielhernandezreyes
 */
public class AsignaturaDAO {
    
    public ArrayList<ReporteAsig> reporte() throws ClassNotFoundException, SQLException{
        String sql = "CALL proce_reporte_cursos()";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<ReporteAsig> t = new ArrayList<>();
        while(cn.getResultado().next()){
            ReporteAsig rep = new ReporteAsig();
            rep.setIdCurso( cn.getResultado().getString("idCurso") );
            rep.setCupo( cn.getResultado().getInt("cupo") );
            rep.setDia( cn.getResultado().getString("dia") );
            rep.setHorario( cn.getResultado().getString("horario") );
            rep.setAsignatura( cn.getResultado().getString("asignatura") );
            rep.setCredito( cn.getResultado().getInt("credito") );
            rep.setDocente( cn.getResultado().getString("docente") );
            rep.setSemestre( cn.getResultado().getInt("semestre") );
            t.add(rep);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    
}
