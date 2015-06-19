/*
Classe per la gestione delle connessioni - singletone.
Permette di tenere traccia delle varie connessioni da computer diversi
al sistema.
Permette la gestione delle connessioni tramite inserimento,cancellazione
e test di esistenza.
*/

package pdtb.connessioni;

import java.util.Vector;
import pdtb.connessioni.Connessione;

public class Connessioni {
  private static Connessioni istanza; //Singletone
  private Vector<Connessione> conAttive; //Vettore delle connessioni attive

  /*
  Costruttore
  */
  private Connessioni()  {
  	conAttive = new Vector<Connessione>(); //inizializzo il vettore
  }

  /*
  Metodo getInstance
  Permette l'attuazione del principio singletone.
  Se esiste già un oggetto Connessioni nella JVM
  ritorna un istanza dello stesso, altrimenti lo 
  crea ex novo.
  Ritorna un istanza dell'oggetto.
  */
  public static Connessioni getInstance()  {
    if (istanza == null) {
      istanza = new Connessioni();
    }

    return istanza;
  }

  /*
  Metodo aggiungiConnessione
  Permette di aggiungere una nuova connessione se 
  essa non è gia presente all'interno delle connessioni attive.
  Sono possibili connessioni multiple, ma un unico logout è
  valido per tutte le sessioni attive.
  */
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
  
  /*
  Metodo rimuoviConnessione
  Permette la rimozione di una connessione dal Vector conAttive,
  se essa esiste.
  Se il vettore conAttive è vuoto, invoca la GC
  */
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
  
  
  /*
  Metodo esisteConnessione
  Permette di testare l'esistenza di una connessione tramite il nome.
  Ritorna un booleano a true se la connessione esiste, 
  a false se la connessione non esiste.
  */
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
