REM limit.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows the LIMIT collection operator.

DECLARE
  v_Table NumTab := NumTab(1, 2, 3);
  v_Varray NumVar := NumVar(1234, 4321);
BEGIN
  -- Output the limit and count for the collections.
  DBMS_OUTPUT.PUT_LINE('Varray limit: ' || v_Varray.LIMIT);
  DBMS_OUTPUT.PUT_LINE('Varray count: ' || v_Varray.COUNT);
  IF v_Table.LIMIT IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('Table limit is NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table limit: ' || v_Table.LIMIT);
  END IF;
  DBMS_OUTPUT.PUT_LINE('Table count: ' || v_Table.COUNT);
END;
/
