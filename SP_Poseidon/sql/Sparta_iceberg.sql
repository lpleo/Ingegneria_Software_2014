CREATE TABLE utenti(
    id_utente INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    numerotel VARCHAR(15) NOT NULL,
    indirizzo VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_utente),
    UNIQUE(nome,cognome,numerotel,indirizzo)	/* serve ad evitare che un utente crei due account con gli stessi dati */
);

CREATE TABLE problemi(
    id_problema INTEGER NOT NULL,
    tipo_problema VARCHAR(127) NOT NULL,    
    soluzione VARCHAR(1000),
    tipo_barca VARCHAR(20),
    tipologia VARCHAR(10),	/* ho tolto il 'default 4' e il 'NOT NULL' in quanto il primo caso non aveva senso con lo schema sotto illustrato, mentre il secondo caso è temporaneo e da discutere insieme*/
    PRIMARY KEY(id_problema),
    UNIQUE(tipologia)	/* serve ad evitare che vengano inserite due soluzioni uguali */
);



/*----- Legenda di problemi.tipologia -----


	---------radix----------
	/			\
-------1-------		--------2--------
/		\	/	|	\
11		12	21	22	23

	etc

----- termine Legenda -----*/


/*la table storico va creata per ultima */
/*id_problemi INTEGER NOT NULL REFERENCES problemi(id_problema) ON UPDATE cascade,
    id_utenza INTEGER REFERENCES utenti(id_utente) ON UPDATE cascade ON DELETE SET NULL,*/

CREATE TABLE storico(
    id_report INTEGER NOT NULL,
    id_problemi INTEGER NOT NULL,
    id_utenza INTEGER,
    data_report DATE NOT NULL,
    desc_report VARCHAR(1000),
    PRIMARY KEY(id_report),
    FOREIGN KEY(id_problemi) REFERENCES problemi(id_problema) ON UPDATE cascade,
    FOREIGN KEY(id_utenza) REFERENCES utenti(id_utente) ON UPDATE cascade ON DELETE SET NULL
);


CREATE TABLE credenziali (
	id_utente_cred INTEGER NOT NULL,
	password VARCHAR(20),
	PRIMARY KEY(id_utente_cred),
	FOREIGN KEY(id_utente_cred) REFERENCES utenti(id_utente) ON UPDATE cascade ON DELETE cascade
);
