package pdtb;

import java.util.Vector;
import pdtb.Connessione;

public class Connessioni {
  private static Connessioni istanza;
  private Vector<Connessione> conAttive;

  private Connessioni()  {
  	conAttive = new Vector<Connessione>();
  }

  public static Connessioni getInstance()  {
    if (istanza == null) {
      istanza = new Connessioni();
    }

    return istanza;
  }

  public void aggiungiConnessione(String nome) {
    boolean trovata = false;
    if(conAttive.size() > 0) {
    	for(int i=0;i<conAttive.size();i++) {
    		if(conAttive.elementAt(i).getNome().equals(nome)) trovata=true;
    	}	
    }
    if(!trovata) {
    	Connessione nuova = new Connessione(nome);
    	conAttive.addElement(nuova);
    }
  }
  
  public void rimuoviConnessione(String nome) {
    if(conAttive.size() > 0) {
    	for(int i=0;i<conAttive.size();i++) {
    		if(conAttive.elementAt(i).getNome().equals(nome)) {
    			conAttive.remove(i);
    		}
    	}
    }
    else {
    	System.gc();
    }
  }
  
  public boolean esisteConnessione(String nome) {
  	boolean trovata = false;
  	if(conAttive.size() > 0) {
    		for(int i=0;i<conAttive.size();i++) {
    			if(conAttive.elementAt(i).getNome().equals(nome)) {
    				trovata=true;
    			}
    		}
    	}
    	
    	return trovata;
  }
  
  /*debug*/
  public Vector<Connessione> getConAttive() {
  	return this.conAttive;
  }

}
