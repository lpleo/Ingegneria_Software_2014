﻿/* INSERT INTO utenti(id_utente,nome,cognome,numerotel,indirizzo) */

INSERT INTO utenti VALUES(111,'mario','rossi','0235413','via anonima');
INSERT INTO utenti VALUES(77,'luca','verdi','0035413','via costa');
INSERT INTO utenti VALUES(1107,'luca','neri','00535447','viale piave');
INSERT INTO utenti VALUES(33,'roberto','rossi','3513879','piazza napoli');
INSERT INTO utenti VALUES(1035,'anna','bianchi','35411879','via napoleone');
INSERT INTO utenti VALUES(1036,'anna','bianchini','0004758','via bonaparte');
INSERT INTO utenti VALUES(466,'mario','rossi','332546','viale misterioso');
INSERT INTO utenti VALUES(101,'marina','damon','3541013','via qualcosa');
INSERT INTO utenti VALUES(3,'robert','ross','333657','piazza lunga');
INSERT INTO utenti VALUES(539,'giulia','ferrari','3888615','via pieve');

/* INSERT INTO problemi(id_problema,tipo_problema,soluzione,tipo_barca,tipologia); */

/*
Vecchi inserimenti
INSERT INTO problemi VALUES(1,'Diporto',NULL,'diporto',1);
INSERT INTO problemi VALUES(2,'Charter',NULL,'charter',2);
INSERT INTO problemi VALUES(3,'Motore',NULL,'diporto',11);
INSERT INTO problemi VALUES(4,'Timone',NULL,'diporto',12);
INSERT INTO problemi VALUES(5,'Timone',NULL,'diporto',21);
INSERT INTO problemi VALUES(6,'Difficile da girare','tentare di oliare alla base del timone, e rimuovere eventuali incrostazioni che si possono formare nella giuntura interna','diporto',121);
INSERT INTO problemi VALUES(37,'Fiamme','Usare l"estintore in dotazione','charter',22);
INSERT INTO problemi VALUES(38,'Fiamme','Usare l"estintore in dotazione','diporto',13);
INSERT INTO problemi VALUES(61,'Vela',NULL,'charter',23);
INSERT INTO problemi VALUES(40,'Aria condizionata',NULL,'diporto',14);
INSERT INTO problemi VALUES(41,'Filtro','Estrarre il filtro posto nel vano laterale e pulirlo con un panno in microfibra','diporto',131);
INSERT INTO problemi VALUES(78,'Stoffa incagliata nei meccanismi','Quando la stoffa della vela si incaglia nei meccanismi di riavvolgimento, tirare delicatamente la parte incagliata mentre si svolge la vela; se non dovesse liberarsi completamente, ripetere l"operazione invertendo il senso di avvolgimento.Se dopo la seguente procedura risulta ancora incastrato, ripetere continuamente le due manovre precedentemente scritte aumentando gradualmente la velocità del meccanismo','charter',231);
INSERT INTO problemi VALUES(63,'Vela strappata','Una vela strappata può causare molteplici pericoli se non viene ammainata; purtroppo è altamente probabile che si incastri ripetutamente nei meccanismi, rischiando di danneggiarli; in questo caso è necessario ammainarla manualmente.Per far ciò, aprire il vano del meccanismo di riavvolgimento situato alla base dell"albero e settare la funzione su manuale(solitamente è una leva rossa); dopodichè usare i cavi lungo la vela per ammainarla manualmente.Al termine, ri-settare la leva come in origine','charter',232);*/

/* INSERT INTO credenziali (id_utente_cred,password) */

