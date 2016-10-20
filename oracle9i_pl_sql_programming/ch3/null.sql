REM null.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates NULL as a statement.

DECLARE
  v_TempVar  NUMBER := 7;
BEGIN
  IF v_TempVar < 5 THEN
    INSERT INTO temp_table (char_col)
      VALUES ('Too small');
  ELSIF v_TempVar < 20 THEN
    NULL; -- Do nothing
  ELSE
    INSERT INTO temp_table (char_col)
      VALUES ('Too big');
  END IF;
END;
/

