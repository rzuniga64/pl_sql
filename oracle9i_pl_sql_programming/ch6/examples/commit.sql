REM commit.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block will raise "ORA-1002: fetch out of sequence" because
REM of the commit inside the SELECT..FOR UPDATE loop.

DECLARE
  -- Cursor to retrieve all students, and lock the rows as well.
  CURSOR c_AllStudents IS
    SELECT *
      FROM students
      FOR UPDATE;

  -- Variable for retrieved data.
  v_StudentInfo  c_AllStudents%ROWTYPE;
BEGIN
  -- Open the cursor. This will acquire the locks.
  OPEN c_AllStudents;

  -- Retrieve the first record.
  FETCH c_AllStudents INTO v_StudentInfo;

  -- Issue a COMMIT. This will release the locks, invalidating the
  -- cursor.
  COMMIT;

  -- This FETCH will raise the ORA-1002 error.
  FETCH c_AllStudents INTO v_StudentInfo;
END;
/


DECLARE
  -- Number of credits to add to each student's total
  v_NumCredits  classes.num_credits%TYPE;

  -- This cursor will select only those students who are currently
  -- registered for HIS 101.
  CURSOR c_RegisteredStudents IS
    SELECT *
      FROM students
      WHERE id IN (SELECT student_id
                     FROM registered_students
                     WHERE department= 'HIS'
                     AND course = 101);

BEGIN
  -- Set up the cursor fetch loop.
  FOR v_StudentInfo IN c_RegisteredStudents LOOP
  -- Determine the number of credits for HIS 101.
  SELECT num_credits
    INTO v_NumCredits
    FROM classes
    WHERE department = 'HIS'
    AND course = 101;

  -- Update the row we just retrieved from the cursor.
  UPDATE students
    SET current_credits = current_credits + v_NumCredits
    WHERE id = v_Studentinfo.id;

  -- We can commit inside the loop, since the cursor is
  -- not declared FOR UPDATE.
  COMMIT;
  END LOOP;
END;
/
