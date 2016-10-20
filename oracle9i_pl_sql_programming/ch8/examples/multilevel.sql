REM multilevel.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates multilevel collections.

DECLARE
  -- First declare an index-by table of numbers
  TYPE t_Numbers IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
    
  -- Now declare a type which is an index-by table of t_Numbers.
  -- This is a multilevel collection.
  TYPE t_MultiNumbers IS TABLE OF t_Numbers
    INDEX BY BINARY_INTEGER;
    
  -- We can also have a varray of the index-by table
  TYPE t_MultiVarray IS VARRAY(10) OF t_Numbers;
  
  -- Or a nested table
  TYPE t_MultiNested IS TABLE OF t_Numbers;
  
  v_MultiNumbers t_MultiNumbers;
BEGIN
  v_MultiNumbers(1)(1) := 12345;
END;
/
