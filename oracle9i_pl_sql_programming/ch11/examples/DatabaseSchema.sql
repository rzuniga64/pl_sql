REM DatabaseSchema.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates two system triggers.

-- First create UserA and UserB.  You may need to change the
-- system password and/or add tablespace information here.
connect system/manager

CREATE USER UserA IDENTIFIED BY UserA;
GRANT connect, resource, ADMINISTER DATABASE TRIGGER TO UserA;

CREATE USER UserB IDENTIFIED BY UserB;
GRANT connect, resource, ADMINISTER DATABASE TRIGGER TO UserB;

connect example/example
GRANT INSERT ON temp_table TO UserA;
GRANT INSERT ON temp_Table TO UserB;

connect UserA/UserA
CREATE OR REPLACE TRIGGER LogUserAConnects
  AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO example.temp_table
    VALUES (1, 'LogUserAConnects fired!');
END LogUserAConnects;
/

connect UserB/UserB
CREATE OR REPLACE TRIGGER LogUserBConnects
  AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO example.temp_table
    VALUES (2, 'LogUserBConnects fired!');
END LogUserBConnects;
/

connect example/example
CREATE OR REPLACE TRIGGER LogAllConnects
  AFTER LOGON ON DATABASE
BEGIN
  INSERT INTO example.temp_table
    VALUES (3, 'LogAllConnects fired!');
END LogAllConnects;
/

REM Connect as all three users, and then query temp_table.
connect UserA/UserA
connect UserB/UserB
connect example/example

SELECT * FROM temp_table;

REM Disable the triggers afterwards, and clear the table.
connect UserA/UserA
ALTER TRIGGER LogUserAConnects DISABLE;
connect UserB/UserB
ALTER TRIGGER LogUserBConnects DISABLE;
connect example/example
ALTER TRIGGER LogAllConnects DISABLE;
DELETE temp_table;
COMMIT;
