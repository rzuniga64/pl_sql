REM FORALL.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates several different FORALL statements,
REM used in bulk binds.

set serveroutput on format wrapped

DECLARE
  TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE;
  TYPE t_Strings IS TABLE OF temp_table.char_col%TYPE;
  v_Numbers t_Numbers := t_Numbers(1);
  v_Strings t_Strings := t_Strings(1);

  -- Prints the total number of rows in temp_table.
  PROCEDURE PrintTotalRows(p_Message IN VARCHAR2) IS
    v_Count NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO v_Count
      FROM temp_table;
    DBMS_OUTPUT.PUT_LINE(p_Message || ': Count is ' || v_Count);
  END PrintTotalRows;

BEGIN
  -- First delete from temp_table.
  DELETE FROM temp_table;

  -- Fill up the PL/SQL nested tables with 1000 values.
  v_Numbers.EXTEND(1000);
  v_Strings.EXTEND(1000);
  FOR v_Count IN 1..1000 LOOP
    v_Numbers(v_Count) := v_Count;
    v_Strings(v_Count) := 'Element #' || v_Count;
  END LOOP;

  -- Insert all 1000 elements using a single FORALL statement.
  FORALL v_Count IN 1..1000
    INSERT INTO temp_table VALUES
      (v_Numbers(v_Count), v_Strings(v_Count));

  -- There should be 1000 rows now.
  PrintTotalRows('After first insert');

  -- Insert elements 501 through 1000 again.
  FORALL v_Count IN 501..1000
    INSERT INTO temp_table VALUES
      (v_Numbers(v_Count), v_Strings(v_Count));

  -- We should now have 1500 rows
  PrintTotalRows('After second insert');

  -- Update all of the rows.
  FORALL v_Count IN 1..1000
    UPDATE temp_table
      SET char_col = 'Changed!'
      WHERE num_col = v_Numbers(v_Count);

  -- Even though there are only 1000 elements, the previous
  -- statement updated 1500 rows, since the WHERE clause matched
  -- 2 rows for each of the last 500.
  DBMS_OUTPUT.PUT_LINE(
    'Update processed ' || SQL%ROWCOUNT || ' rows.');

  -- Likewise, this DELETE will remove 300 rows
  FORALL v_Count IN 401..600
    DELETE FROM temp_table
      WHERE num_col = v_Numbers(v_Count);

  -- So there should be 1200 left.
  PrintTotalRows('After delete');
END;
/

-- This block shows that an exception will stop the bulk insert.
DECLARE
  TYPE t_Strings IS TABLE OF temp_table.char_col%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE
    INDEX BY BINARY_INTEGER;
  v_Strings t_Strings;
  v_Numbers t_Numbers;
BEGIN
  -- Delete from the table, and set up the index-by table.
  DELETE FROM temp_table;
  FOR v_Count IN 1..10 LOOP
    v_Strings(v_Count) := '123456789012345678901234567890';
    v_Numbers(v_Count) := v_Count;
  END LOOP;

  FORALL v_Count IN 1..10
    INSERT INTO temp_table (num_col, char_col)
      VALUES (v_Numbers(v_Count), v_Strings(v_Count));

  -- Add an extra character to v_Strings(6).
  v_Strings(6) := v_Strings(6) || 'a';

  -- This bulk update will fail on the sixth row, but the
  -- first 5 rows will still be updated.
  FORALL v_Count IN 1..10
    UPDATE temp_table
      SET char_col = char_col || v_Strings(v_Count)
      WHERE num_col = v_Numbers(v_Count);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Got exception: ' || SQLERRM);
    COMMIT;
END;
/

-- This query should show that the first 5 rows have been
-- modified.
SELECT char_col
  FROM temp_table
  ORDER BY num_col;


-- Oracle9i only: The SAVE EXCEPTIONS clause will record any
-- exception during the bulk operation, and continue processing.
DECLARE
  TYPE t_Strings IS TABLE OF temp_table.char_col%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE
    INDEX BY BINARY_INTEGER;
  v_Strings t_Strings;
  v_Numbers t_Numbers;
  v_NumErrors NUMBER;
BEGIN
  -- Delete from the table, and set up the index-by table.
  DELETE FROM temp_table;
  FOR v_Count IN 1..10 LOOP
    v_Strings(v_Count) := '123456789012345678901234567890';
    v_Numbers(v_Count) := v_Count;
  END LOOP;

  FORALL v_Count IN 1..10
    INSERT INTO temp_table (num_col, char_col)
      VALUES (v_Numbers(v_Count), v_Strings(v_Count));

  -- Add an extra character to v_Strings(6).
  v_Strings(6) := v_Strings(6) || 'a';

  -- This bulk update will fail on the sixth row, and continue
  -- processing.
  FORALL v_Count IN 1..10 SAVE EXCEPTIONS
    UPDATE temp_table
      SET char_col = char_col || v_Strings(v_Count)
      WHERE num_col = v_Numbers(v_Count);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Got exception: ' || SQLERRM);
    -- Print out any errors.
    v_NumErrors := SQL%BULK_EXCEPTIONS.COUNT;
    DBMS_OUTPUT.PUT_LINE(
      'Number of errors during processing: ' || v_NumErrors);
    FOR v_Count IN 1..v_NumErrors LOOP
      DBMS_OUTPUT.PUT_LINE('Error ' || v_Count || ', iteration ' ||
        SQL%BULK_EXCEPTIONS(v_Count).error_index || ' is: ' ||
        SQLERRM(0 - SQL%BULK_EXCEPTIONS(v_Count).error_code));
    END LOOP;

    COMMIT;
END;
/

-- This query should show that rows 1-5, and 7-10 have been
-- modified, even though row 6 had an error.
SELECT char_col
  FROM temp_table
  ORDER BY num_col;