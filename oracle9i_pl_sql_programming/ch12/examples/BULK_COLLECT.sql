REM BULK_COLLECT.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates several different BULK_COLLECT 
REM statements, used for bulk binds

set serveroutput on format wrapped

DECLARE
  TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE;
  TYPE t_Strings IS TABLE OF temp_table.char_col%TYPE;
  v_Numbers t_Numbers := t_Numbers(1);
  v_Strings t_Strings := t_Strings(1);
  v_Numbers2 t_Numbers;
  v_Strings2 t_Strings;

  CURSOR c_char IS
    SELECT char_col
    FROM temp_table
    WHERE num_col > 800
    ORDER BY num_col;

BEGIN
  -- First load temp_table with 1500 rows, 500 of which are
  -- duplicates.
  v_Numbers.EXTEND(1500);
  v_Strings.EXTEND(1500);
  FOR v_Count IN 1..1000 LOOP
    v_Numbers(v_Count) := v_Count;
    v_Strings(v_Count) := 'Element #' || v_Count;
    IF v_Count > 500 THEN
      v_Numbers(v_Count + 500) := v_Count;
      v_Strings(v_Count + 500) := 'Element #' || v_Count;
    END IF;
  END LOOP;

  DELETE FROM temp_table;
  FORALL v_Count IN 1..1500
    INSERT INTO temp_table (num_col, char_col)
      VALUES (v_Numbers(v_Count), v_Strings(v_Count));

  -- Grab all of the rows back into the nested tables in one
  -- operation.
  SELECT num_col, char_col
    BULK COLLECT INTO v_Numbers, v_Strings
    FROM temp_table
    ORDER BY num_col;

  DBMS_OUTPUT.PUT_LINE(
    'First query fetched ' || v_Numbers.COUNT || ' rows');

  -- The table does not have to be initialized, the BULK COLLECT
  -- will add elements as needed:
  SELECT num_col
    BULK COLLECT INTO v_Numbers2
    FROM temp_table;

  DBMS_OUTPUT.PUT_LINE(
    'Second query fetched ' || v_Numbers2.COUNT || ' rows');

  -- We can bulk fetch from a cursor as well.
  OPEN c_char;
  FETCH c_char BULK COLLECT INTO v_Strings2;
  CLOSE c_char;

  DBMS_OUTPUT.PUT_LINE(
    'Cursor fetch retrieved ' || v_Strings2.COUNT || ' rows');

END;
/

DECLARE
  TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Strings IS TABLE OF temp_table.char_col%TYPE
    INDEX BY BINARY_INTEGER;
  v_Numbers t_Numbers;
  v_Strings t_Strings;
BEGIN
  -- Delete from the table, and then insert 55 rows.  Also set
  -- up t_Numbers here.
  DELETE FROM temp_table;
  FOR v_Outer IN 1..10 LOOP
    FOR v_Inner IN 1..v_Outer LOOP
      INSERT INTO temp_table (num_col, char_col)
        VALUES (v_Outer, 'Element #' || v_Inner);
    END LOOP;
    v_Numbers(v_Outer) := v_Outer;
  END LOOP;

  -- Delete some of the rows, but save the character data.
  FORALL v_Count IN 1..5
    DELETE FROM temp_table
      WHERE num_col = v_Numbers(v_Count)
      RETURNING char_col BULK COLLECT INTO v_Strings;

  -- v_Strings now contains 15 rows, which is 1+2+3+4+5.
  DBMS_OUTPUT.PUT_LINE('After delete:');
  FOR v_Count IN 1..v_Strings.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(
      '  v_Strings(' || v_Count || ') = ' || v_Strings(v_Count));
  END LOOP;
END;
/
