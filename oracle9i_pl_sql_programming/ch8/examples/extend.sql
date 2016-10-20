REM extend.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the EXTEND collection method.

set serveroutput on

DECLARE
  v_NumbersTab NumTab := NumTab(1, 2, 3, 4, 5);
  v_NumbersList NumVar := NumVar(1, 2, 3, 4, 5);
BEGIN
  BEGIN
    -- This assignment will raise SUBSCRIPT_BEYOND_COUNT, since
    -- v_NumbersTab has only 5 elements.
    v_NumbersTab(26) := -7;
  EXCEPTION
    WHEN SUBSCRIPT_BEYOND_COUNT THEN
      DBMS_OUTPUT.PUT_LINE(
        'ORA-6533 raised for assignment to v_NumbersTab(26)');
  END;

  -- We can fix this by adding 30 additional elements to
  -- v_NumbersTab.
  v_NumbersTab.EXTEND(30);

  -- And now do the assignment.
  v_NumbersTab(26) := -7;

  -- For a varray, we can extend it only up to the maximum size
  -- (also given by LIMIT).  For example, the following will
  -- raise SUBSCRIPT_OUTSIDE_LIMIT:
  BEGIN
    v_NumbersList.EXTEND(30);
  EXCEPTION
    WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN
      DBMS_OUTPUT.PUT_LINE(
        'ORA-6532 raised for v_NumbersList.EXTEND(30)');
  END;

  -- But this is legal.
  v_NumbersList.EXTEND(20);

  -- And we can now assign to the highest element in the varray.
  v_NumbersList(25) := 25;
END;
/
