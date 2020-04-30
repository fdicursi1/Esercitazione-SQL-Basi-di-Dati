drop database if exists universita;
create database if not exists universita;
  use universita;

  drop table if exists Modulo;
  create table Modulo (
    Codice char(6) primary key,
    Nome varchar(30) not null,
    Descrizione varchar(50),
    CFU numeric(2) not null check(CFU > 0)
  );

  drop table if exists Corso_Laurea;
  create table Corso_Laurea (
    Codice varchar(10) primary key,
    Nome varchar(50) not null,
    Descrizione varchar(50)
  );

  drop table if exists Dipartimento;
  create table Dipartimento (
    Codice varchar(10) primary key,
    Nome varchar(50) not null
  );

  drop table if exists Sede;
  create table Sede (
    Codice varchar(10) primary key,
    Indirizzo varchar(50),
    Citta varchar(30)
  );

  drop table if exists Sede_Dipartimento;
  create table Sede_Dipartimento (
    Codice_Sede varchar(10),
    Codice_Dipartimento varchar(10),
    Note varchar(50),
    foreign key (Codice_Sede) references Sede(Codice) on update cascade on delete cascade,
    foreign key (Codice_Dipartimento) references Dipartimento(Codice) on update cascade on delete cascade
  );

  drop table if exists Studente;
  create table Studente (
    Matricola numeric(6) primary key check(Matricola > 0),
    Corso_laurea varchar(10),
    Nome varchar(30) not null,
    Cognome varchar(30) not null,
    Data_nascita date,
    Codice_Fiscale char(16) unique,
    Foto blob,
    foreign key (Corso_laurea) references Corso_Laurea(Codice) on update cascade on delete cascade
  );
  drop table if exists Docente;
  create table Docente (
    Matricola numeric(6) primary key check(Matricola > 0),
    Dipartimento varchar(10) ,
    Nome varchar(30) not null,
    Cognome varchar(30) not null,
    Data_nascita date,
    Codice_Fiscale char(16) unique,
    Foto blob,
    foreign key (Dipartimento) references Dipartimento(Codice) on update cascade on delete cascade
  );

  drop table if exists Esame;
  create table Esame (
    Matricola_Studente numeric(6),
    Codice_Modulo char(6),
    Matricola_Docente numeric(6),
    Data date,
    Voto numeric(2) check(Voto > 17 and Voto < 32),
    Note varchar(150),
    foreign key (Matricola_Studente) references Studente(Matricola) on update cascade on delete cascade,
    foreign key (Codice_Modulo) references Modulo(Codice) on update cascade on delete cascade,
    foreign key (Matricola_Docente) references Docente(Matricola) on update cascade on delete cascade
  );

 insert into Corso_Laurea values
   ("ICD","Informatica e Comunicazione Digitale",NULL);

  insert into Corso_Laurea values
     ("INF","Informatica",NULL);

     insert into Corso_Laurea values
       ("GIU","Giurisprudenza",NULL);

  insert into Studente values
  (189274,"ICD","Francesco","Dicursi","1999-09-25","DCRFNC99P25E882Y",NULL);

  insert into Studente values
  (189175,"ICD","Cosimo","Donati","1996-08-13","DNTCSM96P13E882J",NULL);

  insert into Studente values
  (189674,"INF","Francesco","Greco","1997-11-25","GRCFNC97P25E882U",NULL);

  insert into Modulo values
    ("PROG01", "Programmazione",NULL,12);

    insert into Modulo values
      ("AMAT01", "Analisi Matematica",NULL,9);

      insert into Modulo values
        ("LABINF", "Laboratorio di Informatica",NULL,6);

    insert into Dipartimento values
    ("DIB","Dipartimento di Informatica");
    insert into Dipartimento values
    ("DMB","Dipartimento di Matematica");
    insert into Dipartimento values
    ("DGB","Dipartimento di Giurisprudenza");

    insert into Sede values
    ("0123","Via E. Orabona, 4","Bari");
    insert into Sede values
    ("0231","Piazza Cesare Battisti, 1","Bari");
    insert into Sede values
    ("0321","Via E. Orabona, 4","Bari");

    insert into Sede_Dipartimento values
    ("0123","DIB",NULL);
    insert into Sede_Dipartimento values
    ("0231","DGB",NULL);
    insert into Sede_Dipartimento values
    ("0321","DMB",NULL);


    insert into Docente values
    (986486,"DIB","Miguel","Ceriani","1990-11-25","CRNMGL90P11E882U",NULL);
    insert into Docente values
    (987586,"DMB","Giuseppina","Settanni","1985-10-11","STNGSP85P10E882K",NULL);
    insert into Docente values
    (686486,"DIB","Antonio","Piccinno","1986-03-11","PCCANT86P11E882R",NULL);
