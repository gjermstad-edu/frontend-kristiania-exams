DROP SCHEMA IF EXISTS arcade;
CREATE SCHEMA arcade;
USE arcade;

CREATE TABLE Spiller(
SpillerId INT,
Dato DATE,
Kode CHAR(3),
PRIMARY KEY (SpillerId)
);

CREATE TABLE Utvikler(
UtvId INT,
KontaktInfo VARCHAR(128),
Navn VARCHAR(128),
PRIMARY KEY (UtvId)
);

CREATE TABLE Spill(
SpillId INT,
Tittel VARCHAR(128),
Beskrivelse VARCHAR(256),
Lansert DATE,
Kategori ENUM('Adventure', 'Action', 'RPG', 'Simulation', 'Sports', 'Puzzle', 'Annet'),
PRIMARY KEY (SpillId)
);

CREATE TABLE SpillUtvikling(
UtvId INT,
SpillId INT,
Rolle ENUM('Programmerer', 'Designer', 'Tester', 'Annet', 'Manusforfatter'),
PRIMARY KEY (UtvId,SpillId),
CONSTRAINT SpillUtviklingSpillFK FOREIGN KEY (SpillId) REFERENCES Spill (SpillId),
CONSTRAINT SpillUtviklingUtviklerFK FOREIGN KEY (UtvId) REFERENCES Utvikler (UtvId)
);

CREATE TABLE Resultat(
SpillerId INT,
SpillId INT,
Tidspunkt DATETIME,
Score INT,
PRIMARY KEY (SpillerId,SpillId,Tidspunkt),
CONSTRAINT ResultatSpillFK FOREIGN KEY (SpillId) REFERENCES Spill (SpillId),
CONSTRAINT ResultatSpillerFK FOREIGN KEY (SpillerId) REFERENCES Spiller (SpillerId)
);

INSERT INTO Spiller VALUES
(1, '1974-01-21', 'ABC'),
(2, '1999-05-01', 'BCA'),
(3, '2000-04-05', 'XYZ'),
(4, '2001-03-03', 'Z_Z'),
(5, '2004-03-25', 'JES');

INSERT INTO Utvikler VALUES
(1, 'jens@online.no', 'Jens Jensen'),
(2, 'ida@online.no', 'Ida Idesen'),
(3, 'kvakker@gmail.no', 'Karius Olsen'),
(4, 'oda@hotmail.com', 'Oda Hansen'),
(5, 'jens.petrus@prk.no', 'Jens Petrus'),
(6, 'helene.olsen@online.no', 'Helene Olsen'),
(7, 'pelle.parafin@boeljeband.no', 'Pelle Parafin'),
(8, 'frida.frosk@boeljeband.no', 'Frida Frosk');

INSERT INTO Spill VALUES
(1, 'Blockbusters', 'En reise i filmens verden', '2020-03-05', 'Adventure'),
(2, 'Tetrimania', 'Velkjente utfordringer i ukjent terreng', '2020-04-06', 'Annet'),
(3, 'Valheimia', 'Tilbake til vikingetiden', '2021-07-07', 'RPG'),
(4, 'Pakk meg', 'Pakk riktig og raskt!', '2019-09-01', 'Puzzle'),
(5, 'Metropolis', 'Byen blir til...', '2019-12-02', 'Adventure'),
(6, 'Atalanta', 'Den ville vesten og ville vester', '2018-02-09', 'Puzzle'),
(7, 'Space Deflators', 'En oppdagelse i verdensrommet', '2018-04-06', 'RPG'),
(8, 'Galagu', 'Skyt i vei!', '2019-01-02', 'Action'),
(9, 'Dug Dig', 'Her skal det graves!', '2019-02-03', 'Simulation'),
(10, 'Masteroids', 'Pang, pang i verdensrommet', '2019-09-09', 'Action');

INSERT INTO SpillUtvikling VALUES
(1, 1, 'Programmerer'),
(1, 2, 'Designer'),
(2, 3, 'Programmerer'),
(2, 4, 'Programmerer'),
(3, 5, 'Tester'),
(6, 3, 'Programmerer'),
(7, 4, 'Manusforfatter'),
(4, 3, 'Programmerer'),
(5, 1, 'Programmerer'),
(5, 2, 'Manusforfatter'),
(5, 4, 'Tester'),
(6, 5, 'Designer'),
(8, 5, 'Annet'),
(2, 6, 'Designer'),
(2, 7, 'Programmerer'),
(3, 8, 'Programmerer'),
(3, 9, 'Designer'),
(4, 10, 'Programmerer'),
(7, 8, 'Tester'),
(8, 9, 'Programmerer'),
(5, 8, 'Designer'),
(6, 6, 'Programmerer'),
(6, 7, 'Manusforfatter'),
(6, 9, 'Manusforfatter'),
(7, 10, 'Annet'),
(1, 10, 'Tester');

