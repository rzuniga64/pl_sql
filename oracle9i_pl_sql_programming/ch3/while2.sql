REM while2.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM The WHILE loop in this example has a NULL condition.

DECLARE
  v_Counter BINARY_INTEGER;
BEGIN
  -- This condition will evaluate to NULL, since v_Counter
  -- is initialized to NULL by default.
  WHILE v_Counter <= 50 LOOP
    INSERT INTO temp_table
      VALUES (v_Counter, 'Loop index');
    v_Counter := v_Counter + 1;
  END LOOP;
END;
/
