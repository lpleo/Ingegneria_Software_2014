/*
Classe dedidcata al controllo della presenza di
apostrofi
*/

package pdtb.controlli;

public class Parser
{
  private String testo; //testo inserito dall'utente
  
  /*
  Costruttore
  Accetta come parametro un testo,
  setta la variabile globale con quel testo.
  */
  public Parser(String testo){
  	this.testo = testo;
  }

  /*
  Metodo modificaStringa
  sostituisce l'apostrofo con uno spazio
  prima dell'inserimento nella base di dati.
  */
  public String modificaStringa() {
  	char[] vtesto = testo.toCharArray();
  	for(int i=0;i<testo.length();i++) {
  		if(vtesto[i]=='\'') {
  			vtesto[i] = ' ';
  		}
  	}
  	return (new String(vtesto));
  }

}
