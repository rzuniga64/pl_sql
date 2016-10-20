REM File.sql
REM Chapter 2, Oracle9i PL/SQL Programming by Scott Urman
REM This file contains commands which can be executed from SQL*Plus.

BEGIN
  FOR v_Count IN 1..10 LOOP
    INSERT INTO temp_table (num_col, char_col)
      VALUES (v_Count, 'Hello World!');
  END LOOP;
END;
/

SELECT * FROM temp_table;

