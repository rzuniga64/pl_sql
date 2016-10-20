REM ForUpdate.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a cursor with a FOR UPDATE clause.

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
                     AND course = 101)
      FOR UPDATE OF current_credits;

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
    WHERE CURRENT OF c_RegisteredStudents;
  END LOOP;

  -- Commit our work, and release the lock.
  COMMIT;
END;
/
