REM integers.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This example shows different integeter types.

DECLARE
  v_BinInt BINARY_INTEGER;
BEGIN
  -- Assign the maximum value to v_BinInt.
  v_BinInt := 2147483647;
  
  -- Add 1 to v_BinInt (which would cause an overflow), and then
  -- subtract it again.  The result of this calculation does fit
  -- within the range of a BINARY_INTEGER, and no error is
  -- raised.
  v_BinInt := v_BinInt + 1 - 1;
END;
/

DECLARE
  v_PLSInt PLS_INTEGER;
BEGIN
  -- Assign the maximum value to v_PLSInt.
  v_PLSInt := 2147483647;
  
  -- Add 1 to v_PLSInt (which would cause an overflow), and then
  -- subtract it again.  Although the result of the calculation 
  -- would fit within the range of a PLS_INTEGER, an intermediate
  -- value does not, and so ORA-1426 is raised.
  v_PLSInt := v_PLSInt + 1 - 1;
END;
/
