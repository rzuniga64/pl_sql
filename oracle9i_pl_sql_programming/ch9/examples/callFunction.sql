REM callFunction.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script shows how to call a stored function.

set serveroutput on

DECLARE
  CURSOR c_Classes IS
    SELECT department, course
      FROM classes;
BEGIN
  FOR v_ClassRecord IN c_Classes LOOP
    -- Output all the classes which don't have very much room
    IF AlmostFull(v_ClassRecord.department,
                  v_ClassRecord.course) THEN
      DBMS_OUTPUT.PUT_LINE(
        v_ClassRecord.department || ' ' ||
        v_ClassRecord.course || ' is almost full!');
    END IF;
  END LOOP;
END;
/
