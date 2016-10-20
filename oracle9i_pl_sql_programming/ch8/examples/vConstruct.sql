REM vConstruct.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates some varray constructors.

DECLARE
  -- Define a VARRAY type.
  TYPE Numbers IS VARRAY(20) OF NUMBER(3);

  -- Declare a NULL varray.
  v_NullList Numbers;

  -- This varray has 2 elements.
  v_List1 Numbers := Numbers(1, 2);

  -- This varray has one element, which itself is NULL.
  v_List2 Numbers := Numbers(NULL);
BEGIN
  IF v_NullList IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('v_NullList is NULL');
  END IF;

  IF v_List2(1) IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('v_List2(1) is NULL');
  END IF;
END;
/
