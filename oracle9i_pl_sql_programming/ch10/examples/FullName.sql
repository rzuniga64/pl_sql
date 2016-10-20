REM FullName.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This function can be called from a SQL statement.

CREATE OR REPLACE FUNCTION FullName (
  p_StudentID  students.ID%TYPE)
  RETURN VARCHAR2 IS

  v_Result  VARCHAR2(100);
BEGIN
  SELECT first_name || ' ' || last_name
    INTO v_Result
    FROM students
    WHERE ID = p_StudentID;

  RETURN v_Result;
END FullName;
/

SELECT ID, FullName(ID) "Full Name"
  FROM students;

INSERT INTO temp_table (char_col)
  VALUES (FullName(10010));

