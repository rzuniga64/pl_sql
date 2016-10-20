REM mutual.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This example demonstrates mutually exclusive local subprograms.

set serveroutput on

DECLARE
  v_TempVal BINARY_INTEGER := 5;

  -- Local procedure A. Note that the code of A calls procedure B.
  PROCEDURE A(p_Counter IN OUT BINARY_INTEGER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('A(' || p_Counter || ')');
    IF p_Counter > 0 THEN
      B(p_Counter);
      p_Counter := p_Counter - 1;
    END IF;
  END A;

  -- Local procedure B. Note that the code of B calls procedure A.
  PROCEDURE B(p_Counter IN OUT BINARY_INTEGER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('B(' || p_Counter || ')');
    p_Counter := p_Counter - 1;
    A(p_Counter);
  END B;
BEGIN
  B(v_TempVal);
END;
/
