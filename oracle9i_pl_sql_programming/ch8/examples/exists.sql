REM exists.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the EXISTS method.

DECLARE
  v_NestedTable NumTab := NumTab(-7, 14.3, 3.14159, NULL, 0);
  v_Count BINARY_INTEGER := 1;
  v_IndexByTable IndexBy.NumTab;
BEGIN
  -- Loop over v_NestedTable, and print out the elements, using
  -- EXISTS to indicate the end of the loop.
  LOOP
    IF v_NestedTable.EXISTS(v_Count) THEN
      DBMS_OUTPUT.PUT_LINE(
        'v_NestedTable(' || v_Count || '): ' ||
        v_NestedTable(v_Count));
      v_Count := v_Count + 1;
    ELSE
      EXIT;
    END IF;
  END LOOP;

  -- Assign the same elements to the index-by table.
  v_IndexByTable(1) := -7;
  v_IndexByTable(2) := 14.3;
  v_IndexByTable(3) := 3.14159;
  v_IndexByTable(4) := NULL;
  v_IndexByTable(5) := 0;

  -- And do a similar loop.
  v_Count := 1;
  LOOP
    IF v_IndexByTable.EXISTS(v_Count) THEN
      DBMS_OUTPUT.PUT_LINE(
        'v_IndexByTable(' || v_Count || '): ' ||
        v_IndexByTable(v_Count));
      v_Count := v_Count + 1;
    ELSE
      EXIT;
    END IF;
  END LOOP;
END;
/
