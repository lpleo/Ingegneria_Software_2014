CREATE TABLE utenti(
	id_utente INTEGER NOT NULL,
	nome VARCHAR(20) NOT NULL,
	cognome VARCHAR(20) NOT NULL,	/*lo metto a varchar invece che a char per testare con numeri a caso*/
	numerotel VARCHAR(15) NOT NULL,
	indirizzo VARCHAR(30) NOT NULL,
	PRIMARY KEY(id_utente),
	UNIQUE(nome,cognome,numerotel,indirizzo) /* serve ad evitare che un utente crei due account con gli stessi dati */
);

CREATE TABLE problemi(
	id_problema INTEGER NOT NULL,
	tipo_problema VARCHAR(127) NOT NULL,	
	soluzione VARCHAR(1000),			/*dimensione temporanea*/
	tipo_barca VARCHAR(20),			/* tolgo il NOT NULL in quanto potrebbe esserci un utente idiota che non sa il tipo di barca che ha*/
	tipologia INTEGER default 4,	/* i valori vanno da 0 a 3+, seguendo la legenda riportata al termine del create table*/
	PRIMARY KEY(id_problema),
	UNIQUE(tipo_problema,tipo_barca) /* servirebbe ad evitare che vengano inserite due soluzioni uguali, ma non sono convinto se tenerla o meno */
);

/*----- Legenda di problemi.tipologia -----*/

/* i valori vanno da 0 a 3+ :
	0) Indica la radice dell'albero ( ci sarà solo una tupla con valore 0 )
	1) Indica i nodi dell'albero
	2) Indica le foglie che sono soluzioni dell'albero
	3+) Indicano tutte le tuple che non sono ancora state categorizzate 	*/

/*----- termine Legenda -----*/

/* la table storico va creata per ultima */

CREATE TABLE storico(
	id_report INTEGER NOT NULL PRIMARY KEY,
	id_problemi INTEGER NOT NULL REFERENCES problemi(id_problema) ON UPDATE cascade,
	id_utenza INTEGER  REFERENCES utenti(id_utente) ON DELETE SET NULL ON UPDATE cascade,
	data_report DATE NOT NULL,
	descrizione VARCHAR(1000) default ''
);


/* commentare la seguente riga, in quanto serve solo a me in locale :  \i /home/accounts/studenti/id888wcc/Scrivania/Basi/300_spartani.sql */
