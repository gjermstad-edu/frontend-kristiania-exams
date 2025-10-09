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

-- a) Lag en spørring som gir informasjon om hvilken av de registrete kommunene som har størst innbyggertall, og hva denne kommunen heter.
SELECT navn, Innbyggertall
FROM kommune
ORDER BY Innbyggertall DESC
LIMIT 1;

-- b) Lag en spørring som gir informasjon om hvilke registrerte spille som bor i en kommune som heter Herøy.
SELECT * from spiller WHERE kommuneId IN(
SELECT KommuneId from kommune WHERE navn = 'Herøy');

-- c) Lag en spørring som gir navn på alle registrerte kommuner som har samme navn, men ligger i forskjellige fylker.
SELECT Navn 
FROM kommune AS k1
WHERE Navn IN (
    SELECT Navn 
    FROM kommune AS k2 
    WHERE k1.Navn = k2.Navn AND k1.Fylke!=k2.Fylke
);


-- d) Lag en spørring som viser hvor mange registrerte kommuner som har en liten 'u' i navnet sitt. Navngi kolonnen i svaret: Antall U-Kommuner.
SELECT COUNT(*) AS 'Antall U-Kommuner' FROM kommune WHERE KommuneID IN(
SELECT KommuneID FROM kommune WHERE navn LIKE '%u%');

-- e)	Lag en spørring som viser hvilket fylke som samlet sett har hatt flest premievinnere til nå. Resultatet skal vise fylket, og antall vinnere.
-- Hvis noen har vunnet flere ganger, så skal de telles for hver gang de vinner.
SELECT Fylke.Navn, Count(*)  AS 'Antall vinnere' FROM 
fylke join kommune ON
fylke.fylkeId = kommune.fylke
JOIN spiller ON spiller.kommuneId = kommune.kommuneId
JOIN vinner ON vinner.spillerNr = spiller.spillerNr
GROUP BY Fylke.Navn
ORDER BY Count(*) DESC
LIMIT 1;

-- f) Lag en spørring som viser hvilke trekninger som ikke har hatt noen vinnere. Resultatet skal vise trekningens dato, og navnet på hvem som var trekningsansvarlig.
SELECT Dato, Navn FROM trekning
JOIN ansatt ON trekning.AnsattID = ansatt.AnsattID
WHERE TrekningsID NOT IN(
SELECT TrekningsId FROM Vinner);

-- g) Lag en spørring som viser navn på spillere har vunnet flere enn en gang, hvor mange ganger de har vunnet, og hvilken kommune de bor i.
SELECT spiller.navn, count(*) as 'Antall gevinster', kommune.navn AS 'Bor i' FROM 
spiller JOIN vinner ON spiller.SpillerNr = vinner.SpillerNr
JOIN kommune ON kommune.KommuneID = spiller.KommuneID
GROUP BY spiller.SpillerNr
HAVING COUNT(*)>1;

-- h) Legg inn en ny kolonne Areal i kommunetabellen. Legg inn fornuftige verdier i den nye kolonnen for de eksisterende kommunene.
-- Velg datatype du selv mener er passende. Arealet skal oppgis i antall kvadratkilometer, med to desimaler.
ALTER TABLE kommune ADD COLUMN Areal Decimal(6,2);
UPDATE kommune SET Areal = 454.09 WHERE KommuneID = '0301';
UPDATE kommune SET Areal = 432.48 WHERE KommuneID = '1101';
UPDATE kommune SET Areal = 262.52 WHERE KommuneID = '1103';
UPDATE kommune SET Areal = 72.68 WHERE KommuneID = '1106';
UPDATE kommune SET Areal = 119.52 WHERE KommuneID = '1515';
UPDATE kommune SET Areal = 632.42 WHERE KommuneID = '1507';
UPDATE kommune SET Areal = 64.46 WHERE KommuneID = '1818';
UPDATE kommune SET Areal = 256.96 WHERE KommuneID = '3018';
UPDATE kommune SET Areal = 203 WHERE KommuneID = '3020';
UPDATE kommune SET Areal = 705.29 WHERE KommuneID = '3419';
UPDATE kommune SET Areal = 1229.28 WHERE KommuneID = '3420';

-- i) Det har vært en ny trekning. Legg inn følgende informasjon i databasen:
-- Trekningen ble avholdt 4. desember 2021. Det var nøyaktig 11 millioner i utbetaling.
-- Det var en ny trekningsansvarlig: Jens Jensen, som bor i Oslo.
-- Det var to vinnere som delte utbetalingen: Lars Andersen, som bor i Ålesund (Lilliveien 56) og Line Jensen som bor på Elverum (Blåklokkaleen 4).
INSERT INTO Ansatt VALUES (3, 'Jens Jensen', (SELECT kommuneId FROM kommune WHERE navn = 'Oslo'));
INSERT INTO trekning VALUES (5, '2021-12-04', 11000000, 3);
INSERT INTO spiller VALUES (14,'Lars Andersen','Lilliveien 56',(SELECT kommuneId FROM kommune WHERE navn = 'Ålesund'));
INSERT INTO spiller VALUES (15,'Line Jensen','Blåklokkaleen 4',(SELECT kommuneId FROM kommune WHERE navn = 'Elverum'));
INSERT INTO vinner VALUES(14,5);
INSERT INTO vinner VALUES(15,5);

-- j) Lag et view som viser hvilke fylker som har vunnet hvor mye penger. Viewet skal inneholde fylkets navn, og totale utbetalinger til fylkets spillere, sortert slik at fylket som har vunnet mest kommer først.
CREATE OR REPLACE view utbetalingPerVinner AS
(
SELECT trekning.trekningsId, count(*), utbetaling / count(*) AS vinnerandel
from vinner JOIN trekning
ON vinner.TrekningsID = trekning.TrekningsID
GROUP BY TrekningsID);

CREATE OR REPLACE view fylkesUtbetalinger AS (
SELECT Fylke.Navn, SUM(vinnerandel) AS totalpremier
FROM 
fylke join kommune ON
fylke.fylkeId = kommune.fylke
JOIN spiller ON spiller.kommuneId = kommune.kommuneId
JOIN vinner ON vinner.spillerNr = spiller.spillerNr
JOIN utbetalingPerVinner ON vinner.TrekningsId = utbetalingPerVinner.trekningsId
GROUP BY Fylke.Navn
ORDER BY totalpremier DESC);
