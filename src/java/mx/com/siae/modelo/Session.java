/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.com.siae.modelo;

import java.util.ArrayList;
import mx.com.siae.modelo.beans.Usuarios;

/**
 *
 * @author sandr
 */
public class Session {
    private Usuarios user;
    private String mensaje;
    private ArrayList<Usuarios> listaUsuario;
    private String errorMsj;
    private String errorExe;
    private String errorUrl;
    private boolean estadoVisita;

    public Session() {
    }

    public Session(Usuarios user, String mensaje) {
        this.user = user;
        this.mensaje = mensaje;
    }

    public Usuarios getUser() {
        return user;
    }

    public void setUser(Usuarios user) {
        this.user = user;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public ArrayList<Usuarios> getListaUsuario() {
        return listaUsuario;
    }

    public void setListaUsuario(ArrayList<Usuarios> listaUsuario) {
        this.listaUsuario = listaUsuario;
    }

    public String getErrorMsj() {
        return errorMsj;
    }

    public void setErrorMsj(String errorMsj) {
        this.errorMsj = errorMsj;
    }

    public String getErrorExe() {
        return errorExe;
    }

    public void setErrorExe(String errorExe) {
        this.errorExe = errorExe;
    }

    public String getErrorUrl() {
        return errorUrl;
    }

    public void setErrorUrl(String errorUrl) {
        this.errorUrl = errorUrl;
    }

    public boolean isEstadoVisita() {
        return estadoVisita;
    }

    public void setEstadoVisita(boolean estadoVisita) {
        this.estadoVisita = estadoVisita;
    }
    
    
    
}
