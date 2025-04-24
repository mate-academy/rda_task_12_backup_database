CREATE DATABASE ShopDB; 
USE ShopDB; 

CREATE TABLE Products (
    ID INT AUTO_INCREMENT,
    Name VARCHAR(50),
    PRIMARY KEY (ID)
);

-- Create test data in Products table 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct1'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct2'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct3'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct4'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct5'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct6'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct7'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct8'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct9'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct10'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct11'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct12'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct13'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct14'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct15'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct16'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct17'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct18'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct19'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct20'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct21'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct22'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct23'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct24'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct25'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct26'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct27'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct28'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct29'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct30'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct31'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct32'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct33'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct34'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct35'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct36'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct37'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct38'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct39'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct40'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct41'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct42'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct43'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct44'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct45'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct46'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct47'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct48'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct49'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct50'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct51'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct52'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct53'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct54'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct55'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct56'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct57'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct58'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct59'); 
INSERT INTO Products (Name)
	VALUES ('AwesomeProduct60'); 


-- create databases where data should be restored 

CREATE DATABASE ShopDBReserve; 

CREATE DATABASE ShopDBDevelopment; 
USE ShopDBDevelopment; 

CREATE TABLE Products (
    ID INT AUTO_INCREMENT,
    Name VARCHAR(50),
    PRIMARY KEY (ID)
);