INSERT INTO Resultat VALUES
(1,1,'2021-07-23 12:45:56', 19),
(1,2,'2021-07-24 12:45:56', 12),
(1,2,'2021-07-24 12:55:36', 55),
(1,3,'2021-07-24 14:15:16', 9),
(2,1,'2021-01-05 10:15:16', 112),
(2,1,'2021-01-05 11:14:27', 67),
(2,2,'2021-01-05 14:11:11', 33),
(2,2,'2021-01-06 10:15:16', 22),
(2,3,'2021-01-06 11:19:16', 198),
(2,4,'2021-01-06 15:17:46', 0),
(2,4,'2021-01-06 15:27:32', 77),
(3,1,'2021-02-11 09:13:42', 101),
(3,1,'2021-02-11 10:23:55', 99),
(3,1,'2021-02-11 11:12:11', 44),
(3,1,'2021-02-11 11:23:45', 55),
(3,1,'2021-02-12 12:13:22', 18),
(3,1,'2021-02-12 12:24:53', 19),
(3,5,'2021-02-12 12:30:18', 182),
(3,5,'2021-02-12 12:42:59', 88),
(4,2,'2022-02-11 11:33:45', 33),
(4,2,'2022-02-11 12:22:33', 29),
(4,2,'2022-02-11 13:34:15', 17),
(4,3,'2022-02-11 13:53:22', 78),
(4,4,'2022-02-11 14:33:19', 111),
(5,2,'2022-02-21 09:11:12', 216),
(5,2,'2022-02-21 10:20:23', 14),
(5,2,'2022-02-21 10:31:24', 56),
(5,2,'2022-02-22 12:44:55', 83),
(5,4,'2022-02-22 13:12:13', 22),
(5,4,'2022-02-22 13:22:22', 69),
(5,4,'2022-02-22 13:44:44', 54),
(5,4,'2022-02-23 08:12:12', 32),
(5,4,'2022-02-23 09:22:33', 27),
(5,4,'2022-02-23 10:12:23', 28),
(5,5,'2022-02-23 11:32:55', 88),
(1,6,'2019-10-23 12:45:56', 37),
(1,7,'2019-10-24 13:23:16', 121),
(1,7,'2019-11-24 14:55:36', 94),
(1,8,'2019-11-24 15:15:16', 23),
(2,6,'2019-12-05 10:15:17', 12),
(2,6,'2020-01-05 11:14:27', 61),
(2,7,'2020-01-05 09:12:13', 53),
(2,7,'2020-02-06 10:15:16', 29),
(2,8,'2020-02-06 11:19:16', 108),
(2,9,'2020-03-06 15:17:46', 10),
(2,9,'2020-04-06 15:27:32', 1),
(3,6,'2020-05-11 09:13:42', 55),
(3,6,'2020-05-11 10:23:55', 22),
(3,6,'2021-01-11 11:12:11', 33),
(3,6,'2021-02-11 11:23:45', 12),
(3,6,'2021-03-12 12:13:22', 64),
(3,6,'2021-03-12 12:24:53', 35),
(3,10,'2021-03-12 12:30:18', 112),
(3,10,'2021-04-12 12:42:59', 78),
(4,7,'2022-04-11 11:33:45', 25),
(4,7,'2022-05-11 12:22:33', 83),
(4,7,'2022-05-11 13:34:15', 24),
(4,7,'2022-05-11 13:53:22', 55),
(4,9,'2022-05-11 14:33:19', 121),
(5,7,'2022-06-21 09:11:12', 116),
(5,7,'2022-06-21 10:20:23', 74),
(5,7,'2022-06-21 10:31:24', 59),
(5,7,'2022-06-22 12:44:55', 85),
(5,9,'2022-07-22 13:12:13', 52),
(5,9,'2022-07-22 13:22:22', 19),
(5,9,'2022-07-22 13:44:44', 0),
(5,9,'2022-07-23 08:12:12', 36),
(5,9,'2022-07-23 09:22:33', 12),
(5,9,'2022-08-23 10:12:23', 67),
(5,10,'2022-08-23 11:32:55', 119);