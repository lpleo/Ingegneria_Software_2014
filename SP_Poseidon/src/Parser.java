/*
Classe dedidcata al controllo della presenza di
apostrofi
*/

package pdtb.Controlli;

public class Parser
{
  private String testo; //nome della connessione
  
  /*
  Costruttore
  Accetta come parametro un nome,
  setta la variabile globale con quel nome.
  */
  public Parser(String testo){
  	this.testo = testo;
  }

  /*
  Metodo getNome
  Ritrona il nome della connessione
  */
  public String modificaStringa() {
  	char[] vtesto = testo.toCharArray();
  	for(int i=0;i<vtesto.length();i++) {
  		if(vtesto[i]=='\'') {
  			
  		}
  	}
  }

}
