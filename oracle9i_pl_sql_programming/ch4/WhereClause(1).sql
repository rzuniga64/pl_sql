REM WhereClause.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates several different WHERE clauses.

DECLARE
  v_Department  CHAR(3);
BEGIN
  v_Department := 'CS';
  -- Remove all Computer Science classes
  DELETE FROM classes
    WHERE department = v_Department;
END;
/

DECLARE
 Department  CHAR(3);
BEGIN
  Department := 'CS';
  -- Remove all Computer Science classes
  DELETE FROM classes
    WHERE department = Department;
END;
/

<<l_DeleteBlock>>
DECLARE
  Department  CHAR(3);
BEGIN
  Department := 'CS';
  -- Remove all Computer Science classes
  DELETE FROM classes
    WHERE department = l_DeleteBlock.Department;
END;
/

DECLARE
 v_Department  VARCHAR2(3);
BEGIN
  v_Department := 'CS';
  -- Remove all Computer Science classes
  DELETE FROM classes
    WHERE department = v_Department;
END;
/
