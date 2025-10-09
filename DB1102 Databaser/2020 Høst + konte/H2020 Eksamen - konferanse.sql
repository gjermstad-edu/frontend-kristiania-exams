DROP SCHEMA IF EXISTS konferanse;
CREATE SCHEMA konferanse;
USE konferanse;
DROP TABLE IF EXISTS Forfatter;
DROP TABLE IF EXISTS Presentasjon;
DROP TABLE IF EXISTS Rom;
DROP TABLE IF EXISTS DeltakerTema;
DROP TABLE IF EXISTS MåltidBestilling;
DROP TABLE IF EXISTS Deltaker;
DROP TABLE IF EXISTS Tema;
DROP TABLE IF EXISTS Måltid;

CREATE TABLE Måltid(
MåltidType enum('Middag', 'Lunsj'),
DagNr INT,
MåltidPris INT NOT NULL,
PRIMARY KEY (MåltidType,DagNr)
);

CREATE TABLE Tema(
TemaNr INT AUTO_INCREMENT,
TemaNavn VARCHAR(100) NOT NULL,
PRIMARY KEY (TemaNr)
);

CREATE TABLE Deltaker(
DNr INT AUTO_INCREMENT,
Fornavn VARCHAR(100) NOT NULL,
Etternavn VARCHAR(100) NOT NULL,
EPost VARCHAR(100) NOT NULL,
PRIMARY KEY (DNr)
);

CREATE TABLE MåltidBestilling(
DNr INT,
MåltidType enum('Middag', 'Lunsj'),
DagNr INT,
PRIMARY KEY (DNr, MåltidType, DagNr)
);

CREATE TABLE DeltakerTema(
DNr INT,
TemaNr INT,
PRIMARY KEY (DNr, TemaNr)
);

CREATE TABLE Rom(
RomNr VARCHAR(100),
AntPlasser INT NOT NULL,
PRIMARY KEY (RomNr)
);

CREATE TABLE Presentasjon(
PresNr INT AUTO_INCREMENT,
Tittel VARCHAR(200) NOT NULL,
Sammendrag VARCHAR(1000) NOT NULL,
Varighet INT NOT NULL,
StartTid DATETIME NOT NULL,
URL VARCHAR(100) NOT NULL,
TemaNr INT NOT NULL,
RomNr VARCHAR(100) NOT NULL,
DNr INT NOT NULL,
PRIMARY KEY (PresNr)
);

CREATE TABLE Forfatter(
DNr INT AUTO_INCREMENT,
PresNr INT NOT NULL,
PRIMARY KEY (DNr, PresNr)
);


ALTER TABLE Forfatter
 ADD CONSTRAINT ForfatterPresentasjonFK FOREIGN KEY (PresNr) REFERENCES Presentasjon (PresNr);

ALTER TABLE Presentasjon
 ADD CONSTRAINT PresentasjonRomFK FOREIGN KEY (RomNr) REFERENCES Rom (RomNr);

ALTER TABLE Presentasjon
 ADD CONSTRAINT PresentasjonDeltakerFK FOREIGN KEY (DNr) REFERENCES Deltaker (DNr);

ALTER TABLE MåltidBestilling
 ADD CONSTRAINT MåltidBestillingDeltakerFK FOREIGN KEY (DNr) REFERENCES Deltaker (DNr);

ALTER TABLE DeltakerTema
 ADD CONSTRAINT DeltakerTemaDeltakerFK FOREIGN KEY (DNr) REFERENCES Deltaker (DNr);

ALTER TABLE Forfatter
 ADD CONSTRAINT ForfatterDeltakerFK FOREIGN KEY (DNr) REFERENCES Deltaker (DNr);

ALTER TABLE Presentasjon
 ADD CONSTRAINT PresentasjonTemaFK FOREIGN KEY (TemaNr) REFERENCES Tema (TemaNr);

ALTER TABLE DeltakerTema
 ADD CONSTRAINT DeltakerTemaTemaFK FOREIGN KEY (TemaNr) REFERENCES Tema (TemaNr);

