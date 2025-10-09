DROP SCHEMA IF EXISTS jernbane;
CREATE SCHEMA jernbane;
USE jernbane;

DROP TABLE IF EXISTS togrute;
CREATE TABLE togrute (
  RuteNr varchar(100) NOT NULL,
  PRIMARY KEY (RuteNr)
);

DROP TABLE IF EXISTS avgang;
CREATE TABLE avgang (
  AvgNr int NOT NULL AUTO_INCREMENT,
  AntallPlasser int NOT NULL,
  Restaurant boolean NOT NULL,
  RuteNr varchar(100) NOT NULL,
  PRIMARY KEY (AvgNr),
  KEY AvgangTogruteFK (RuteNr),
  CONSTRAINT AvgangTogruteFK FOREIGN KEY (RuteNr) REFERENCES togrute (RuteNr)
);

DROP TABLE IF EXISTS kunde;
CREATE TABLE kunde (
  KNr int NOT NULL AUTO_INCREMENT,
  Fornavn varchar(100) NOT NULL,
  Etternavn varchar(100) NOT NULL,
  PRIMARY KEY (KNr)
);

DROP TABLE IF EXISTS stasjon;
CREATE TABLE stasjon (
  SNr int NOT NULL AUTO_INCREMENT,
  Bemannet boolean NOT NULL,
  Navn varchar(100) NOT NULL,
  Åpner time,
  Tlf char(8),
  Lukker time,
  PRIMARY KEY (SNr)
);

DROP TABLE IF EXISTS reservasjon;
CREATE TABLE reservasjon (
  ResNr int NOT NULL AUTO_INCREMENT,
  Antall int NOT NULL,
  KNr int NOT NULL,
  AvgNr int NOT NULL,
  Fra int NOT NULL,
  Til int NOT NULL,
  PRIMARY KEY (ResNr),
  KEY ReservasjonStasjonFK (Fra),
  KEY ReservasjonStasjonFK2 (Til),
  KEY ReservasjonKundeFK (KNr),
  KEY ReservasjonAvgangFK (AvgNr),
  CONSTRAINT ReservasjonAvgangFK FOREIGN KEY (AvgNr) REFERENCES avgang (AvgNr),
  CONSTRAINT ReservasjonKundeFK FOREIGN KEY (KNr) REFERENCES kunde (KNr),
  CONSTRAINT ReservasjonStasjonFK FOREIGN KEY (Fra) REFERENCES stasjon (SNr),
  CONSTRAINT ReservasjonStasjonFK2 FOREIGN KEY (Til) REFERENCES stasjon (SNr)
);

DROP TABLE IF EXISTS stopp;
CREATE TABLE stopp (
  Ankomst time NOT NULL,
  AvgNr int NOT NULL,
  Avreise time,
  SNr int NOT NULL,
  PRIMARY KEY (Ankomst,AvgNr),
  KEY StoppStasjonFK (SNr),
  KEY StoppAvgangFK (AvgNr),
  CONSTRAINT StoppAvgangFK FOREIGN KEY (AvgNr) REFERENCES avgang (AvgNr),
  CONSTRAINT StoppStasjonFK FOREIGN KEY (SNr) REFERENCES stasjon (SNr)
);

DROP TABLE IF EXISTS stoppested;
CREATE TABLE stoppested (
  StoppNr int NOT NULL,
  RuteNr varchar(100) NOT NULL,
  SNr int NOT NULL,
  PRIMARY KEY (StoppNr,RuteNr),
  KEY StoppestedStasjonFK (SNr),
  KEY StoppestedTogruteFK (RuteNr),
  CONSTRAINT StoppestedStasjonFK FOREIGN KEY (SNr) REFERENCES stasjon (SNr),
  CONSTRAINT StoppestedTogruteFK FOREIGN KEY (RuteNr) REFERENCES togrute (RuteNr)
);

INSERT INTO togrute VALUES ('L1'),('L2'),('L3');

INSERT INTO kunde (Fornavn, Etternavn) VALUES 
('Hans','Hansen'),
('Kari','Normann'),
('Jens','Hansen'),
('Kari','Olsen'),
('Oda','Hansen'),
('Willy','Olsen'),
('Eva','Jensen'),
('Eva','Dahl'),
('Lars','Larsen'),
('Vivian','Eilertsen');

