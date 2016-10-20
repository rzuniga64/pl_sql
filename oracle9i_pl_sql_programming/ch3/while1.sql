REM while1.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This illustrates a WHILE loop.

DECLARE
  v_Counter BINARY_INTEGER := 1;
BEGIN
  -- Test the loop counter before each loop iteration to
  -- insure that it is still less than 50.
  WHILE v_Counter <= 50 LOOP
    INSERT INTO temp_table
      VALUES (v_Counter, 'Loop index');
    v_Counter := v_Counter + 1;
  END LOOP;
END;
/
