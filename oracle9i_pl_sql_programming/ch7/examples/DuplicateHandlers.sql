REM DuplicateHandlers.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This example illustrates the PLS-483 error.

DECLARE
  -- Declare 2 user defined exceptions
  e_Exception1 EXCEPTION;
  e_Exception2 EXCEPTION;
BEGIN
  -- Raise just exception 1.
  RAISE e_Exception1;
EXCEPTION
  WHEN e_Exception2 THEN
    INSERT INTO log_table (info)
      VALUES ('Handler 1 executed!');
  WHEN e_Exception1 THEN
    INSERT INTO log_table (info)
      VALUES ('Handler 3 executed!');
  WHEN e_Exception1 OR e_Exception2 THEN
    INSERT INTO log_table (info)
      VALUES ('Handler 4 executed!');
END;
/