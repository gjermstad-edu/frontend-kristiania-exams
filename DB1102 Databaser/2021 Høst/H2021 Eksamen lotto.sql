DROP SCHEMA IF EXISTS lotto;
CREATE SCHEMA lotto;
USE lotto;

CREATE TABLE Fylke(
FylkeID char(2),
Innbyggertall INT,
Navn varchar(128),
PRIMARY KEY (FylkeID)
);

CREATE TABLE Kommune(
KommuneID char(4),
Fylke char(2),
Innbyggertall INT,
Navn varchar(128),
PRIMARY KEY (KommuneID),
FOREIGN KEY (Fylke) REFERENCES Fylke (FylkeID)
);

CREATE TABLE Spiller(
SpillerNr INT,
Navn varchar(128),
Adresse varchar(128),
KommuneID  char(4),
PRIMARY KEY (SpillerNr),
FOREIGN KEY (KommuneID) REFERENCES Kommune (KommuneID)
);

CREATE TABLE Ansatt(
AnsattID INT,
Navn varchar(128),
KommuneID  char(4),
PRIMARY KEY (AnsattID),
FOREIGN KEY (KommuneID) REFERENCES Kommune (KommuneID)
);

CREATE TABLE Trekning(
TrekningsID INT,
Dato DATE,
Utbetaling INT,
AnsattID INT,
PRIMARY KEY (TrekningsID),
FOREIGN KEY (AnsattID) REFERENCES Ansatt (AnsattID)
);

CREATE TABLE Vinner(
SpillerNr INT,
TrekningsID INT,
PRIMARY KEY (SpillerNr,TrekningsID),
FOREIGN KEY (SpillerNr) REFERENCES Spiller (SpillerNr),
FOREIGN KEY (TrekningsID) REFERENCES Trekning (TrekningsID)
);

INSERT INTO Fylke VALUES
('03', 697010, 'Oslo'),
('11', 479892, 'Rogaland'),
('15', 265238, 'Møre og Romsdal'),
('18', 241235, 'Nordland'),
('30', 1241165, 'Viken'),
('34', 371385, 'Innlandet');

INSERT INTO Kommune VALUES
('0301', '03', 697010, 'Oslo'),
('1101', '11', 14787, 'Eigersund'),
('1103', '11', 144147, 'Stavanger'),
('1106', '11', 37323, 'Haugesund'),
('1515', '15', 8858, 'Herøy'),
('1507', '15', 66670, 'Ålesund'),
('1818', '18', 1793, 'Herøy'),
('3018', '30', 5805, 'Våler'),
('3020', '30', 60034, 'Nordre Follo'),
('3419', '34', 3587, 'Våler'),
('3420', '34', 21292, 'Elverum');

INSERT INTO Spiller VALUES
(1,'Per Persen','Lilleveien 1','0301'),
(2,'Jenny Olsen','Storeveien 2','1101'),
(3,'Abraham Jones','Kryssveien 3','1101'),
(4,'Kari Karisen','Amalies gate 2','1103'),
(5,'Benny Bettong','Kong vinters gate 77','1106'),
(6,'Sandra Salamander','Sesams gate 12','1515'),
(7,'Pelle Parafin','Parafinveien 11','1507'),
(8,'Ola Dunk','Sportveien 3','1818'),
(9,'Josefine Ingebritsen','Kuldegropen 18','1818'),
(10,'Harry Hole','Hurtigsvingen 2','3018'),
(11,'Josefine Hansen','Frydenbergveien 111','3020'),
(12,'Klas Klasen','Brattebakke 5','3419'),
(13,'Sonja Henja','Økernveien 18','3420');

INSERT INTO Ansatt VALUES
(1, 'Lars Lottosen', '0301'),
(2, 'Madeleine Heldigsen', '1818');

INSERT INTO Trekning VALUES
(1, '2021-11-06', 9756192, 1),
(2, '2021-11-13', 0, 1),
(3, '2021-11-20', 21234543, 2),
(4, '2021-11-27', 8765294, 2);

INSERT INTO Vinner VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,3),
(6,3),
(7,3),
(8,3),
(9,4),
(10,4),
(11,4),
(12,4),
(13,4),
(1,4);