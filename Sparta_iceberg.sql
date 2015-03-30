CREATE TABLE storico(
        id_report INTEGER NOT NULL,
        id_problemi INTEGER NOT NULL unique,
        id_utenza INTEGER NOT NULL unique,
        data_report DATE,
	primary key(id_report, id_problemi, id_utenza)
);
 
CREATE TABLE utente(
        id_utente INTEGER NOT NULL,
        nome VARCHAR(30)NOT NULL ,
        cognome VARCHAR(20) NOT NULL,
        numeroTel CHAR(15)NOT NULL,
        indirizzo VARCHAR(30),
	primary key(id_utente),
      	foreign key(id_utente) REFERENCES storico(id_utenza) on delete cascade on update cascade
);
 
CREATE TABLE problemi(
        id_problema INTEGER NOT NULL,
        tipo_problema VARCHAR(127) NOT NULL,
        soluzione VARCHAR(500), /*temporanea, finche' non decidiamo dove mettere il testo delle soluzioni*/
	tipo_barca VARCHAR(20) NOT NULL,
        categoria INTEGER DEFAULT 0,
        sottocategoria INTEGER DEFAULT 0,
	primary key(id_problema),
        foreign key(id_problema) REFERENCES storico(id_problemi) on delete cascade on update cascade
);
