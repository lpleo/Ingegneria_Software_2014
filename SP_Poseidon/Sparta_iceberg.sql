CREATE TABLE utenti(
    id_utente INTEGER NOT NULL,
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,   /*lo metto a varchar invece che a char per testare con numeri a caso*/
    numerotel VARCHAR(15) NOT NULL,
    indirizzo VARCHAR(30),
    PRIMARY KEY(id_utente)
);

CREATE TABLE problemi(
    id_problema INTEGER NOT NULL,
    tipo_problema VARCHAR(127) NOT NULL,    /* potrebbe essere ridondante*/
    soluzione VARCHAR(511) NOT NULL,        /*dimensione temporanea*/
    tipo_barca VARCHAR(20),                 /* tolgo il NOT NULL in quanto potrebbe esserci un utente idiota che non sa il tipo di barca che ha*/
    categoria INTEGER DEFAULT 0,
    sottocategoria INTEGER DEFAULT 0,
    PRIMARY KEY(id_problema)
);

/* la table storico va creata per ultima */

CREATE TABLE storico(
    id_report INTEGER NOT NULL PRIMARY KEY,
    id_problemi INTEGER NOT NULL REFERENCES problemi(id_problema) ON UPDATE cascade,
    id_utenza INTEGER NOT NULL REFERENCES utenti(id_utente) ON DELETE cascade ON UPDATE cascade,
    data_report DATE NOT NULL
);


INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0111,'mario','rossi','0235413','via anonima');
INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0001,'mario','rossi','0235413','via anonima');
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

INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(111,'Primo accesso','Benvenuto!',NULL,0,0);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(001,'Primo accesso','Benvenuto!',NULL,0,0);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(174,'Guasto motore','chiave inglese n°12','diporto',1,3);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(175,'Guasto motore','chiave inglese n°15','charter',3,7);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(008,'Timone','Brugola 10','diporto',4,4);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(230,'Mal di testa','Ma dai?',NULL,0,0);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(037,'Fiamme','Estintore','charter',1,0);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(038,'Fiamme','Estintore','diporto',1,0);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(061,'Iceberg di prua!','Sai già come finirà...',NULL,0,0);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(040,'Cime annodate','Segui le immagini','diporto',7,2);
INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,categoria,sottocategoria)
VALUES(331,'Falla laterale','Trasferisci il peso dalla parte opposta','diporto',2,0);

/*  N.B: quando creo uno storico, devo usare un id_utente e un id_problema esistenti, altrimenti non va*/

INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(01,001,0001,'01/01/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(02,040,0539,'11/03/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(03,175,0077,'07/02/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(04,037,1035,'23/03/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(05,008,0033,'17/01/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(06,061,1107,'14/02/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(07,331,0001,'03/01/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(08,230,0077,'29/03/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(09,040,0539,'05/03/2015');
INSERT INTO storico(id_report,id_problemi,id_utenza,data_report)
VALUES(10,175,0466,'28/02/2015');


