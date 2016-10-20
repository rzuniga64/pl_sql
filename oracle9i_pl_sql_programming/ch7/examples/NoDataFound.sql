REM NoDataFound.sql
REM Chapter 7, Oracle9i PL/SQL Programming, by Scott Urman
REM This block will raise the NO_DATA_FOUND exception.

DECLARE
  TYPE t_NumberTableType IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
  v_NumberTable t_NumberTableType;
  v_TempVar NUMBER;
BEGIN
  v_TempVar := v_NumberTable(1);
END;
/
