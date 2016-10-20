REM PrintStudents.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates a stored procedure.

set serveroutput on

CREATE OR REPLACE PROCEDURE PrintStudents(
  p_Major IN students.major%TYPE) AS

  CURSOR c_Students IS
    SELECT first_name, last_name
      FROM students
      WHERE major = p_Major;
BEGIN
  FOR v_StudentRec IN c_Students LOOP
    DBMS_OUTPUT.PUT_LINE(v_StudentRec.first_name || ' ' ||
                         v_StudentRec.last_name);
  END LOOP;
END;
/

BEGIN
  PrintStudents('Computer Science');
END;
/
