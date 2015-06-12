package com.federicoparezzan.titanicassistence.Bean;

/**
 * Created by federicoparezzan on 28/05/15.
 */
public class CredentialBean {

    public static final String ID_UTENTE_CRED = "id_utente_cred";
    public static final String PASSWORD = "password";

    private String id_utente_cred;
    private String password;




    public String getId_utente_cred() {
        return id_utente_cred;
    }

    public void setId_utente_cred(String id_utente_cred) {
        this.id_utente_cred = id_utente_cred;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }



}
