REM callCL.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates how to call a packaged procedure.

DELETE FROM temp_table;

DECLARE
  v_HistoryStudents ClassPackage.t_StudentIDTable;
  v_NumStudents     BINARY_INTEGER := 20;
BEGIN
  -- Fill the PL/SQL table with the first 20 History 101
  -- students.
  ClassPackage.ClassList('HIS', 101, v_HistoryStudents,
                         v_NumStudents);

  -- Insert these students into temp_table.
  FOR v_LoopCounter IN 1..v_NumStudents LOOP
    INSERT INTO temp_table (num_col, char_col)
      VALUES (v_HistoryStudents(v_LoopCounter),
              'In History 101');
  END LOOP;
END;
/

SELECT * FROM temp_table;
