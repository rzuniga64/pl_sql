REM execImmediate.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates several EXECUTE IMMEDIATE commands

set serveroutput on

DECLARE
  v_SQLString  VARCHAR2(200);
  v_PLSQLBlock VARCHAR2(200);
BEGIN
  -- First create a temporary table, using a literal.  Note that
  -- there is no trailing semicolon in the string.
  EXECUTE IMMEDIATE
    'CREATE TABLE execute_table (col1 VARCHAR(10))';

  -- Insert some rows using a string.  Again, there is no
  -- trailing semicolon inside the string.
  FOR v_Counter IN 1..10 LOOP
    v_SQLString :=
      'INSERT INTO execute_table
         VALUES (''Row ' || v_Counter || ''')';
    EXECUTE IMMEDIATE v_SQLString;
  END LOOP;

  -- Print out the contents of the table using an anonymous
  -- PL/SQL block.  Here we put the entire block into a single
  -- string (including the semicolon).
  v_PLSQLBLock :=
    'BEGIN
       FOR v_Rec IN (SELECT * FROM execute_table) LOOP
         DBMS_OUTPUT.PUT_LINE(v_Rec.col1);
       END LOOP;
     END;';

  -- And now we execute the anonymous block.
  EXECUTE IMMEDIATE v_PLSQLBlock;

  -- Finally, drop the table.
  EXECUTE IMMEDIATE 'DROP TABLE execute_table';
END;
/

