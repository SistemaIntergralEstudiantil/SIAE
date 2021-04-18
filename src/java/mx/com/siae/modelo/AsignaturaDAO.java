/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.siae.modelo.beans.AlumnoRepoD;
import mx.com.siae.modelo.beans.Asignatura;
import mx.com.siae.modelo.beans.ReporteAsig;

/**
 * Esta clase representa las operaciones de las asignaturas a la base de datos.
 * @version 12/04/2021A
 * @author danielhernandezreyes
 * @see Conexion
 * @see ReporteAsig
 * @see Asignatura
 * @see AlumnoRepoD
 */
public class AsignaturaDAO {
    /**
     * Método obtiene un lista de las asignaturas que son ofertadas actualmente.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista contiene las asignaturas encontrados.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>La lista contiene 0 elementos: no hay asignaturas.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<ReporteAsig> reporte() throws ClassNotFoundException, SQLException{
        String sql = "CALL proce_reporte_cursos()"; // Cambios del SQL
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<ReporteAsig> t = new ArrayList<>();
        while(cn.getResultado().next()){
            ReporteAsig rep = new ReporteAsig();
            rep.setIdCurso( cn.getResultado().getString("idC") );
            rep.setCupo( cn.getResultado().getInt("cupo") );
            rep.setDia( cn.getResultado().getString("dia") );
            rep.setHorario( cn.getResultado().getString("horario") );
            rep.setAsignatura( cn.getResultado().getString("asignatura") );
            rep.setCredito( cn.getResultado().getInt("credito") );
            rep.setDocente( cn.getResultado().getString("docente") );
            rep.setSemestre( cn.getResultado().getInt("semestre") );
            rep.setArea( cn.getResultado().getString("area"));
            t.add(rep);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    /**
     * Método obtiene un lista de todas las asignaturas de todos los semestres.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista contiene todas las asignaturas.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>No hay asignaturas registradas.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<Asignatura> reporteAsignatura() throws SQLException, ClassNotFoundException {
        String sql = "CALL proce_reporte_asignatura()";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<Asignatura> t = new ArrayList<>();
        while(cn.getResultado().next()){
            Asignatura a = new Asignatura();
            a.setIdAsignatura( cn.getResultado().getInt("idA") );
            a.setSemestre( cn.getResultado().getInt("semestre") );
            a.setNombre( cn.getResultado().getNString("nombre") );
            a.setArea( cn.getResultado().getString("area") );
            a.setCredito( cn.getResultado().getInt("credito") );
            a.setArea( cn.getResultado().getString("area"));
            t.add(a);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
    /**
     * Método obtiene un lista de todos las alumnos de todas las materias de un<br>
     * determinado docente, los cuales servira para reportar su status del curso
     * inmediato de cada alumno.
     * @param idUsuario El identificador del docente.
     * @return
     * <dl>
     *  <dt><h3>ArrayList(x)</h3></dt><dd>La lista contiene todas las alumnos.</dd>
     *  <dt><h3>ArrayList(0)</h3></dt><dd>No hay alumnos registradas.</dd>
     * </dl>
     * @throws ClassNotFoundException Excepción al establecer el conector.
     * @throws SQLException Excepción al realizar la conexión con la BD.
     */
    public ArrayList<AlumnoRepoD> reporteAlumnoCursoD( String idUsuario) throws SQLException, ClassNotFoundException {
        String sql = "CALL proce_reporte_curso_docente(?);";
        Conexion cn = new Conexion();
        cn.conectar();
        cn.prepareStatement(sql);
        cn.getEstado().setString(1, idUsuario);
        cn.setResultado(cn.getEstado().executeQuery());
        ArrayList<AlumnoRepoD> t = new ArrayList<>();
        while(cn.getResultado().next()){
            AlumnoRepoD a = new AlumnoRepoD();
            a.setIdCurso(cn.getResultado().getInt("idC"));
            a.setTipo(cn.getResultado().getString("tipo"));
            a.setMatricula(cn.getResultado().getString("m"));
            a.setAlumno(cn.getResultado().getString("alumno"));
            a.setIdAsignatura( cn.getResultado().getInt("idA") );
            a.setAsignatura(cn.getResultado().getString("asignatura"));
            a.setSemestre( cn.getResultado().getInt("semestre") );
            a.setReporte(cn.getResultado().getString("reporte"));
            t.add(a);
        }
        cn.getEstado().close();
        cn.getConexion().close();
        return t;
    }
}
