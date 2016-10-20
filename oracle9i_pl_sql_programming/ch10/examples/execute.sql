REM execute.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates the behavior of the EXECUTE system
REM privilege.

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
-- Scenario illustrated by Figure 5-14: All objects owned by UserA.
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

-- And now RecordFullClasses:
CREATE OR REPLACE PROCEDURE RecordFullClasses AS
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

-- Now that all of the objects have been created, grant EXECUTE on
-- RecordFullClasses to UserB.  Note that UserB has no other
-- privilegs on UserA's objects.
GRANT EXECUTE ON RecordFullClasses to UserB;

-- connect as UserB, and run RecordFullClasses.  The results will
-- be stored in temp_table owned by UserA, since that is the only
-- copy of temp_table.
connect UserB/UserB
BEGIN
  UserA.RecordFullClasses;
  COMMIT;
END;
/

-- Query temp_table as UserA to verify the results.
connect UserA/UserA
SELECT * FROM temp_table;

-- ***********************************
-- Scenario illustrated by Figure 5-15: UserB also owns a copy of
--                                      temp_table.
-- ***********************************

-- Create UserB.temp_table.
connect UserB/UserB
CREATE TABLE temp_table (
  num_col    NUMBER,
  char_col   VARCHAR2(60)
  );

-- Now if we call UserA.RecordFullClasses, UserA's copy of
-- temp_table gets modified.
BEGIN
  UserA.RecordFullClasses;
  COMMIT;
END;
/

-- Query UserB's table: this should return no rows.
SELECT * FROM temp_table;

-- Query UserA's table: this should return two rows - one for
-- each of the executions.
connect UserA/UserA
SELECT * FROM temp_table;

-- ***********************************
-- Scenario illustrated by Figure 5-16: UserB owns temp_table and
--                                      RecordFullClasses, GRANTs
--                                      done directly.
-- ***********************************

-- First drop them from UserA:
connect UserA/UserA
DROP TABLE temp_table;
DROP PROCEDURE RecordFullClasses;

-- We now need to GRANT privileges on AlmostFull and Classes
-- to UserB:
GRANT SELECT ON classes TO UserB;
GRANT EXECUTE ON AlmostFull TO UserB;

-- UserB already owns temp_table, so we just need to create the
-- procedure.  Note that this refers to AlmostFull in UserA's
-- schema through dot notation.  If the above GRANTs were not done,
-- this would not compile.
connect UserB/UserB
CREATE OR REPLACE PROCEDURE RecordFullClasses AS
  CURSOR c_Classes IS
    SELECT department, course
      FROM UserA.classes;
BEGIN
  FOR v_ClassRecord IN c_Classes LOOP
    -- Record all classes which don't have very much room left
    -- in temp_table.
    IF UserA.AlmostFull(v_ClassRecord.department,
                        v_ClassRecord.course) THEN
      INSERT INTO temp_table (char_col) VALUES
        (v_ClassRecord.department || ' ' || v_ClassRecord.course ||
         ' is almost full!');
    END IF;
  END LOOP;
END RecordFullClasses;
/

-- If we execute RecordFullClasses now, the results are stored in
-- temp_table owned by UserB.
BEGIN
  RecordFullClasses;
  COMMIT;
END;
/

-- This should return one row.
SELECT * FROM temp_table;

-- ***********************************
-- Scenario illustrated by Figure 5-17: UserB owns temp_table and
--                                      RecordFullClasses, GRANTs
--                                      done via a role.
-- ***********************************

connect UserA/UserA
-- First revoke the earlier GRANTs
REVOKE SELECT ON classes FROM UserB;
REVOKE EXECUTE ON AlmostFull FROM UserB;

-- Now create the role
DROP ROLE UserA_Role;
CREATE ROLE UserA_Role;
GRANT SELECT ON classes TO UserA_Role;
GRANT EXECUTE ON AlmostFull TO UserA_Role;
GRANT UserA_Role TO UserB;

-- Attempting to create RecordFullClasses in UserB will now result
-- in PLS-201 errors:
connect UserB/UserB
CREATE OR REPLACE PROCEDURE RecordFullClasses AS
  CURSOR c_Classes IS
    SELECT department, course
      FROM UserA.classes;
BEGIN
  FOR v_ClassRecord IN c_Classes LOOP
    -- Record all classes which don't have very much room left
    -- in temp_table.
    IF UserA.AlmostFull(v_ClassRecord.department,
                        v_ClassRecord.course) THEN
      INSERT INTO temp_table (char_col) VALUES
        (v_ClassRecord.department || ' ' || v_ClassRecord.course ||
         ' is almost full!');
    END IF;
  END LOOP;
END RecordFullClasses;
/

show errors

