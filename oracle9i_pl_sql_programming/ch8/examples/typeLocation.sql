REM typeLocation.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This file contains examples of different locations for
REM collection types.

-- Create a stored type which is visible to SQL and PL/SQL.
CREATE OR REPLACE TYPE NameList AS
  VARRAY(20) OF VARCHAR2(30);
/

DECLARE
  -- This type is local to this block.
  TYPE DateList IS VARRAY(10) OF DATE;

  -- We can create variables of both DateList and NameList here.
  v_Dates DateList;
  v_Names NameList;
BEGIN
  NULL;
END;
/

DECLARE
  -- Since NameList is global to PL/SQL, we can reference it in
  -- another block as well.
  v_Names2 NameList;
BEGIN
  NULL;
END;
/

