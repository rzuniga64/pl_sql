REM DefaultTest.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script shows different ways of calling a procedure
REM with default parameters.

set serveroutput on

CREATE OR REPLACE PROCEDURE DefaultTest (
  p_ParameterA NUMBER DEFAULT 10,
  p_ParameterB VARCHAR2 DEFAULT 'abcdef',
  p_ParameterC DATE DEFAULT SYSDATE) AS
BEGIN
  DBMS_OUTPUT.PUT_LINE(
    'A: ' || p_ParameterA ||
    '  B: ' || p_ParameterB ||
    '  C: ' || TO_CHAR(p_ParameterC, 'DD-MON-YYYY'));
END DefaultTest;
/
show errors

BEGIN
  DefaultTest(p_ParameterA => 7, p_ParameterC => '30-DEC-95');
END;
/

BEGIN
  -- Uses the default value for both p_ParameterB and
  -- p_ParameterC.
  DefaultTest(7);
END;
/
