REM ExceptionInit.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the EXCEPTION_INIT pragma.

DELETE FROM log_table;

DECLARE
  e_MissingNull EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_MissingNull, -1400);
BEGIN
  INSERT INTO students (id) VALUES (NULL);
EXCEPTION
  WHEN e_MissingNull then
    INSERT INTO log_table (info) VALUES ('ORA-1400 occurred');
END;
/

SELECT * FROM log_table;
