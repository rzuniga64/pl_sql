REM goto.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the GOTO statement.

DECLARE
  v_Counter  BINARY_INTEGER := 1;
BEGIN
  LOOP
    INSERT INTO temp_table
      VALUES (v_Counter, 'Loop count');
    v_Counter := v_Counter + 1;
    IF v_Counter >= 50 THEN
      GOTO l_EndOfLoop;
    END IF;
  END LOOP;

  <<l_EndOfLoop>>
  INSERT INTO temp_table (char_col)
    VALUES ('Done!');
END;
/
