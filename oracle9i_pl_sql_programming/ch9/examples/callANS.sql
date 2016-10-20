REM callANS.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a call to AddNewStudent.

DECLARE
  -- Variables describing the new student
  v_NewFirstName  students.first_name%TYPE := 'Cynthia';
  v_NewLastName   students.last_name%TYPE := 'Camino';
  v_NewMajor      students.major%TYPE := 'History';
BEGIN
  -- Add Cynthia Camino to the database.
  AddNewStudent(v_NewFirstName, v_NewLastName, v_NewMajor);
END;
/
