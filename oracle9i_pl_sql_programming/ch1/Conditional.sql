REM Conditional.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a conditional statement.

DECLARE
  v_TotalStudents NUMBER;
BEGIN
  -- Retreive the total number of students from the database.
  SELECT COUNT(*)
    INTO v_TotalStudents
    FROM students;
    
  -- Based on this value, insert the appropriate row into temp_table.
  IF v_TotalStudents = 0 THEN
    INSERT INTO temp_table (char_col)
      VALUES ('There are no students registered');
  ELSIF v_TotalStudents < 5 THEN 
    INSERT INTO temp_table (char_col)
      VALUES ('There are only a few students registered');
  ELSIF v_TotalStudents < 10 THEN
    INSERT INTO temp_table (char_col)
      VALUES ('There are a little more students registered');
  ELSE
    INSERT INTO temp_table (char_col)
      VALUES ('There are many students registered');
  END IF;
END;
/


