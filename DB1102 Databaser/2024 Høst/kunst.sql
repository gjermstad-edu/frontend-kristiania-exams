DROP DATABASE IF EXISTS kunst;
CREATE DATABASE kunst;
USE kunst;
-- Opprettelse av tabeller for kunstgalleriet

-- Tabell for kunstnere
CREATE TABLE Kunstnere (
    KunstnerID INT PRIMARY KEY,
    Navn VARCHAR(100),
    Fødselsdato DATE,
    Nasjonalitet VARCHAR(50)
);

-- Tabell for kunstverk
CREATE TABLE Kunstverk (
    KunstverkID INT PRIMARY KEY,
    Tittel VARCHAR(100),
    KunstnerID INT,
    År INT,
    Type VARCHAR(50),
    Pris DECIMAL(10, 2),
    FOREIGN KEY (KunstnerID) REFERENCES Kunstnere(KunstnerID)
);

-- Tabell for utstillinger
CREATE TABLE Utstillinger (
    UtstillingID INT PRIMARY KEY,
    Navn VARCHAR(100),
    Startdato DATE,
    Sluttdato DATE,
    Sted VARCHAR(100)
);

-- Tabell for salg
CREATE TABLE Salg (
    SalgID INT PRIMARY KEY,
    KunstverkID INT,
    Salgsdato DATE,
    Pris DECIMAL(10, 2),
    Kjøper VARCHAR(100),
    FOREIGN KEY (KunstverkID) REFERENCES Kunstverk(KunstverkID)
);

-- Tabell for utstillingsdeltakelse
CREATE TABLE Utstillingsdeltakelse (
    UtstillingID INT,
    KunstverkID INT,
    PRIMARY KEY (UtstillingID, KunstverkID),
    FOREIGN KEY (UtstillingID) REFERENCES Utstillinger(UtstillingID),
    FOREIGN KEY (KunstverkID) REFERENCES Kunstverk(KunstverkID)
);

-- Sett inn data i tabellen Kunstnere
INSERT INTO Kunstnere (KunstnerID, Navn, Fødselsdato, Nasjonalitet) VALUES
(1, 'Sandra Mujinga', '1989-12-01', 'Norsk'),
(2, 'Vibeke Tandberg', '1967-06-14', 'Norsk'),
(3, 'Torbjørn Rødland', '1970-01-01', 'Norsk'),
(4, 'Signe Marie Andersen', '1968-05-01', 'Norsk'),
(5, 'Eline Mugaas', '1969-01-01', 'Norsk');

-- Sett inn data i tabellen Kunstverk
INSERT INTO Kunstverk (KunstverkID, Tittel, KunstnerID, År, Type, Pris) VALUES
(1, 'Flo', 1, 2019, 'Videoinstallasjon', 500000.00),
(2, 'Living Together', 2, 1996, 'Fotografi', 300000.00),
(3, 'Fifth Honeymoon', 3, 2000, 'Fotografi', 450000.00),
(4, 'The Visit', 4, 2010, 'Fotografi', 350000.00),
(5, 'A Place to Rest', 5, 2015, 'Fotografi', 250000.00),
(6, 'Pervasive Light', 1, 2021, 'Videoinstallasjon', 600000.00),
(7, 'Sluttspill', 2, 1999, 'Fotografi', 320000.00),
(8, 'The Touch That Made You', 3, 2017, 'Fotografi', 470000.00),
(9, 'Untitled', 4, 2012, 'Fotografi', 360000.00),
(10, 'No Title', 5, 2018, 'Fotografi', 270000.00);

-- Sett inn data i tabellen Utstillinger
INSERT INTO Utstillinger (UtstillingID, Navn, Startdato, Sluttdato, Sted) VALUES
(1, 'Nye Perspektiver', '2024-01-15', '2024-03-15', 'Oslo Kunsthall'),
(2, 'Fotografiske Fortellinger', '2024-04-01', '2024-06-01', 'Bergen Kunstmuseum'),
(3, 'Videokunstens Fremtid', '2024-07-10', '2024-09-10', 'Trondheim Kunstsenter'),
(4, 'Norsk Samtidskunst', '2024-10-05', '2024-12-05', 'Stavanger Kunstgalleri'),
(5, 'Kunstneriske Blikk', '2025-01-20', '2025-03-20', 'Kristiansand Kunsthall');

-- Sett inn data i tabellen Salg
INSERT INTO Salg (SalgID, KunstverkID, Salgsdato, Pris, Kjøper) VALUES
(1, 1, '2024-02-20', 520000.00, 'Kunstsamler AS'),
(2, 2, '2024-05-15', 320000.00, 'Galleri Norge'),
(3, 3, '2024-08-25', 470000.00, 'Privat Samler'),
(4, 6, '2024-11-10', 380000.00, 'Kunstforening'),
(5, 7, '2025-02-10', 280000.00, 'Museum for Moderne Kunst');

-- Sett inn data i tabellen Utstillingsdeltakelse
INSERT INTO Utstillingsdeltakelse (UtstillingID, KunstverkID) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);
