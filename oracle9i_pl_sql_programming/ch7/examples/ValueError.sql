REM ValueError.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This example raises the VALUE_ERROR exception in two different
REM ways.

DECLARE
  v_TempVar VARCHAR2(3);
BEGIN
  v_TempVar := 'ABCD';
END;
/

DECLARE
  v_TempVar NUMBER(2);
BEGIN
  SELECT id
    INTO v_TempVar
    FROM students
    WHERE last_name = 'Smith';
END;
/
