-- Create the Ammo table first because other tables reference it
CREATE TABLE Ammo
(
  Ammo_type VARCHAR2(20) NOT NULL,
  Amount INT NOT NULL,
  Explosive CHAR(1) NOT NULL, -- 'Y' for yes/true, 'N' for no/false
  PRIMARY KEY (Ammo_type)
);

-- Create the Armory_worker table next as it is referenced by other tables
CREATE TABLE Armory_worker
(
  aID INT NOT NULL,
  Name VARCHAR2(50) NOT NULL,
  Phone_Number VARCHAR(15) NOT NULL, -- Adjusted the size to 15 to match earlier definition
  PRIMARY KEY (aID)
);
CREATE TABLE Rifle_Assigned
(
  rID INT NOT NULL,
  sID INT NOT NULL
  Date_Assigned DATE NOT NULL
  PRIMARY KEY (rID,sID)
)

-- Create the Rifle table, which references the Ammo table
CREATE TABLE Rifle
(
  rID INT NOT NULL,
  rType VARCHAR2(20) NOT NULL,
  Ammo_type VARCHAR2(20) NOT NULL,
  Valid VARCHAR2(1) NOT NULL, -- 'Y' for yes/true, 'N' for no/false
  PRIMARY KEY (rID),
  FOREIGN KEY (Ammo_type) REFERENCES Ammo(Ammo_type)
);

-- Create the Soldier table, which references the Rifle table
CREATE TABLE Soldier
(
  sID INT NOT NULL,
  Rank VARCHAR2(20) NOT NULL,
  Name VARCHAR2(50) NOT NULL,
  Enlisted_date DATE NOT NULL,
  PRIMARY KEY (sID)
);

-- Create the Attachment table, which references the Rifle table
CREATE TABLE Attachment
(
  attachID INT NOT NULL,
  rID INT,
  Type VARCHAR2(20) NOT NULL,
  PRIMARY KEY (attachID),
  FOREIGN KEY (rID) REFERENCES Rifle(rID)
);

-- Create the sequence for Order_ammo table before creating the table
CREATE SEQUENCE Order_Ammo_Seq START WITH 1 INCREMENT BY 1;

-- Create the Order_ammo table, which references the Ammo and Armory_worker tables
CREATE TABLE Order_ammo
(
  Order_ID INT NOT NULL,
  Order_date DATE NOT NULL,
  Amount INT NOT NULL,
  Ammo_type VARCHAR2(20) NOT NULL,
  aID INT NOT NULL,
  PRIMARY KEY (Order_ID),
  FOREIGN KEY (Ammo_type) REFERENCES Ammo(Ammo_type),
  FOREIGN KEY (aID) REFERENCES Armory_worker(aID)
);

-- Create the trigger for the Order_ammo table to auto-increment Order_ID
CREATE OR REPLACE TRIGGER Order_ammo_BI
BEFORE INSERT ON Order_ammo
FOR EACH ROW
BEGIN
  SELECT Order_Ammo_Seq.NEXTVAL INTO :new.Order_ID FROM dual;
END;
/

-- Create the Rifle_Inspection table, which references the Rifle and Armory_worker tables
CREATE TABLE Rifle_Inspection
(
  aID INT NOT NULL,
  rID INT NOT NULL,
  Inspection_Date DATE NOT NULL,
  PRIMARY KEY (aID, rID, Inspection_Date),
  FOREIGN KEY (aID) REFERENCES Armory_worker(aID),
  FOREIGN KEY (rID) REFERENCES Rifle(rID)
);

