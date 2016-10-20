REM count.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the COUNT collection method.

DECLARE
  v_NestedTable NumTab := NumTab(1, 2, 3);
  v_Varray NumVar := NumVar(-1, -2, -3, -4);
  v_IndexByTable IndexBy.NumTab;
BEGIN
  -- First add some elements to the index-by table.  Note that
  -- the index values are not sequential.
  v_IndexByTable(1) := 1;
  v_IndexByTable(8) := 8;
  v_IndexByTable(-1) := -1;
  v_IndexByTable(100) := 100;

  -- And print out the counts.
  DBMS_OUTPUT.PUT_LINE(
    'Nested Table Count: ' || v_NestedTable.COUNT);
  DBMS_OUTPUT.PUT_LINE(
    'Varray Count: ' || v_Varray.COUNT);
  DBMS_OUTPUT.PUT_LINE(
    'Index-By Table Count: ' || v_IndexByTable.COUNT);
END;
/
