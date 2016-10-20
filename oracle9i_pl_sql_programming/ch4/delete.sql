REM delete.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the DELETE statement.

DECLARE
  v_StudentCutoff  NUMBER;
BEGIN
  v_StudentCutoff := 10;
  -- Delete any classes which don't have enough students registered.
  DELETE FROM classes
    WHERE current_students < v_StudentCutoff;

  -- Delete any Economics students who don't have any credits yet.
  DELETE FROM students
    WHERE current_credits = 0
    AND   major = 'Economics';
END;
/
