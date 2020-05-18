/*Mostrare nome e descrizione di tutti i moduli da 9 CFU*/
SELECT Nome, Descrizione            /*PROJ(Nome,Descrizione)(SEL CFU=9 (MODULO)) */
FROM Modulo
WHERE CFU = 9;

/*Mostrare matricola, nome e cognome dei docenti che hanno più di 60 anni*/
SELECT Matricola, Nome, Cognome
FROM Docente
WHERE TIMESTAMPDIFF(YEAR,Data_nascita,CURDATE()) < 60;

/*Mostrare nome, cognome e nome del dipartimento di ogni docente, ordinati dal più giovane al più anziano*/
SELECT Docente.Nome, Docente.Cognome, D.Nome
FROM Docente, Dipartimento AS D
WHERE D.Codice = Docente.Dipartimento
ORDER BY Docente.Data_nascita DESC;

/*Mostrare città e indirizzo di ogni sede del dipartimento di codice "INFO" */
SELECT Sede.Citta, Sede.Indirizzo
FROM Sede_Dipartimento JOIN  Sede ON  Sede_Dipartimento.Codice_Sede = Sede.Codice JOIN Dipartimento ON Dipartimento.Codice=Codice_Dipartimento
WHERE Dipartimento.Codice="DIB";


/*Mostrare nome del dipartimento, città e indirizzo di ogni sede di ogni dipartimento, ordinate alfabeticamente prima per nome dipartimento, poi per nome città e infine per indirizzo.*/
SELECT Dipartimento.Nome,Sede.Citta, Sede.Indirizzo
FROM Sede_Dipartimento JOIN  Sede ON  Sede_Dipartimento.Codice_Sede = Sede.Codice JOIN Dipartimento ON Dipartimento.Codice=Codice_Dipartimento
ORDER BY Dipartimento.Nome, Sede.Citta, Sede.Indirizzo;


/*Mostrare il nome di ogni dipartimento che ha una sede a Bari.*/
SELECT Dipartimento.Nome
FROM Sede_Dipartimento JOIN  Sede ON  Sede_Dipartimento.Codice_Sede = Sede.Codice JOIN Dipartimento ON Dipartimento.Codice=Codice_Dipartimento
WHERE Citta="Bari";

/*Mostrare il nome di ogni dipartimento che non ha sede a Brindisi.*/
SELECT Dipartimento.Nome
FROM Sede_Dipartimento JOIN  Sede ON  Sede_Dipartimento.Codice_Sede = Sede.Codice JOIN Dipartimento ON Dipartimento.Codice=Codice_Dipartimento
WHERE Citta != "Brindisi";

/*Mostrare media, numero esami sostenuti e totale CFU acquisiti dello studente con matricola 123456*/
SELECT AVG(Voto) AS Media_voti, COUNT(*) AS Esami_sostenuti, SUM(CFU) AS Somma_CFU
FROM Modulo JOIN  Esame ON  Codice_Modulo = Codice
WHERE Matricola_Studente="189274";

/*Mostrare nome, cognome, nome del corso di laurea, media e numero esami sostenuti dello studente con matricola 123456.*/
SELECT Studente.Nome, Studente.Cognome, Corso_Laurea.Nome AS Corso_Laurea,AVG(Voto) AS Media_voti, COUNT(*) AS Esami_sostenuti
FROM Studente JOIN Corso_Laurea ON Studente.Corso_laurea=Corso_Laurea.Codice JOIN Esame ON Studente.Matricola=Esame.Matricola_Studente JOIN Modulo ON Codice_Modulo=Modulo.Codice
WHERE Studente.Matricola="189274";

/*Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media più alta alla più bassa.*/
SELECT Modulo.Codice, Modulo.Nome, AVG(Voto) AS Media_voti
FROM Modulo JOIN  Esame ON  Codice_Modulo = Codice
GROUP BY Modulo.Codice
ORDER BY Media_voti;

/*Mostrare nome e cognome del docente, nome e descrizione del modulo per ogni docente ed ogni modulo di cui quel docente abbia tenuto almeno un esame; il risultato deve includere anche i docenti che non abbiano tenuto alcun esame, in quel caso rappresentati con un'unica tupla in cui nome e descrizione del modulo avranno valore NULL.*/
SELECT DISTINCT D.Nome,D.Cognome, M.Nome, M.Descrizione
FROM Docente D LEFT JOIN (Modulo M JOIN Esame E ON M.Codice=E.Codice_Modulo) ON E.Matricola_Docente=D.Matricola;


/*Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente.*/
SELECT Matricola, Nome, Cognome, Data_nascita,AVG(Voto) AS Media_voti,COUNT(*) AS Esami_sostenuti
FROM Studente JOIN Esame ON Matricola=Matricola_Studente
GROUP BY Matricola;

/*Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente del corso di laurea di codice "ICD" che abbia media maggiore di 27.*/
SELECT Matricola, Nome, Cognome, Data_nascita,AVG(Voto) AS Media_voti,COUNT(*) AS Esami_sostenuti
FROM Studente JOIN Esame ON Matricola=Matricola_Studente
GROUP BY Matricola, Corso_laurea
HAVING Corso_laurea="ICD" AND Media_voti > 27;

/*Mostrare nome, cognome e data di nascita di tutti gli studenti che ancora non hanno superato nessun esame.*/
SELECT DISTINCT Nome, Cognome, Data_nascita
FROM Studente
WHERE NOT EXISTS (SELECT *
                  FROM Esame
                WHERE Matricola=Matricola_Studente);

/*Mostrare la matricola di tutti gli studenti che hanno superato almeno un esame e che hanno preso sempre voti maggiori di 26.*/
SELECT  DISTINCT Matricola
FROM Studente,  Esame
WHERE Matricola=Matricola_Studente AND Matricola NOT IN (SELECT Matricola_Studente
                                                                  FROM Esame
                                                                  WHERE Voto<26);

/*Mostrare, per ogni modulo, il numero degli studenti che hanno preso tra 18 e 21, quelli che hanno preso tra 22 e 26 e quelli che hanno preso tra 27 e 30 (con un'unica interrogazione).*/
/*SELECT COUNT(*) AS Numero_Studenti
FROM Studente,Esame
WHERE Matricola=Matricola_Studente
GROUP BY Esame.Codice_Modulo, Voto
HAVING Voto>= 18 AND Voto <= 21;*/



/*Mostrare matricola, nome, cognome e voto di ogni studente che ha preso un voto maggiore della media nel modulo "BDD"*/
SELECT Matricola, Nome, Cognome,Voto
FROM Studente JOIN Esame ON Matricola=Matricola_Studente
WHERE Codice_Modulo="PROG01" AND Voto > (SELECT AVG(Voto)
                                        FROM Esame);

/*Mostrare matricola, nome, cognome di ogni studente che ha preso ad almeno 3 esami un voto maggiore della media per quel modulo.*/
/*SELECT S.Matricola, S.Nome, S.Cognome
FROM Studente S, Esame E, Modulo M
WHERE (S.Matricola=E.Matricola_Studente AND E.Codice_Modulo=M.Codice)
GROUP BY S.Matricola, S.Nome, S.Cognome
HAVING COUNT(E.Voto > (SELECT avg(E.Voto)
                        FROM Esame E, Modulo M
                      WHERE (E.Codice_Modulo=M.Codice))) >= 3;*/
