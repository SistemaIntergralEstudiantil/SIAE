/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.Curso;
import mx.com.siae.modelo.beans.CursoAlumno;
import mx.com.siae.modelo.beans.DocenteR;
import mx.com.siae.modelo.beans.ReporteCurso;
import mx.com.siae.modelo.beans.Sesion;

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
     * @param nuevo Los datos del curso nuevo a registrar.
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void addCurso(Curso nuevo) throws ClassNotFoundException, SQLException{
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
        cn.getEstado().executeUpdate();
        
        cn.getEstado().close();
        cn.getConexion().close();
    }
    /**
     * Método cambia el estado del curso asignada.
     * @param change Los datos del curso.
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void changeStatusCurso(Curso change) throws ClassNotFoundException, SQLException{
        String sql = "{CALL proce_estado_curso(?, ?)}";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareCallable(sql);
        cn.getEstadoProce().setInt(1, change.getIdCurso());
        cn.getEstadoProce().setString(2, change.getEstado());
        cn.getEstadoProce().executeUpdate();
        cn.getEstadoProce().close();
        cn.getConexion().close();
    }
    /**
     * Método obtiene un lista de las sesiones de un curso espesifico.
     * @param curso Datos del curso para obtener las sesiones.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista de sesiones del curso.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>El curso no tiene sesiones.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<Sesion> reporteToSesiones(Curso curso) throws ClassNotFoundException, SQLException{
        String sql = "{CALL proce_consulta_sesion(?)}";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareCallable(sql);
        cn.getEstadoProce().setInt(1, curso.getIdCurso());
        cn.setResultado(cn.getEstadoProce().executeQuery());
        ArrayList<Sesion> t = new ArrayList<>();
        while(cn.getResultado().next()){
            Sesion s = new Sesion();
            s.setIdSesion(cn.getResultado().getInt("idSesion"));
            s.setIdCurso( cn.getResultado().getInt("idCurso") );
            s.setDia(cn.getResultado().getString("dia"));
            s.setHora_inicio(cn.getResultado().getTime("hora_inicio"));
            s.setHora_fin(cn.getResultado().getTime("hora_fin"));
            t.add(s);
        }
        cn.getEstadoProce().close();
        cn.getConexion().close();
        return t;
    }
    /**
     * Método cambia el estado del curso asignada.
     * @param change Los datos del curso.
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void newSessionCurso(Sesion change) throws ClassNotFoundException, SQLException{
        String sql = "{CALL proce_nueva_sesion(?, ?, ?, ?)}";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareCallable(sql);
        cn.getEstadoProce().setInt(1, change.getIdCurso());
        cn.getEstadoProce().setString(2, change.getDia());
        cn.getEstadoProce().setString(3, change.getHora_inicio().toString());
        cn.getEstadoProce().setString(4, change.getHora_fin().toString());
        cn.getEstadoProce().executeUpdate();
        cn.getEstadoProce().close();
        cn.getConexion().close();
    }
    /**
     * Método elimina una sesión de un curso en particular.
     * @param delete Los datos de la sesión a eliminar.
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void deleteSessionCurso(Sesion delete) throws ClassNotFoundException, SQLException{
        String sql = "{CALL proce_eliminar_sesion(?)}";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareCallable(sql);
        cn.getEstadoProce().setInt(1, delete.getIdSesion());
        cn.getEstadoProce().executeUpdate();
        cn.getEstadoProce().close();
        cn.getConexion().close();
    }
    /**
     * Método cambia el estado de un alumno respeto a una materia<br>
     * @param alumno Datos del alumno y de la materia a cambiar
     * 
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public void changeStatusAlumno(CursoAlumno alumno) throws SQLException, ClassNotFoundException {
        String sql = "{CALL proce_cambio_status_alumno(?, ?, ?)}";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareCallable(sql);
        cn.getEstadoProce().setInt(1, alumno.getIdCurso());
        cn.getEstadoProce().setString(2, alumno.getMatricula());
        cn.getEstadoProce().setString(3, alumno.getEstado());
        cn.getEstadoProce().executeUpdate();
        cn.getEstadoProce().close();
        cn.getConexion().close();
    }
    
}
