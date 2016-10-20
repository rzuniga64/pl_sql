REM LogErrors.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This trigger demonstrates the use of 
REM DBMS_UTILITY.FORMAT_ERROR_STACK in a SERVERERROR trigger.

DROP TABLE error_log;

CREATE TABLE error_log (
  timestamp     DATE,
  username      VARCHAR2(30),
  instance      NUMBER,
  database_name VARCHAR2(50),
  error_stack   VARCHAR2(2000)
  );

CREATE OR REPLACE TRIGGER LogErrors
  AFTER SERVERERROR ON DATABASE
BEGIN
  INSERT INTO error_log
    VALUES (SYSDATE, SYS.LOGIN_USER, SYS.INSTANCE_NUM, SYS.
            DATABASE_NAME, DBMS_UTILITY.FORMAT_ERROR_STACK);
END LogErrors;
/

REM Create some errors
SELECT * FROM non_existent_table;

BEGIN
  INSERT INTO non_existent_table VALUES ('Hello!');
END;
/

BEGIN
  -- This is a syntax error!
  DELETE FROM students
END;
/

DECLARE
  v_StringVar VARCHAR2(2);
BEGIN
  -- This is a runtime error!
  v_StringVar := 'abcdef';
END;
/

COLUMN error_stack FORMAT a61 WRAPPED
SET LINE 80

SELECT *
  FROM error_log;
