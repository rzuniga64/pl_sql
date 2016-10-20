REM varray.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates some varray declarations.

DECLARE
  -- Some valid varray types.
  -- This is a list of numbers, each of which is constrained to
  -- be not null.
  TYPE NumberList IS VARRAY(10) OF NUMBER(3) NOT NULL;

  -- A list of PL/SQL records.
  TYPE StudentList IS VARRAY(100) OF students%ROWTYPE;

  -- A list of objects.
  TYPE ObjectList is VARRAY(25) OF MyObject;
BEGIN
  NULL;
END;
/
