/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author sandr
 */
public class Conexion {
    
    /**
 * Esta variable almacena el Usuario con el que se conectara a la BD*/
    private String user;
/**
 * Esta variable almacena la Contraseña del usuario.*/
    private String pass;
/**
 * Esta variable almacena la Direccion con la que se conectara a la BD.*/
    private final String direccion;
/**
 * Esta variable almacena la Conexion con la BD.*/
    private Connection conexion;
/**
 * Esta variable almacena el Estado de la conexion con la BD.*/
    private PreparedStatement estado;
/**
 * Esta variable almacena los Resultados de las consultas SQL a la BD.*/
    private ResultSet resultado;
/**
 * Este es el constructor de la ConexionBD que iniciara con la conexion a la BD.
 */
    public Conexion(){
        direccion="jdbc:mysql://localhost:3306/SIAE?serverTimezone=UTC";//configurar la zona horaria
    }
/**
 * Crea la conexion a la BD.
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
 */ 
    public void conectar() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexion=DriverManager.getConnection(direccion, user, pass); 
    }
    
/**
 * Este Metodo obtiene la conexion a la BD.
 * @return La conexion.
 */
    public Connection getConexion() {
        return conexion;
    }
/**
 * Este Metodo obtiene el Estado de la conexion a la BD.
 * @return La Estado de conexion.
 */
    public PreparedStatement getEstado() {
        return estado;
    }
/**
 * Este Metodo asigan el Estado de la coxion para realizar una nueva consulta SQL.
 * @param estado El estado de conexion para una nueva consulta.
 */
    public void setEstado(PreparedStatement estado) {
        this.estado = estado;
    }
/**
 * Este Metodo obtiene los Resultados de una sentencia SQL.
 * @return La conexion.
 */
    public ResultSet getResultado() {
        return resultado;
    }
/**
 * Este Metodo asigna el Resultado de la execucion de una consulta SQL.
 * @param resultado El resultado de una consulta SQL.
 */
    public void setResultado(ResultSet resultado) {
        this.resultado = resultado;
    }    
/**
 * Este Metodo se conecta a la BD
     * @throws java.sql.SQLException
     * @throws java.lang.Exception
 */    
    
    public void cerrarConexion() throws SQLException, Exception {
        conexion.close();
    }
    
    public void prepareStatement(String sSQL) throws SQLException, Exception {
        this.estado = conexion.prepareStatement(sSQL, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
    }
    
    
    
    
    public ResultSet consultarBD(String sSQL) throws SQLException, Exception {
        ResultSet rs = null;
        Statement stmt = conexion.createStatement();
        rs = stmt.executeQuery(sSQL);
        stmt.close();
        return rs;
    }
    
    public int actualizarBD(String sSQL) throws SQLException, Exception {
        int iRes = 0;
        Statement stmt = conexion.createStatement();
        iRes = stmt.executeUpdate(sSQL);
        stmt.close();
        return iRes;
    }
    
}
