REM Collections.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates some PL/SQL collections.

DECLARE
  TYPE t_IndexBy IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
  TYPE t_Nested IS TABLE OF NUMBER;
  TYPE t_Varray IS VARRAY(10) OF NUMBER;

  v_IndexBy t_IndexBy;
  v_Nested t_Nested;
  v_Varray t_Varray;
BEGIN
  v_IndexBy(1) := 1;
  v_IndexBy(2) := 2;
  v_Nested := t_Nested(1, 2, 3, 4, 5);
  v_Varray := t_Varray(1, 2);
END;
/
