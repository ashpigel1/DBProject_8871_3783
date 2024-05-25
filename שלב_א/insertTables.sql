-- Insert data into the Ammo table
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Normal',15000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Green',10000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Large',20000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Sniper_bullets',1000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Hand_Grenade',5000000,'Y');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('NA_Grenade',1000000,'Y');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('NT_Grenade',100000,'Y');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Smoke_Grenade',1000000,'Y');

-- Insert data into the Platoon_Weapon table
BEGIN
  FOR i IN 1..400 LOOP
    INSERT INTO Rifle (rID, rType, Ammo_type, Valid)
    VALUES (i+500, 
            CASE MOD(i, 9)
              WHEN 1 THEN 'Negev'
              WHEN 2 THEN 'Grenade_Launcher'
              WHEN 3 THEN 'MG'
              WHEN 4 THEN 'Sniper'
              WHEN 5 THEN 'Alpha'
              WHEN 6 THEN 'M4'
              WHEN 7 THEN 'Tavor'
              WHEN 8 THEN 'Uzi'
              ELSE 'M16'
            END,
            CASE MOD(i, 9)
              WHEN 1 THEN 'Green'
              WHEN 2 THEN 'NA_Grenade'
              WHEN 3 THEN 'Large'
              WHEN 4 THEN 'Sniper_bullets'
              WHEN 5 THEN 'Smoke_Grenade'
              ELSE 'Normal'
            END,
            'Y');
  END LOOP;
  COMMIT;
END;
/

DECLARE
  random_phone_number VARCHAR2(10);
  first_names DBMS_SQL.VARCHAR2_TABLE := DBMS_SQL.VARCHAR2_TABLE('Moshe', 'Haim', 'Itzhak', 'Menahem', 'Nissim', 'Yaakov', 'Avraham', 'David', 'Yair', 'Almog', 'Amitai', 'Motti', 'Yossi', 'Nadav', 'Gilad', 'Elad', 'Naftali', 'Daniel', 'Yehuda', 'Eliezer', 'Ohad');
  last_names DBMS_SQL.VARCHAR2_TABLE := DBMS_SQL.VARCHAR2_TABLE('Ashkenazi', 'Cohen', 'Levi', 'Israel', 'Lev', 'Gold', 'Silver', 'Carmel', 'Ohana', 'Goberman', 'Batito', 'Krupel', 'Shneor', 'Peretz', 'Mizrahi', 'Biton', 'Dahan', 'Frieedman', 'Malka', 'Katz');
  random_first_name VARCHAR2(25);
  random_last_name VARCHAR2(25);
-- Insert data into the Armory_Worker table
BEGIN
  FOR i IN 1..400 LOOP
    random_first_name := first_names(TRUNC(DBMS_RANDOM.VALUE(1, 21)));
    random_last_name := last_names(TRUNC(DBMS_RANDOM.VALUE(1, 20)));
    random_phone_number := '05' || LPAD(TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(0, 99999999))), 8, '0');
    INSERT INTO Armory_Worker (aID, Name, Phone_Number)
    VALUES (i+1000, 
            random_first_name || ' ' || random_last_name,
            random_phone_number);
  END LOOP;
  COMMIT;
END;
/




