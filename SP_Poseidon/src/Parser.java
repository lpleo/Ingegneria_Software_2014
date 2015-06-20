/*
Classe dedicata alla memorizzazione della
connessione tramite nome
*/

package pdtb.connessioni;

public class Connessione
{
  private String nome; //nome della connessione
  
  /*
  Costruttore
  Accetta come parametro un nome,
  setta la variabile globale con quel nome.
  */
  public Connessione(String nome){
  	this.nome = nome;
  }

  /*
  Metodo getNome
  Ritrona il nome della connessione
  */
  public String getNome() {
  	return this.nome;
  }

}
