REM invokers.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates the behavior of Oracle8i invoker's-
REM rights procedures.

set echo on
set serveroutput on

-- First create the users userA and userB, with the necessary
-- objects in each.  We need to connect to an account with the
-- necessary privileges, such as SYSTEM, to do this.
-- You may also want to change the UNLIMITED TABLESPACE
-- privilege below to grant explicit limits on tablespaces in your
-- database.
connect system/manager
DROP USER UserA CASCADE;
CREATE USER UserA IDENTIFIED BY UserA;
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE,
      UNLIMITED TABLESPACE, CREATE ROLE, DROP ANY ROLE TO UserA;

DROP USER UserB CASCADE;
CREATE USER UserB IDENTIFIED BY UserB;
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE,
      UNLIMITED TABLESPACE TO UserB;

-- ***********************************
-- Scenerio illustrated by Figure 5-18: Invoker's rights
--                                      RecordFullClasses owned by
--                                      UserA, temp_table owned by
--                                      both.
-- ***********************************
connect UserA/UserA

-- First create the classes table.
CREATE TABLE classes (
  department       CHAR(3),
  course           NUMBER(3),
  description      VARCHAR2(2000),
  max_students     NUMBER(3),
  current_students NUMBER(3),
  num_credits      NUMBER(1),
  room_id          NUMBER(5));

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('HIS', 101, 'History 101', 30, 11, 4, 20000);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('HIS', 301, 'History 301', 30, 0, 4, 20004);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('CS', 101, 'Computer Science 101', 50, 0, 4, 20001);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('ECN', 203, 'Economics 203', 15, 0, 3, 20002);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('CS', 102, 'Computer Science 102', 35, 3, 4, 20003);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('MUS', 410, 'Music 410', 5, 4, 3, 20005);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('ECN', 101, 'Economics 101', 50, 0, 4, 20007);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('NUT', 307, 'Nutrition 307', 20, 2, 4, 20008);

INSERT INTO classes(department, course, description, max_students,
                     current_students, num_credits, room_id)
  VALUES ('MUS', 100, 'Music 100', 100, 0, 3, NULL);

COMMIT;

-- And now temp_table.
CREATE TABLE temp_table (
  num_col    NUMBER,
  char_col   VARCHAR2(60)
  );

-- We also need AlmostFull:
CREATE OR REPLACE FUNCTION AlmostFull (
  p_Department classes.department%TYPE,
  p_Course     classes.course%TYPE)
  RETURN BOOLEAN IS

  v_CurrentStudents NUMBER;
  v_MaxStudents     NUMBER;
  v_ReturnValue     BOOLEAN;
  v_FullPercent     CONSTANT NUMBER := 80;
BEGIN
  -- Get the current and maximum students for the requested
  -- course.
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM classes
    WHERE department = p_Department
    AND course = p_Course;

  -- If the class is more full than the percentage given by
  -- v_FullPercent, return TRUE. Otherwise, return FALSE.
  IF (v_CurrentStudents / v_MaxStudents * 100) >= v_FullPercent THEN
    v_ReturnValue := TRUE;
  ELSE
    v_ReturnValue := FALSE;
  END IF;

  RETURN v_ReturnValue;
END AlmostFull;
/

-- Invoker's rights version of RecordFullClasses.  This version
-- runs under the privilege set of its caller, not the owner.
CREATE OR REPLACE PROCEDURE RecordFullClasses
  AUTHID CURRENT_USER AS

  -- Note that we have to preface classes with
  -- UserA, since it is owned by UserA only.
  CURSOR c_Classes IS
    SELECT department, course
      FROM UserA.classes;
BEGIN
  FOR v_ClassRecord IN c_Classes LOOP
    -- Record all classes which don't have very much room left
    -- in temp_table.
    IF AlmostFull(v_ClassRecord.department,
                        v_ClassRecord.course) THEN
      INSERT INTO temp_table (char_col) VALUES
        (v_ClassRecord.department || ' ' || v_ClassRecord.course ||
         ' is almost full!');
    END IF;
  END LOOP;
END RecordFullClasses;
/

-- Grant the necessary privileges to UserB.
GRANT EXECUTE ON RecordFullClasses TO UserB;
GRANT SELECT ON classes TO UserB;

-- Call as UserA.  This will insert into UserA.temp_table.
BEGIN
  RecordFullClasses;
  COMMIT;
END;
/

-- Query temp_table.  There should be 1 row.
SELECT * FROM temp_table;

-- Connect as UserB and create temp_table there.
connect UserB/UserB
CREATE TABLE temp_table (
  num_col    NUMBER,
  char_col   VARCHAR2(60)
  );

-- Now the call to RecordFullClasses will insert into
-- UserB.temp_table.
BEGIN
  UserA.RecordFullClasses;
  COMMIT;
END;
/

-- So we should have one row here as well.
SELECT * FROM temp_table;

-- ***********************************
-- Scenerio illustrated by Figure 5-19: UserB without SELECT on
--                                      classes
-- ***********************************

-- Connect as UserA, and revoke the privilege.
connect UserA/UserA
REVOKE SELECT ON classes FROM UserB;

-- Calling as UserA will still work:
-- Call as UserA.  This will insert into UserA.temp_table.
BEGIN
  RecordFullClasses;
  COMMIT;
END;
/

-- Query temp_table.  There should be 1 row.
SELECT * FROM temp_table;

-- Connect as UserB and call.
connect UserB/UserB

-- Now the call to RecordFullClasses will fail.
BEGIN
  UserA.RecordFullClasses;
END;
/

-- ***********************************
-- Scenerio illustrated by Figure 5-20: SELECT on classes GRANTed
--                                      via a role
-- ***********************************

-- Connect as UserA, and create the role.
connect UserA/UserA
DROP ROLE UserA_Role;
CREATE ROLE UserA_Role;
GRANT SELECT ON classes TO UserA_Role;
GRANT UserA_Role TO UserB;

-- Connect as UserB and call.
connect UserB/UserB

-- Now the call to RecordFullClasses will succeed.
BEGIN
  UserA.RecordFullClasses;
  COMMIT;
END;
/

-- We should have two rows now.
SELECT * FROM temp_table;
