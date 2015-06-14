package com.federicoparezzan.titanicassistence.Bean;

/**
 * Created by federicoparezzan on 29/05/15.
 */
public class ProblemBean {


    public static final String ID_PROBLEMA = "id_problema";
    public static final String TIPO_PROBLEMA = "tipo_problema";
    public static final String SOLUZIONE = "soluzione";
    public static final String TIPO_BARCA = "tipo_barca";
    public static final String TIPOLOGIA = "tipologia";

    private int id_problema;
    private String tipo_problema;
    private String soluzione;
    private String tipo_barca;
    private String tipologia;

    public ProblemBean(){}


    public int getId_problema() {
        return id_problema;
    }

    public void setId_problema(int id_problema) {
        this.id_problema = id_problema;
    }

    public String getTipo_problema() {
        return tipo_problema;
    }

    public void setTipo_problema(String tipo_problema) {
        this.tipo_problema = tipo_problema;
    }

    public String getSoluzione() {
        return soluzione;
    }

    public void setSoluzione(String soluzione) {
        this.soluzione = soluzione;
    }

    public String getTipo_barca() {
        return tipo_barca;
    }

    public void setTipo_barca(String tipo_barca) {
        this.tipo_barca = tipo_barca;
    }

    public String getTipologia() {
        return tipologia;
    }

    public void setTipologia(String tipologia) {
        this.tipologia = tipologia;
    }
}
