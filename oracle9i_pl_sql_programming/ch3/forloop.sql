REM forloop.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This is an example of a FOR loop.

BEGIN
  FOR v_Counter IN 1..50 LOOP
    INSERT INTO temp_table
      VALUES (v_Counter, 'Loop Index');
  END LOOP;
END;
/
