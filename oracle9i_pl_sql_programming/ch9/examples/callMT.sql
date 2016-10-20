REM callMT.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script shows some calls to ModeTest.

set serveroutput on

DECLARE
  v_In NUMBER := 1;
  v_Out NUMBER := 2;
  v_InOut NUMBER := 3;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Before calling ModeTest:');
  DBMS_OUTPUT.PUT_LINE('v_In = ' || v_In ||
                       '  v_Out = ' || v_Out ||
                       '  v_InOut = ' || v_InOut);

  ModeTest(v_In, v_Out, v_InOut);

  DBMS_OUTPUT.PUT_LINE('After calling ModeTest:');
  DBMS_OUTPUT.PUT_LINE('  v_In = ' || v_In ||
                       '  v_Out = ' || v_Out ||
                       '  v_InOut = ' || v_InOut);
END;
/

-- Call ModeTest with a literal for p_InParameter.  This is legal.
DECLARE
  v_Out NUMBER := 2;
  v_InOut NUMBER := 3;
BEGIN
  ModeTest(1, v_Out, v_InOut);
END;
/

-- However, if we replace v_Out or v_InOut with a literal, we get a
-- compilation error:
DECLARE
  v_InOut NUMBER := 3;
BEGIN
  ModeTest(1, 2, v_InOut);
END;
/
