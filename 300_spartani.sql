/* c'è qualche inserimento che da errore in quanto non soddisfa condizioni quali le primary key o le unique, per il resto dal pc della delta tutto sembra funzionare*/


INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo)
VALUES(0111,'mario','rossi','0235413','via anonima');

INSERT INTO utenti VALUES(0001,'mario','rossi','0235413','via anonima');
INSERT INTO utenti VALUES(0077,'luca','verdi','0035413','via costa');
INSERT INTO utenti VALUES(1107,'luca','neri','00535447','viale piave');
INSERT INTO utenti VALUES(0033,'roberto','rossi','3513879','piazza napoli');
INSERT INTO utenti VALUES(1035,'anna','bianchi','35411879','via napoleone');
INSERT INTO utenti VALUES(1036,'anna','bianchini','0004758','via bonaparte');
INSERT INTO utenti VALUES(0466,'mario','rossi','332546','viale misterioso');
INSERT INTO utenti VALUES(0101,'marina','damon','3541013','via qualcosa');
INSERT INTO utenti VALUES(0003,'robert','ross','333657','piazza lunga');
INSERT INTO utenti VALUES(0539,'giulia','ferrari','3888615','via pieve');

/* i valori vanno da 0 a 3+ :

0) Indica la radice dell'albero ( ci sarà solo una tupla con valore 0 )
1) Indica i nodi dell'albero
2) Indica le foglie che sono soluzioni dell'albero
3+) Indicano tutte le tuple che non sono ancora state categorizzate (volendo si può inserire al posto di un numero a caso, l'id dell'operatore che ha creato la tupla)
*/

INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,tipologia)
VALUES(000,'Barca',NULL,NULL,0);

INSERT INTO problemi VALUES(001,'Diporto',NULL,NULL,1);
INSERT INTO problemi VALUES(002,'Charter',NULL,NULL,1);
INSERT INTO problemi VALUES(004,'Guasti motore:',NULL,'diporto',1);
INSERT INTO problemi VALUES(099,'Bulloni mancanti paratia sx','comprare bulloni','charter',7);
INSERT INTO problemi VALUES(173,'Guasto motore - biella','chiave inglese n°11','diporto',2);
INSERT INTO problemi VALUES(174,'Guasto motore - carburante','chiave inglese n°12','diporto',2);
INSERT INTO problemi VALUES(175,'Guasto motore','chiave inglese n°15','charter',2);
INSERT INTO problemi VALUES(007,'Timone',NULL,'diporto',1);
INSERT INTO problemi VALUES(008,'Timone allentato','Brugola 10','diporto',2);
INSERT INTO problemi VALUES(035,'Fiamme',NULL,'charter',1);
INSERT INTO problemi VALUES(036,'Fiamme alla vela','Estintore','charter',2);
INSERT INTO problemi VALUES(037,'Fiamme al motore','Estintore','charter',2);
INSERT INTO problemi VALUES(038,'Fiamme','Estintore','diporto',2);
INSERT INTO problemi VALUES(061,'Iceberg di prua!','Sai già come finirà...',NULL,2);
INSERT INTO problemi VALUES(040,'Cime annodate','Segui le immagini','diporto',2);
INSERT INTO problemi VALUES(331,'Falla laterale','Trasferisci il peso dalla parte opposta','diporto',2);

/*  N.B: quando creo uno storico, devo usare un id_utente e un id_problema esistenti, altrimenti non va*/

INSERT INTO storico(id_report,id_problemi,id_utenza,data_report,descrizione)
VALUES(01,000,0001,'01/01/2015','');

INSERT INTO storico VALUES(02,000,0539,'11/03/2015','');
INSERT INTO storico VALUES(03,000,0077,'07/02/2015','');
INSERT INTO storico VALUES(04,000,1107,'23/03/2015','');
INSERT INTO storico VALUES(05,035,0033,'17/01/2015','');
INSERT INTO storico VALUES(06,061,1107,'14/02/2015','');
INSERT INTO storico VALUES(07,004,0001,'03/01/2015','');
INSERT INTO storico VALUES(08,002,0077,'29/03/2015','');
INSERT INTO storico VALUES(09,007,0539,'05/03/2015','');
INSERT INTO storico VALUES(10,000,0466,'28/02/2015','');