/*Nuovi inserimenti by pare*/
INSERT INTO problemi VALUES(1,'La barca si muove?','Controlla che la barca si muova','charter','011');
INSERT INTO problemi VALUES(2,'La barca vira?','Controlla il timone','charter','012');
INSERT INTO problemi VALUES(3,'Hai un problema allo scafo?','Controlla se ci sono problemi allo scafo','charter','013');
INSERT INTO problemi VALUES(4,'Stai navigando a vela?','Controlla se stai andando a vela','charter','0111');
INSERT INTO problemi VALUES(5,'Stai navigando a motore?','Controlla se stai andando a motore','charter','0112');
INSERT INTO problemi VALUES(6,'Il timone è bloccato?','Controlla che il meccanismo di blocco della ruota del timone non sia inserito, se è inserito sbloccalo tirando l''apposita leva','charter','0121');
INSERT INTO problemi VALUES(7,'Ci sono alghe sul timone?','Controlla che delle alghe attorcigliate non blocchino le pale del timone','charter','0122');
INSERT INTO problemi VALUES(8,'Hai una falla nello scafo?','Tampona la falla utilizzando il kit di riparazione','charter','0131');
INSERT INTO problemi VALUES(9,'E presente del fumo a bordo?','Controlla la presenza di fumo, se presente prepara un estintore ','charter','0132');
INSERT INTO problemi VALUES(10,'Il fumo esce dal motore?','Spegni il motore e controlla le condutture dei gas di scarico','charter','01321');
INSERT INTO problemi VALUES(11,'Il fumo proviene dalla cucina?','Spegni i fornelli e rimuovi materiale facilmente infiammabile','charter','01322');
INSERT INTO problemi VALUES(12,'Hai issato la vela?','Issa la vela tirando l''apposita drizza','charter','01111');
INSERT INTO problemi VALUES(13,'Il motore è acceso?','Devi accendere il motore, gira la chiave e accelera leggermente','Charter','01121');
INSERT INTO problemi VALUES(14,'Hai messo il carburante?','Fai rifornimento.','charter','011211');
INSERT INTO problemi VALUES(15,'Hai un problema allo scafo?','Controlla se ci sono problemi allo scafo',' diporto ','023');
INSERT INTO problemi VALUES(16,'Si solleva la deriva?','Controlla che la deriva non sia già sollevata',' diporto ','024');
INSERT INTO problemi VALUES(17,'La barca si muove?','Controlla che la barca si muova','diporto','021');
INSERT INTO problemi VALUES(18,'La barca vira?','Controlla il timone','charter','022');
INSERT INTO problemi VALUES(19,'Il timone è bloccato?','Controlla che il meccanismo di blocco della ruota del timone non sia inserito, se è inserito sbloccalo tirando l''apposita leva','charter','0221');
INSERT INTO problemi VALUES(20,'Ci sono alghe sul timone?','Controlla che delle alghe attorcigliate non blocchino le pale del timone','charter','0222');
INSERT INTO problemi VALUES(21,'Hai una falla nello scafo?','Tampona la falla utilizzando il kit di riparazione','charter','0231');
INSERT INTO problemi VALUES(22,'E presente del fumo a bordo?','Controlla la presenza di fumo, se presente prepara un estintore ','charter','0232');
INSERT INTO problemi VALUES(23,'Lo scafo è pieno di incrostazioni?','Spegni il motore, ferma la barca e effettua la pulizia',' diporto ','0233');
INSERT INTO problemi VALUES(24,'Funziona il motore di sollevamento della deriva?','Smonta il coperchio, usa la leva manuale',' diporto ','0241');
INSERT INTO problemi VALUES(25,'Stai navigando a vela?','Controlla se stai andando a vela','charter','0211');
INSERT INTO problemi VALUES(26,'Stai navigando a motore?','Controlla se stai andando a motore','charter','0212');
INSERT INTO problemi VALUES(27,'Il fumo esce dal motore?','Spegni il motore e controlla le condutture dei gas di scarico','charter','02321');
INSERT INTO problemi VALUES(28,'Il fumo proviene dalla cucina?','Spegni i fornelli e rimuovi materiale facilmente infiammabile','charter','02322');
INSERT INTO problemi VALUES(29,'Hai issato la vela?','Issa la vela tirando l''apposita drizza','charter','02111');
INSERT INTO problemi VALUES(30,'Il motore è acceso?','Devi accendere il motore, gira la chiave e accelera leggermente','Charter','02121');
INSERT INTO problemi VALUES(31,'Hai messo il carburante?','Fai rifornimento.','charter','021211');
INSERT INTO problemi VALUES(32,'1','1','1','0');
INSERT INTO problemi VALUES(33,'2','2','2','01');
INSERT INTO problemi VALUES(34,'3','3','3','02');

INSERT INTO credenziali VALUES(33,'123456');
INSERT INTO credenziali VALUES(77,'799726');
INSERT INTO credenziali VALUES(466,'246854');
INSERT INTO credenziali VALUES(101,'123456');

/* INSERT INTO storico(id_report,id_problemi,id_utenza,data_report,descr_report) */

INSERT INTO storico VALUES(2,6,539,'2015-3-11','Nonostante l"utente abbia seguito la soluzione visualizzata, il timone rimaneva ancora bloccato; dopo aver richiesto maggiori informazioni sullo sviluppo del problema, ho ritenuto opportuno avvisare l"utente che si fosse attivato accidentalmente il dispositivo antifurto presente nella sua imbarcazione; dopo un rapido controllo, l"utente si scusa dicendo che era effettivamente l"antifurto attivato');
INSERT INTO storico VALUES(3,38,77,'2015-7-2','L"utente ha chiamato in quanto le fiamme, avviluppatesi nei pressi dell"estintore, avevano bruciato le istruzioi d"uso; sono state perciò fornite telefonicamente, ed è stato chiesto se fosse neccessario avvisare la GC, richiesta respinta dall"utente in quanto è riuscito a domare il principio d"incendio');
INSERT INTO storico VALUES(4,5,1035,'2015-3-23',' DA COMPILARE ');
INSERT INTO storico VALUES(5,63,33,'2015-1-17',' DA COMPILARE ');
INSERT INTO storico VALUES(6,78,1107,'2015-2-14',' DA COMPILARE ');
INSERT INTO storico VALUES(8,41,77,'2015-3-29',' DA COMPILARE ');
INSERT INTO storico VALUES(9,41,539,'2015-3-5',' DA COMPILARE ');
INSERT INTO storico VALUES(10,5,466,'2015-2-28','L"utente rifesisce che la sua barca viaggia leggermente in diagonale; dopo aver valutato varie opzioni, è stata trovata una falla nella parte sinistra della poppa; è stata chiamanta la GC da parte dell"utente sotto nostro consiglio');


/* test */
/*select * from storico s, utenti u, problemi p, credenziali c 
where s.id_problemi=p.id_problema 
and s.id_utenza=u.id_utente 
and u.id_utente=c.id_utente_cred;*/
