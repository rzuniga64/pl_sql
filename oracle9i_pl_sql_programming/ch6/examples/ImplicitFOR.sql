REM ImplicitFOR.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates an implicit FOR loop.

BEGIN
  -- Begin the loop. An implicit OPEN is done here.
  FOR v_StudentData IN (SELECT id, first_name, last_name
                          FROM students
                          WHERE major = 'History') LOOP
    -- An implicit FETCH is done here, and %NOTFOUND is checked

    -- Process the fetched rows, in this case sign up each
    -- student for History 301 by inserting them into the 
    -- registered_students table. Record the first and last
    -- names in temp_table as well.
    INSERT INTO registered_students (student_id, department, course)
      VALUES (v_StudentData.ID, 'HIS', 301);

    INSERT INTO temp_table (num_col, char_col)
      VALUES (v_StudentData.ID,
              v_StudentData.first_name || ' ' || v_StudentData.last_name);
  END LOOP;
  -- Now that the loop is finished, an implicit CLOSE is done.
END;
/
