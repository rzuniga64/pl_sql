REM NumericLoop.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a numeric FOR loop.

BEGIN
  FOR v_LoopCounter IN 1..50 LOOP
    INSERT INTO temp_table (num_col)
      VALUES (v_LoopCounter);
  END LOOP;
END;
/
