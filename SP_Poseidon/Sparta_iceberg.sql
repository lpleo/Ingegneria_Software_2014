/* spero funzioni la formattazione in quanto l'ho modificato da windows e non da linux :)  */

CREATE TABLE utenti(
    id_utente INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,   /*lo metto a varchar invece che a char per testare con numeri a caso*/
    numerotel VARCHAR(15) NOT NULL,
    indirizzo VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_utente),
    UNIQUE(nome,cognome,numerotel,indirizzo)	/* serve ad evitare che un utente crei due account con gli stessi dati */
);

CREATE TABLE problemi(
    id_problema INTEGER NOT NULL,
    tipo_problema VARCHAR(127) NOT NULL,    
    soluzione VARCHAR(511),        /*dimensione temporanea*/
    tipo_barca VARCHAR(20),                 /* tolgo il NOT NULL in quanto potrebbe esserci un utente idiota che non sa il tipo di barca che ha*/
    tipologia INTEGER default 4 NOT NULL,	/* i valori vanno da 0 a 3+, seguendo la legenda riportata al termine del create table*/
    PRIMARY KEY(id_problema),
    UNIQUE(tipologia)	/* servirebbe ad evitare che vengano inserite due soluzioni uguali, ma non sono convinto se tenerla o meno */
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
    desc_report VARCHAR(500),
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

INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0111,'mario','rossi','0235413','via anonima');
/*INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0001,'mario','rossi','0235413','via anonima');*/
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0077,'luca','verdi','0035413','via costa');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(1107,'luca','neri','00535447','viale piave');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0033,'roberto','rossi','3513879','piazza napoli');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(1035,'anna','bianchi','35411879','via napoleone');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(1036,'anna','bianchini','0004758','via bonaparte');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0466,'mario','rossi','332546','viale misterioso');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0101,'marina','damon','3541013','via qualcosa');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0003,'robert','ross','333657','piazza lunga');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0539,'giulia','ferrari','3888615','via pieve');

INSERT INTO problemi VALUES(111,'Primo accesso','Benvenuto!',NULL,0);
INSERT INTO problemi VALUES(174,'Guasto motore','chiave inglese n°12','diporto',1);
INSERT INTO problemi VALUES(175,'Guasto motore','chiave inglese n°15','charter',7);
INSERT INTO problemi VALUES(008,'Timone','Brugola 10','diporto',4);
INSERT INTO problemi VALUES(230,'Mal di testa','Ma dai?',NULL,5);
INSERT INTO problemi VALUES(037,'Fiamme','Estintore','charter',2);
INSERT INTO problemi VALUES(038,'Fiamme','Estintore','diporto',3);
INSERT INTO problemi VALUES(061,'Iceberg di prua!','Sai già come finirà...',NULL,10);
INSERT INTO problemi VALUES(040,'Cime annodate','Segui le immagini','diporto',21);
INSERT INTO problemi VALUES(331,'Falla laterale','Trasferisci il peso dalla parte opposta','diporto',25);

INSERT INTO credenziali VALUES(33,'123456');

/*  N.B: quando creo uno storico, devo usare un id_utente e un id_problema esistenti, altrimenti non va*/

/*INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(01,001,0001,'01/01/2015');*/
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(02,040,0539,'2015-3-11');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(03,175,0077,'2015-7-2');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(04,037,1035,'2015-3-23');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(05,008,0033,'2015-1-17');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(06,061,1107,'2015-2-14');
/*INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(07,331,0001,'03/01/2015');*/
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(08,230,0077,'2015-3-29');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(09,040,0539,'2015-3-5');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(10,175,0466,'2015-2-28');


