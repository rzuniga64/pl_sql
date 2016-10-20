REM simple.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This is an example of a simple loop.

DECLARE
  v_Counter BINARY_INTEGER := 1;
BEGIN
  LOOP
    -- Insert a row into temp_table with the current value of the
    -- loop counter.
    INSERT INTO temp_table
      VALUES (v_Counter, 'Loop index');
    v_Counter := v_Counter + 1;
    -- Exit condition - when the loop counter > 50 we will 
    -- break out of the loop.
    IF v_Counter > 50 THEN
      EXIT;
    END IF;
  END LOOP;
END;
/
