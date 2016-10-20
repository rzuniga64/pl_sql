REM bulkDemo.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates bulk processing.

DECLARE
  TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Chars IS TABLE OF temp_table.char_col%TYPE
    INDEX BY BINARY_INTEGER;
  v_Numbers t_Numbers;
  v_Chars t_Chars;
BEGIN
  -- Fill up the arrays with 500 rows.
  FOR v_Count IN 1..500 LOOP
    v_Numbers(v_Count) := v_Count;
    v_Chars(v_Count) := 'Row number ' || v_Count;
  END LOOP;

  -- And insert them into the database.
  FOR v_Count IN 1..500 LOOP
    INSERT INTO temp_table VALUES
      (v_Numbers(v_Count), v_Chars(v_Count));
  END LOOP;
END;
/

DECLARE
  TYPE t_Numbers IS TABLE OF temp_table.num_col%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_Chars IS TABLE OF temp_table.char_col%TYPE
    INDEX BY BINARY_INTEGER;
  v_Numbers t_Numbers;
  v_Chars t_Chars;
BEGIN
  -- Fill up the arrays with 500 rows.
  FOR v_Count IN 1..500 LOOP
    v_Numbers(v_Count) := v_Count;
    v_Chars(v_Count) := 'Row number ' || v_Count;
  END LOOP;

  -- And insert them into the database using bulk binds.
  FORALL v_Count IN 1..500
    INSERT INTO temp_table VALUES
      (v_Numbers(v_Count), v_Chars(v_Count));
END;
/
