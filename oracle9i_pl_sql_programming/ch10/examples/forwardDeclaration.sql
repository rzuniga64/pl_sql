REM forwardDeclaration.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a forward declaration.

set serveroutput on

DECLARE
  v_TempVal BINARY_INTEGER := 5;

  -- Forward declaration of procedure B.
  PROCEDURE B(p_Counter IN OUT BINARY_INTEGER);

  PROCEDURE A(p_Counter IN OUT BINARY_INTEGER) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('A(' || p_Counter || ')');
    IF p_Counter > 0 THEN
      B(p_Counter);
      p_Counter := p_Counter - 1;
    END IF;
  END A;

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