INSERT INTO stasjon (Bemannet, Navn, Åpner, Tlf, Lukker) VALUES
(true,'Spikkestad','08:00:00','22222222','20:00:00'),
(true,'Røyken','08:00:00','22222223','20:00:00'),
(true,'Asker','08:00:00','22222224','20:00:00'),
(false,'Hvalstad',NULL,NULL,NULL),
(true,'Høvik','08:00:00','22222226','20:00:00'),
(false,'Stabekk',NULL,NULL,NULL),
(true,'Skøyen','08:00:00','22222228','20:00:00'),
(true,'Nationaltheateret','09:00:00','22222229','23:00:00'),
(true,'Oslo S','07:00:00','22222230','20:00:00'),
(false,'Alna',NULL,NULL,NULL),
(true,'Lørenskog','08:00:00','22222232','20:00:00'),
(false,'Fjellhamar',NULL,NULL,NULL),
(true,'Strømmen','07:00:00','22222234','20:00:00'),
(true,'Lillestrøm','06:00:00','22222235','22:00:00'),
(false,'Nordstrand',NULL,NULL,NULL),
(true,'Kolbotn','08:00:00','22222236','20:00:00'),
(false,'Greverud',NULL,NULL,NULL),
(false,'Vevelstad',NULL,NULL,NULL),
(true,'Ski','07:00:00','22222237','19:00:00'),
(true,'Grefsen','08:00:00','22222238','19:00:00'),
(false,'Snippen',NULL,NULL,NULL),
(false,'Movatn',NULL,NULL,NULL),
(true,'Nittedal','07:30:00','22222238','19:30:00'),
(true,'Jaren','07:40:00','22222239','19:50:00');

INSERT INTO Avgang(AntallPlasser, Restaurant, RuteNr) VALUES
(100, false, 'L1'),
(100, false, 'L1'),
(100, false, 'L1'),
(150, false, 'L2'),
(150, false, 'L2'),
(190, true, 'L3'),
(190, false, 'L3');

INSERT INTO Stopp(Ankomst, AvgNr, Avreise, SNr) VALUES
('09:55:00', 6, '10:01:00', 9),
('10:10:00', 6, '10:11:00', 20),
('10:19:00', 6, '10:20:00', 21),
('10:25:00', 6, '10:26:00', 22),
('10:41:00', 6, '10:42:00', 23),
('10:59:00', 6, NULL, 24),
('10:55:00', 7, '11:01:00', 9),
('11:10:00', 7, '11:11:00', 20),
('11:19:00', 7, '11:20:00', 21),
('11:25:00', 7, '11:26:00', 22),
('11:41:00', 7, '11:42:00', 23),
('11:59:00', 7, NULL, 24),
('05:15:00', 4, '05:20:00', 6),
('05:26:00', 4, '05:28:00', 7),
('05:30:00', 4, '05:32:00', 8),
('05:35:00', 4, '05:37:00', 9),
('05:41:00', 4, '05:42:00', 15),
('05:52:00', 4, '05:54:00', 16),
('05:58:00', 4, '05:59:00', 17),
('06:02:00', 4, '06:03:00', 18),
('06:09:00', 4, NULL, 19),
('06:15:00', 5, '06:20:00', 6),
('06:26:00', 5, '06:28:00', 7),
('06:30:00', 5, '06:32:00', 8),
('06:35:00', 5, '06:37:00', 9),
('06:41:00', 5, '06:42:00', 15),
('06:52:00', 5, '06:54:00', 16),
('06:58:00', 5, '06:59:00', 17),
('07:02:00', 5, '07:03:00', 18),
('07:09:00', 5, NULL, 19),
('05:10:00', 1, '05:15:00', 1),
('05:19:00', 1, '05:20:00', 2),
('05:34:00', 1, '05:36:00', 3),
('05:40:00', 1, '05:41:00', 4),
('05:53:00', 1, '05:54:00', 5),
('05:56:00', 1, '05:57:00', 6),
('06:02:00', 1, '06:04:00', 7),
('06:06:00', 1, '06:08:00', 8),
('06:09:00', 1, '06:11:00', 9),
('06:18:00', 1, '06:19:00', 10),
('06:29:00', 1, '06:30:00', 11),
('06:33:00', 1, '06:34:00', 12),
('06:35:00', 1, '06:36:00', 13),
('06:40:00', 1, NULL, 14),
('06:10:00', 1, '06:15:00', 1),
('06:19:00', 2, '06:20:00', 2),
('06:34:00', 2, '06:36:00', 3),
('06:40:00', 2, '06:41:00', 4),
('06:53:00', 2, '06:54:00', 5),
('06:56:00', 2, '06:57:00', 6),
('07:02:00', 2, '07:04:00', 7),
('07:06:00', 2, '07:08:00', 8),
('07:09:00', 2, '07:11:00', 9),
('07:18:00', 2, '07:19:00', 10),
('07:29:00', 2, '07:30:00', 11),
('07:33:00', 2, '07:34:00', 12),
('07:35:00', 2, '07:36:00', 13),
('07:40:00', 2, NULL, 14),
('07:10:00', 1, '07:15:00', 1),
('07:19:00', 3, '07:20:00', 2),
('07:34:00', 3, '07:36:00', 3),
('07:40:00', 3, '07:41:00', 4),
('07:53:00', 3, '07:54:00', 5),
('07:56:00', 3, '07:57:00', 6),
('08:02:00', 3, '08:04:00', 7),
('08:06:00', 3, '08:08:00', 8),
('08:09:00', 3, '08:11:00', 9),
('08:18:00', 3, '08:19:00', 10),
('08:29:00', 3, '08:30:00', 11),
('08:33:00', 3, '08:34:00', 12),
('08:35:00', 3, '08:36:00', 13),
('08:40:00', 3, NULL, 14);

