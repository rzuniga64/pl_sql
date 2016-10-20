REM RecordFullClasses.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This procedure depends on AlmostFull and temp_table.

CREATE OR REPLACE PROCEDURE RecordFullClasses AS
  CURSOR c_Classes IS
    SELECT department, course
      FROM classes;
BEGIN
  FOR v_ClassRecord IN c_Classes LOOP
    -- Record all classes which don't have very much room left
    -- in temp_table.
    IF AlmostFull(v_ClassRecord.department, v_ClassRecord.course)
    THEN
      INSERT INTO temp_table (char_col) VALUES
        (v_ClassRecord.department || ' ' || v_ClassRecord.course ||
         ' is almost full!');
    END IF;
  END LOOP;
END RecordFullClasses;
/


