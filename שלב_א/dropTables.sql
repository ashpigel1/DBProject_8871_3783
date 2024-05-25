-- dropTables.sql for Oracle Database

-- Drop tables with CASCADE CONSTRAINTS to automatically drop any dependent foreign key constraints
DROP TABLE Order_ammo CASCADE CONSTRAINTS;
DROP TABLE Soldier_Special_qualification CASCADE CONSTRAINTS;
DROP TABLE Rifle_Inspection CASCADE CONSTRAINTS; -- Updated from Testing
DROP TABLE Attachment CASCADE CONSTRAINTS;
DROP TABLE Soldier CASCADE CONSTRAINTS;
DROP TABLE Rifle CASCADE CONSTRAINTS;
DROP TABLE Ammo CASCADE CONSTRAINTS;
DROP TABLE Armory_worker CASCADE CONSTRAINTS;
DROP TABLE Platoon_Weapon CASCADE CONSTRAINTS; -- Updated from Rifle_Type

-- Drop sequences (if they exist and are used in your database)
DROP SEQUENCE Order_Ammo_Seq;
-- Other sequences would be dropped here if they exist
