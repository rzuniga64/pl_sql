REM forscope.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the scope of the index of a FOR LOOP.

DECLARE
  v_Counter  NUMBER := 7;
BEGIN
  -- Inserts the value 7 into temp_table.
  INSERT INTO temp_table (num_col)
    VALUES (v_Counter);
  -- This loop redeclares v_Counter as a BINARY_INTEGER, which hides
  -- the NUMBER declaration of v_Counter.
  FOR v_Counter IN 20..30 LOOP
    -- Inside the loop, v_Counter ranges from 20 to 30.
    INSERT INTO temp_table (num_col)
      VALUES (v_Counter);
  END LOOP;
  -- Inserts another 7 into temp_table.
  INSERT INTO temp_table (num_col)
    VALUES (v_Counter);
END;
/