INSERT INTO Stoppested (StoppNr, RuteNr, SNr) VALUES
(1,'L1',1),
(2,'L1',2),
(3,'L1',3),
(4,'L1',4),
(5,'L1',5),
(6,'L1',6),
(7,'L1',7),
(8,'L1',8),
(9,'L1',9),
(10,'L1',10),
(11,'L1',11),
(12,'L1',12),
(13,'L1',13),
(14,'L1',14),
(1,'L2',6),
(2,'L2',7),
(3,'L2',8),
(4,'L2',9),
(5,'L2',15),
(6,'L2',16),
(7,'L2',17),
(8,'L2',18),
(9,'L2',19),
(1,'L3',9),
(2,'L3',20),
(3,'L3',21),
(4,'L3',22),
(5,'L3',23),
(6,'L3',24);

INSERT INTO reservasjon (Antall, KNr, AvgNr, Fra, Til) VALUES
(2, 1, 1, 3, 5),
(3, 2, 2, 4, 8),
(5, 3, 3, 2, 10),
(8, 4, 4, 6, 18),
(4, 1, 5, 7, 17),
(2, 5, 6, 9, 23);

-- A) Lag en SQL som henter ut all informasjon om alle stasjoner. Sorter resultatet på stasjonens navn.
SELECT * FROM stasjon
ORDER by navn;

-- B) Lag en SQL som henter ut navn og åpningstider for alle stasjoner som er bemannet.
SELECT navn, Åpner, Lukker FROM Stasjon
WHERE Bemannet = true;

-- C) Vivian Eilertsen ønsker å reservere to billetter på TogRute L2 fra Oslo S til Greverud med avgang fra Oslo S kl 06.37.
-- Lag en SQL som legger inn reservasjonen.
INSERT INTO Reservasjon(Antall, KNr, AvgNr, Fra, Til) VALUES
(2, 
(SELECT KNr FROM Kunde WHERE Fornavn = 'Vivian' AND Etternavn = 'Eilertsen'),
(SELECT AvgNr FROM Stopp WHERE Avreise = '06:37:00' AND SNr = 9),
9,
17);

-- D) Lag en SQL som henter ut informasjon om hvor mange stoppesteder det er på de ulike togrutene. Kall kolonnen med antall stoppesteder for AntStoppesteder.
SELECT COUNT(*) AS AntStoppesteder, RuteNr FROM Stoppested
GROUP BY RuteNr;

