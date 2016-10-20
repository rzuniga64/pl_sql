REM callRS.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates a call to PersistPkg.ReadStudents.

set serveroutput on

DECLARE
  v_StudentTable PersistPkg.t_StudentTable;
  v_NumRows NUMBER := PersistPkg.v_MaxRows;
  v_FirstName students.first_name%TYPE;
  v_LastName students.last_name%TYPE;
BEGIN
  PersistPkg.ReadStudents(v_StudentTable, v_NumRows);
  DBMS_OUTPUT.PUT_LINE(' Fetched ' || v_NumRows || ' rows:');
  FOR v_Count IN 1..v_NumRows LOOP
    SELECT first_name, last_name
      INTO v_FirstName, v_LastName
      FROM students
      WHERE ID = v_StudentTable(v_Count);
    DBMS_OUTPUT.PUT_LINE(v_FirstName || ' ' || v_LastName);
  END LOOP;
END;
/
