REM ForLoop.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates a cursor FOR loop.

DECLARE
  -- Cursor to retrieve the information about History students
  CURSOR c_HistoryStudents IS
    SELECT id, first_name, last_name
      FROM students
      WHERE major = 'History';
BEGIN
  -- Begin the loop. An implicit OPEN of c_HistoryStudents
  -- is done here.
  FOR v_StudentData IN c_HistoryStudents LOOP
    -- An implicit FETCH is done here.
    -- c_HistoryStudents%NOTFOUND is also implicitly checked, to
    -- see if we are done fetching.

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
  -- Now that the loop is finished, an implicit CLOSE of 
  -- c_HistoryStudents is done.
END;
/
