REM WhileLoop.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a WHILE cursor fetch loop.

DECLARE
  -- Cursor to retrieve the information about History students
  CURSOR c_HistoryStudents IS
    SELECT id, first_name, last_name
      FROM students
      WHERE major = 'History';

  -- Declare a record to hold the fetched information.
  v_StudentData  c_HistoryStudents%ROWTYPE;
BEGIN
  -- Open the cursor and initialize the active set
  OPEN c_HistoryStudents;

  -- Retrieve the first row, to set up for the WHILE loop
  FETCH c_HistoryStudents INTO v_StudentData;

  -- Continue looping while there are more rows to fetch
  WHILE c_HistoryStudents%FOUND LOOP
    -- Process the fetched rows, in this case sign up each
    -- student for History 301 by inserting them into the 
    -- registered_students table. Record the first and last
    -- names in temp_table as well.
    INSERT INTO registered_students (student_id, department, course)
      VALUES (v_StudentData.ID, 'HIS', 301);

    INSERT INTO temp_table (num_col, char_col)
      VALUES (v_StudentData.ID,
              v_StudentData.first_name || ' ' || v_StudentData.last_name);

    -- Retrieve the next row. The %FOUND condition will be checked
    -- before the loop continues again.
    FETCH c_HistoryStudents INTO v_StudentData;
  END LOOP;

  -- Free resources used by the cursor
  CLOSE c_HistoryStudents;
END;
/
