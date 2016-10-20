REM DupValOnIndex.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This block will raise the DUP_VAL_ON_INDEX exception.

BEGIN
  INSERT INTO students (id, first_name, last_name)
    VALUES (20000, 'John', 'Smith');
  INSERT INTO students (id, first_name, last_name)
    VALUES (20000, 'Susan', 'Ryan');
END; 
/
