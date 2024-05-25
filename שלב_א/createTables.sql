CREATE TABLE Rifle
(
  rID INT NOT NULL,
  Ammo_type VARCHAR2 NOT NULL,
  Valid VARCHAR2 NOT NULL,
  PRIMARY KEY (rID),
  FOREIGN KEY (Ammo_type) REFERENCES Ammo(Ammo_type)
);

CREATE TABLE Soldier
(
  sID INT NOT NULL,
  rank VARCHAR2 NOT NULL,
  position VARCHAR2 NOT NULL,
  name VARCHAR2 NOT NULL,
  Enlisted_date DATE NOT NULL,
  rID INT NOT NULL,
  PRIMARY KEY (sID),
  FOREIGN KEY (rID) REFERENCES Rifle(rID)
);

CREATE TABLE Armory_worker
(
  aID INT NOT NULL,
  name VARCHAR2 NOT NULL,
  phone_number VARCHAR(15) NOT NULL,
  PRIMARY KEY (aID)
);

CREATE TABLE Platoon_Weapon
(
  wID INT NOT NULL,
  Type_name VARCHAR2 NOT NULL,
  Amount INT NOT NULL,
  PRIMARY KEY (wID)
);

CREATE TABLE Attachment
(
  attachID INT NOT NULL,
  rID INT,
  type VARCHAR2 NOT NULL,
  PRIMARY KEY (attachID),
  FOREIGN KEY (rID) REFERENCES Rifle(rID)
);

CREATE TABLE Ammo
(
  Ammo_type VARCHAR2 NOT NULL,
  Amount INT NOT NULL,
  Explosive CHAR(1) NOT NULL, -- 'Y' for yes/true, 'N' for no/false
  PRIMARY KEY (Ammo_type)
);

CREATE TABLE Rifle_Inspection
(
  aID INT NOT NULL,
  rID INT NOT NULL,
  Inspection_Date DATE NOT NULL,
  PRIMARY KEY (aID, rID, Inspection_Date),
  FOREIGN KEY (aID) REFERENCES Armory_worker(aID),
  FOREIGN KEY (rID) REFERENCES Rifle(rID)
);

CREATE TABLE Soldier_Special_qualification
(
  sID INT NOT NULL,
  wID INT NOT NULL,
  PRIMARY KEY (sID, wID),
  FOREIGN KEY (sID) REFERENCES Soldier(sID),
  FOREIGN KEY (wID) REFERENCES Platoon_Weapon(wID)
);

-- Oracle does not support AUTO_INCREMENT. You need to create a sequence and trigger for Order_ID.
CREATE SEQUENCE Order_Ammo_Seq START WITH 1 INCREMENT BY 1;

CREATE TABLE Order_ammo
(
  Order_ID INT NOT NULL,
  Order_date DATE NOT NULL,
  Amount INT NOT NULL,
  Ammo_type VARCHAR2 NOT NULL,
  aID INT NOT NULL,
  PRIMARY KEY (Order_ID),
  FOREIGN KEY (Ammo_type) REFERENCES Ammo(Ammo_type),
  FOREIGN KEY (aID) REFERENCES Armory_worker(aID)
);

-- Create a trigger to auto-increment Order_ID using the sequence
CREATE OR REPLACE TRIGGER Order_ammo_BI
BEFORE INSERT ON Order_ammo
FOR EACH ROW
BEGIN
  SELECT Order_Ammo_Seq.NEXTVAL INTO :new.Order_ID FROM dual;
END;
/
