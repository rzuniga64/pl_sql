REM insert.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows some INSERT statements.

DECLARE
  v_StudentID  students.id%TYPE;
BEGIN
  -- Retrieve a new student ID number
  SELECT student_sequence.NEXTVAL
    INTO v_StudentID
    FROM dual;

  -- Add a row to the students table
  INSERT INTO students (id, first_name, last_name)
    VALUES (v_StudentID, 'Timothy', 'Taller');

  -- Add a second row, but use the sequence number directly
  -- in the INSERT statement.
  INSERT INTO students (id, first_name, last_name)
    VALUES (student_sequence.NEXTVAL, 'Patrick', 'Poll');
END;
/


