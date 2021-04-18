/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.Curso;
import mx.com.siae.modelo.beans.ReporteCurso;

/**
 *
 * @author danielhernandezreyes
 * @see Curso
 */
public class CursosDAO {
    /**
     * Método obtiene un lista de todos los cursos registrados.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista contiene información de los cursos registrados.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>La lista contiene 0 elementos: no hay cursos.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<ReporteCurso> reporteCursos() throws ClassNotFoundException, SQLException{
        String sql = "CALL proce_consulta_curso()";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<ReporteCurso> t = new ArrayList<>();
        while(cn.getResultado().next()){
            ReporteCurso rep = new ReporteCurso();
            rep.setIdCurso( cn.getResultado().getInt("idC") );
            rep.setTipo(cn.getResultado().getString("tipo"));
            rep.setEstado(cn.getResultado().getString("estado"));
            rep.setCupo( cn.getResultado().getInt("cupo") );
            rep.setIdAsignatura(cn.getResultado().getInt("idA"));
            rep.setIdResponsable(cn.getResultado().getString("idR"));
            rep.setAsignatura(cn.getResultado().getString("nombre"));
            rep.setResponsable(cn.getResultado().getString("docente"));
            t.add(rep);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    /**
     * Método agrega un nuevo curso a la BD.
     * @param nuevo El curso nuevo para ingresar
     * @return
     * <dl>
     *  <dt><h3>True</h3></dt><dd>La operación fue completada.</dd>
     *  <dt><h3>False</h3></dt><dd>La operación fue cancelada.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public boolean addCurso(Curso nuevo) throws ClassNotFoundException, SQLException{
        String sql = "CALL proce_nuevo_curso(?, ?, ?, ?, ?, ?)";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setInt(1, nuevo.getIdCurso());
        cn.getEstado().setString(2, nuevo.getTipo());
        cn.getEstado().setString(3, nuevo.getEstado());
        cn.getEstado().setInt(4, nuevo.getCupo());
        cn.getEstado().setInt(5, nuevo.getIdAsignatura());
        cn.getEstado().setString(6, nuevo.getIdResponsable());
        cn.setResultado(cn.getEstado().executeQuery());
        boolean estado = true;
        while(cn.getResultado().next()){
            estado = false;
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return estado;
    }
}