ALTER TABLE MåltidBestilling
 ADD CONSTRAINT MåltidBestillingMåltidFK FOREIGN KEY (MåltidType,DagNr) REFERENCES Måltid (MåltidType,DagNr);
 
 INSERT INTO Rom
 VALUES ('A1', 100);
 INSERT INTO Rom
 VALUES ('F1', 50);
 INSERT INTO Rom
 VALUES ('F2', 40);
 
 INSERT INTO Måltid
 VALUES ('Lunsj', 1, 129);
 INSERT INTO Måltid
 VALUES ('Middag', 1, 149);
 INSERT INTO Måltid
 VALUES ('Lunsj', 2, 119);
 INSERT INTO Måltid
 VALUES ('Middag', 2, 159);
 
 INSERT INTO Tema (TemaNavn)
 VALUES ('Performance and Optimization');
 INSERT INTO Tema (TemaNavn)
 VALUES ('IT didactics');
 INSERT INTO Tema (TemaNavn)
 VALUES ('Digital transformation');
 INSERT INTO Tema (TemaNavn)
 VALUES ('Cyber security');
 INSERT INTO Tema (TemaNavn)
 VALUES ('Digital innovation');
 
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Hans', 'Hansen', 'hans@hansen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Kari', 'Normann', 'kari@normann.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Jens', 'Jensen', 'jens@jensen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Eva', 'Dahl', 'eva@dahl.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Ole', 'Olsen', 'ole@olsen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Benny', 'Ball', 'benny@benny.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Oline', 'Jensen', 'o-j@jensen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Hans', 'Jensen', 'hj@jensen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Sandra', 'Salamander', 'sandra@ppbb.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Billy', 'Betong', 'billy@ppbb.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Pelle', 'Parafin', 'pelle@ppbb.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Frida', 'Frosk', 'frida@ppbb.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Leon', 'Latex', 'leon@ppbb.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Ragna', 'Rekkverk', 'ragna@ppbb.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Anders', 'Andersen', 'anders@andersen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Julie', 'Jensen', 'julie@jensen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Igor', 'Olsen', 'igor@olsen.no');
 INSERT INTO Deltaker (Fornavn, Etternavn, Epost)
 VALUES ('Svetlana', 'Iversen', 'svetlana@olsen.no');
 
 INSERT INTO DeltakerTema VALUES (1,1);
 INSERT INTO DeltakerTema VALUES (1,2);
 INSERT INTO DeltakerTema VALUES (1,3);
 INSERT INTO DeltakerTema VALUES (1,4);
 INSERT INTO DeltakerTema VALUES (1,5);
 INSERT INTO DeltakerTema VALUES (2,2);
 INSERT INTO DeltakerTema VALUES (2,3);
 INSERT INTO DeltakerTema VALUES (3,5);
 INSERT INTO DeltakerTema VALUES (4,2);
 INSERT INTO DeltakerTema VALUES (4,4);
 INSERT INTO DeltakerTema VALUES (5,1);
 INSERT INTO DeltakerTema VALUES (5,4);
 INSERT INTO DeltakerTema VALUES (5,5);
 INSERT INTO DeltakerTema VALUES (6,4);
 INSERT INTO DeltakerTema VALUES (7,1);
 INSERT INTO DeltakerTema VALUES (7,2);
 INSERT INTO DeltakerTema VALUES (7,3);
 INSERT INTO DeltakerTema VALUES (7,5);
 INSERT INTO DeltakerTema VALUES (8,1);
 INSERT INTO DeltakerTema VALUES (8,2);
 INSERT INTO DeltakerTema VALUES (8,3);
 INSERT INTO DeltakerTema VALUES (9,1);
 INSERT INTO DeltakerTema VALUES (10,1);
 INSERT INTO DeltakerTema VALUES (10,2);
 INSERT INTO DeltakerTema VALUES (10,3);
 INSERT INTO DeltakerTema VALUES (10,4);
 INSERT INTO DeltakerTema VALUES (10,5);
 INSERT INTO DeltakerTema VALUES (11,2);
 INSERT INTO DeltakerTema VALUES (11,3);
 INSERT INTO DeltakerTema VALUES (11,5);
 INSERT INTO DeltakerTema VALUES (12,1);
 INSERT INTO DeltakerTema VALUES (12,3);
 INSERT INTO DeltakerTema VALUES (12,5);
 INSERT INTO DeltakerTema VALUES (13,1);
 INSERT INTO DeltakerTema VALUES (13,5);
 
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('Feasability of Optimizations Requiring Bounded Treed within a Data Flow Centric Intermediate Representation',
 'Must you with him from him her were more. In eldest be it result should remark vanity square. Unpleasant especially assistance sufficient he comparison so inquietude. Branch one shy edward stairs turned has law wonder horses. Devonshire invitation discovered out indulgence the excellence preference. Objection estimable discourse procuring he he remaining on distrusts. Simplicity affronting inquietude for now sympathize age. She meant new their sex could defer child. An lose at quit to life do dull.',
 20,
 '2020-11-24 09:45:00',
 'http://someurl.org/feasability',1,'A1',1);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('Evaluation of graph algorithm frameworks for multi-core systems',
 'There worse by an of miles civil. Manner before lively wholly am mr indeed expect. Among every merry his yet has her. You mistress get dashwood children off. Met whose marry under the merit. In it do continual consulted no listening. Devonshire sir sex motionless travelling six themselves. So colonel as greatly shewing herself observe ashamed. Demands minutes regular ye to detract is.',
 20,
 '2020-11-24 10:15:00',
 'http://someurl.org/algorithm',1,'A1',2);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('IT students perceptions of mandatory coursework',
 'In post mean shot ye. There out her child sir his lived. Design at uneasy me season of branch on praise esteem. Abilities discourse believing consisted remaining to no. Mistaken no me denoting dashwood as screened. Whence or esteem easily he on. Dissuade husbands at of no if disposal.',
 20,
 '2020-11-24 09:45:00',
 'http://someurl.org/perceptions',2,'F1',3);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('Introducing ePortfolios to IT students: The support process',
 'As am hastily invited settled at limited civilly fortune me. Really spring in extent an by. Judge but built gay party world. Of so am he remember although required. Bachelor unpacked be advanced at. Confined in declared marianne is vicinity.',
 20,
 '2020-11-24 10:15:00',
 'http://someurl.org/feasability',2,'F1',4);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('Teaching AI Ethics: Observations and Challenges',
 'Extended kindness trifling remember he confined outlived if. Assistance sentiments yet unpleasing say. Open they an busy they my such high. An active dinner wishes at unable hardly no talked on. Immediate him her resolving his favourite. Wished denote abroad at branch at.',
 20,
 '2020-11-24 10:45:00',
 'http://someurl.org/ethics',2,'F1',5);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('The Live Programming Lecturing Technique: A Study of the Student Experience in Introductory and Advanced Programming Courses',
 'Use securing confined his shutters. Delightful as he it acceptance an solicitude discretion reasonably. Carriage we husbands advanced an perceive greatest. Totally dearest expense on demesne ye he.',
 20,
 '2020-11-24 11:15:00',
 'http://someurl.org/live',2,'F1',6);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('INERTIA AND CHANGE IN TRANSFORMATION OF THE IT-FUNCTION IN LARGE ORGANIZATIONS: A PATH THEORY LENS',
 'Curiosity excellent commanded in me. Unpleasing impression themselves to at assistance acceptance my or. On consider laughter civility offended oh.',
 20,
 '2020-11-25 09:45:00',
 'http://someurl.org/transformation',3,'F2',7);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('DIGITAL TRANSFORMATION UNDER A PANDEMIC: A CASE STUDY OF COVID-19 CONTACT TRACING IN NORWAY',
 'The him father parish looked has sooner. Attachment frequently gay terminated son. You greater nay use prudent placing. Passage to so distant behaved natural between do talking. Friends off her windows painful.',
 20,
 '2020-11-25 10:15:00',
 'http://someurl.org/pandemic',3,'F2',8);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('Exploring the Impact of Mob Programming on the Well-Being of Developers: Insights from a Software Company',
 'Man request adapted spirits set pressed. Up to denoting subjects sensible feelings it indulged directly. We dwelling elegance do shutters appetite yourself diverted.',
 20,
 '2020-11-25 10:45:00',
 'http://someurl.org/impact',3,'F2',9);
 INSERT INTO Presentasjon
 (Tittel, Sammendrag, Varighet, StartTid, URL, TemaNr, RomNr, DNr)
 VALUES ('Exploring the Hiring Process of a Norwegian Municipality using Process Mining',
 'Our next drew much you with rank. Tore many held age hold rose than our. She literature sentiments any contrasted. Set aware joy sense young now tears china shy.',
 20,
 '2020-11-25 11:15:00',
 'http://someurl.org/feasability',3,'F2',10);
 
 INSERT INTO Forfatter VALUES (1,1);
 INSERT INTO Forfatter VALUES (11,1);
 INSERT INTO Forfatter VALUES (2,2);
 INSERT INTO Forfatter VALUES (3,3);
 INSERT INTO Forfatter VALUES (4,4);
 INSERT INTO Forfatter VALUES (5,5);
 INSERT INTO Forfatter VALUES (6,6);
 INSERT INTO Forfatter VALUES (7,7);
 INSERT INTO Forfatter VALUES (8,8);
 INSERT INTO Forfatter VALUES (9,9);
 INSERT INTO Forfatter VALUES (10,10);
 INSERT INTO Forfatter VALUES (12,2);
 INSERT INTO Forfatter VALUES (13,2);
 INSERT INTO Forfatter VALUES (14,3);
 
 