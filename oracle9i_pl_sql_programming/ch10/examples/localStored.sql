REM localStored.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This procedure contains a local subprogram.

set serveroutput on

CREATE OR REPLACE PROCEDURE StoredProc AS
  /* Local declarations, which include a cursor, variable, and a
     function. */
  CURSOR c_AllStudents IS
    SELECT first_name, last_name
      FROM students;

  v_FormattedName VARCHAR2(50);

  /* Function which will return the first and last name
     concatenated together, separated by a space. */
  FUNCTION FormatName(p_FirstName IN VARCHAR2,
                      p_LastName IN VARCHAR2)
    RETURN VARCHAR2 IS
  BEGIN
    RETURN p_FirstName || ' ' || p_LastName;
  END FormatName;

-- Begin main block.
BEGIN
  FOR v_StudentRecord IN c_AllStudents LOOP
    v_FormattedName :=
      FormatName(v_StudentRecord.first_name,
                 v_StudentRecord.last_name);
    DBMS_OUTPUT.PUT_LINE(v_FormattedName);
  END LOOP;
END StoredProc;
/

BEGIN
  StoredProc;
END;
/
