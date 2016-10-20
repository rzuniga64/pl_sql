REM AddNewStudent.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates a stored procedure and how to call it.

CREATE OR REPLACE PROCEDURE AddNewStudent (
  p_FirstName  students.first_name%TYPE,
  p_LastName   students.last_name%TYPE,
  p_Major      students.major%TYPE) AS
BEGIN
  -- Insert a new row in the students table. Use
  -- student_sequence to generate the new student ID, and
  -- 0 for current_credits.
  INSERT INTO students (ID, first_name, last_name,
                        major, current_credits)
    VALUES (student_sequence.nextval, p_FirstName, p_LastName,
            p_Major, 0);
END AddNewStudent;
/

BEGIN
  AddNewStudent('Zelda', 'Zudnik', 'Computer Science');
END;
/

ROLLBACK;
