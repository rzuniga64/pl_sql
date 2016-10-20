REM InsertTemp.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This function cannot be called from a SQL statement.

CREATE OR REPLACE FUNCTION InsertTemp(
  p_Num IN temp_table.num_col%TYPE,
  p_Char IN temp_table.char_col%type)
  RETURN NUMBER AS
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (p_Num, p_Char);
  RETURN 0;
END InsertTemp;
/

REM Illegal query
SELECT InsertTemp(1, 'Hello')
  FROM dual;
