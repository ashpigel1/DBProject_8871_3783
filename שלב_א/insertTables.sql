-- Insert data into the Ammo table
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Normal',15000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Green',10000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Large',20000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Sniper_bullets',1000000,'N');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Hand_Grenade',5000000,'Y');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('NA_Grenade',1000000,'Y');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('NT_Grenade',100000,'Y');
INSERT INTO Ammo (Ammo_type, Amount, Explosive) VALUES ('Smoke_Grenade',1000000,'Y');

-- Insert data into the Rifle table
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
  rank VARCHAR2(50);
  enlistment_date DATE;
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

-- Insert data into the Soldier table
BEGIN
  FOR i IN 1..400 LOOP
    random_first_name := first_names(TRUNC(DBMS_RANDOM.VALUE(1, 21)));
    random_last_name := last_names(TRUNC(DBMS_RANDOM.VALUE(1, 20)));
    
    -- Determine rank and corresponding enlistment date
    SELECT 
      CASE 
        WHEN i <= 250 THEN 'Private'
        WHEN i <= 320 THEN 'Master Private'
        WHEN i <= 350 THEN 'Sergeant'
        WHEN i <= 370 THEN 'First Sergeant'
        WHEN i <= 390 THEN 'Second Lieutenant'
        WHEN i <= 395 THEN 'Lieutenant'
        ELSE 'Captain'
      END,
      CASE 
        WHEN i <= 250 THEN TO_DATE('20/03/2024', 'DD/MM/YYYY')
        WHEN i <= 320 THEN TO_DATE('28/10/2023', 'DD/MM/YYYY')
        WHEN i <= 350 THEN TO_DATE('15/03/2023', 'DD/MM/YYYY')
        WHEN i <= 370 THEN TO_DATE('18/03/2022', 'DD/MM/YYYY')
        WHEN i <= 390 THEN TO_DATE('04/08/2021', 'DD/MM/YYYY')
        WHEN i <= 395 THEN TO_DATE('12/11/2020', 'DD/MM/YYYY')
        ELSE TO_DATE('10/10/2018', 'DD/MM/YYYY')
      END
    INTO rank, enlistment_date
    FROM dual;

    -- Insert the data into the Soldier table
    INSERT INTO Soldier (sID, Rank, Name, Enlisted_date)
    VALUES (i + 2000, rank, random_first_name || ' ' || random_last_name, enlistment_date);
  END LOOP;
  COMMIT;
END;
/

    -- Insert the data into the Attachment table
DECLARE
  attachment_types DBMS_SQL.VARCHAR2_TABLE := DBMS_SQL.VARCHAR2_TABLE('Scope', 'Assault handle', 'flashlight', 'Infra-red laser');
  rifle_id_base CONSTANT INT := 500;
  num_rifles CONSTANT INT := 400;
  num_attachment_types CONSTANT INT := 4;
  attach_id INT := 1; -- Starting attachID
  rifle_id INT;
BEGIN
  FOR i IN 1..num_rifles LOOP
    FOR j IN 1..num_attachment_types LOOP
      -- Randomly decide whether to assign this attachment to a rifle (75% chance)
      IF DBMS_RANDOM.VALUE < 0.75 THEN
        rifle_id := rifle_id_base + i - 1;
      ELSE
        rifle_id := NULL; -- This attachment will not be assigned to any rifle
      END IF;
      
      -- Insert the attachment data
      INSERT INTO Attachment (attachID, rID, attachType)
      VALUES (attach_id, rifle_id, attachment_types(j));
      
      -- Increment attachID for the next entry
      attach_id := attach_id + 1;
    END LOOP;
  END LOOP;
  COMMIT;
END;
/




