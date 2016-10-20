REM update.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates some UPDATE statements.

DECLARE
  v_Major           students.major%TYPE;
  v_CreditIncrease  NUMBER := 3;
BEGIN
  -- This UPDATE statement will add 3 to the current_credits
  -- field of all students who are majoring in History.
  v_Major := 'History';
  UPDATE students
    SET current_credits = current_credits + v_CreditIncrease
    WHERE major = v_Major;
    
  -- This UPDATE statement will update both columns of
  -- temp_table, for all rows.
  UPDATE temp_table
    SET num_col = 1, char_col = 'abcd';
END;
/

