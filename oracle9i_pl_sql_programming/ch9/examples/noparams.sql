REM noparams.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script shows stored subprograms with no parameters.

set serveroutput on

CREATE OR REPLACE PROCEDURE NoParamsP AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('No Paramaters!');
END NoParamsP;
/

CREATE OR REPLACE FUNCTION NoParamsF
  RETURN DATE AS
BEGIN
  RETURN SYSDATE;
END NoParamsF;
/

BEGIN
  NoParamsP;
  DBMS_OUTPUT.PUT_LINE('Calling NoParamsF on ' ||
    TO_CHAR(NoParamsF, 'DD-MON-YYYY'));
END;
/
