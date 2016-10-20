REM SimpleLoop.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This block contains a simple loop.

DECLARE
  v_LoopCounter BINARY_INTEGER := 1;
BEGIN
  LOOP
    INSERT INTO temp_table (num_col)
      VALUES (v_LoopCounter);
    v_LoopCounter := v_LoopCounter + 1;
    EXIT WHEN v_LoopCounter > 50;
  END LOOP;
END;
/
