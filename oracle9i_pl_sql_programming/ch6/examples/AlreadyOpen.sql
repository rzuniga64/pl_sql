REM AlreadyOpen.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the ORA-6511 error.

DECLARE
  v_StudentID students.ID%TYPE;
  
  CURSOR c_AllStudentIDs IS
    SELECT ID FROM students;
BEGIN
  OPEN c_AllStudentIDs;
  
  -- Open it again.  This will raise ORA-6511.
  OPEN c_AllStudentIDs;
END;
/