-- E) Hent ut navn på alle stasjoner på stoppesteder på togruten 'L1'
SELECT Navn FROM stasjon WHERE SNr IN(
SELECT SNr FROM Stoppested WHERE RuteNr = 'L1');
-- evt
SELECT navn FROM stasjon NATURAL JOIN stoppested WHERE stoppested.RuteNr = 'L1';

-- F) Gode nyheter! Greverud stasjon skal bli bemannet med åpningstider 8-16. De har telefonnummer: 67676767.
-- Lag en SQL som oppdaterer Greverud stasjon.
UPDATE Stasjon SET Bemannet = true, Åpner = '08:00:00', Lukker = '16:00:00', Tlf='67676767'
WHERE Navn = 'Greverud';

-- G) Lag en SQL som henter ut informasjon om alle stoppesteder på rute L2.
-- Kolonnene skal være: StoppNr, Stasjonsnavn og om stasjonen er bemannet.
-- Resultatet skal sorteres på StoppNr.
SELECT sto.StoppNr, sta.navn AS Stasjonsnavn, sta.bemannet
FROM stoppested sto JOIN stasjon sta
ON sto.SNr = sta.SNr
WHERE sto.RuteNr = 'L2'
ORDER BY StoppNr;

-- H) Lag en spørring som henter ut informasjon om alle unike etternavn i tabellen kunde, og hvor mange ganger de
-- unike etternavnene forekommer. Sorter resultatet slik at det vanligste etternavnet kommer først, og alfabetisk hvis antallet er likt.
SELECT Etternavn, Count(*) AS Antall
FROM Kunde
GROUP BY Etternavn
ORDER BY Count(*) DESC, Etternavn;
 

-- I) (Vanskelig) Lag et View (Reservasjonsinformasjon) som viser alle reservasjon med tilhørende informasjon om
-- Fornavn og etternavn på den som har reservert.
-- Navnet på stasjonene som reservasjonene gjelder (fra og til)
-- Om det er restaurant på avgangen.
-- Når toget går og ankommer.
-- Kolonnene skal være slik: Reservasjonsnummer, Fornavn, Etternavn, Rutenummer, Restaurant, Avreisetidspunkt, FraStasjon, Ankomsttidspunkt, TilStasjon.
-- I kolonnen Restaurant skal det stå 'Ja', hvis avgangen har restaurant om bord, og 'Nei' hvis den ikke har det.  Hint: CASE.
-- For kolonnene som omhandler tidspunkt (avreise og ankomst) skal tiden vises i timer og minutter (ikke sekunder). Hint: TIME_FORMAT.
CREATE OR REPLACE VIEW Reservasjonsinformasjon AS(
SELECT r.ResNr AS Reservasjonsnummer, k.fornavn, k.etternavn, a.RuteNr AS Rutenummer,
CASE a.restaurant WHEN true THEN 'Ja' ELSE 'Nei' END AS Restaurant,
TIME_FORMAT(st1.avreise, '%H:%i') AS Avgang, s1.navn AS FraStasjon, TIME_FORMAT(st2.ankomst, '%H:%i') AS Ankomst, s2.navn AS TilStasjon
FROM reservasjon r JOIN Kunde k ON k.KNr = r.KNr
JOIN Stasjon s1 ON r.fra = s1.SNr
JOIN Stasjon s2 ON r.til = s2.SNr
JOIN avgang a ON r.AvgNr = a.AvgNr
JOIN Stopp st1 ON st1.AvgNr = a.AvgNr AND st1.SNr = s1.SNr
JOIN Stopp st2 ON st2.AvgNr = a.AvgNr AND st2.SNr = s2.SNr);

SELECT * FROM Reservasjonsinformasjon;

-- J) Vi ønsker å legge til informasjon om avganger har toalett om bord, eller ikke.
-- Lag en SQL som endrer Avgang slik at tabellen også inneholder informasjon om toalett.
-- Hvis informasjon om toalett ikke blir registrert skal standard-verdien (default value) være at det ikke har toalett.
ALTER TABLE Avgang ADD COLUMN Toalett BOOLEAN DEFAULT false;