REM default.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This version of AddNewStudent takes a default parameter.

CREATE OR REPLACE PROCEDURE AddNewStudent (
  p_FirstName  students.first_name%TYPE,
  p_LastName   students.last_name%TYPE,
  p_Major      students.major%TYPE DEFAULT 'Economics') AS
BEGIN
  -- Insert a new row in the students table. Use
  -- student_sequence to generate the new student ID, and
  -- 0 for current_credits.
  INSERT INTO students VALUES (student_sequence.nextval,
    p_FirstName, p_LastName, p_Major, 0);
END AddNewStudent;
/

BEGIN
  AddNewStudent('Simon', 'Salovitz');
END;
/

BEGIN
  AddNewStudent(p_FirstName => 'Veronica',
                p_LastName => 'Vassily');
END;
/

ROLLBACK;
