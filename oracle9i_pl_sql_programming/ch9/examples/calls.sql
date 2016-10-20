REM calls.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates the CALL statement.

set serveroutput on

CREATE OR REPLACE PROCEDURE CallProc1(p1 IN VARCHAR2 := NULL) AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('CallProc1 called with ' || p1);
END CallProc1;
/

CREATE OR REPLACE PROCEDURE CallProc2(p1 IN OUT VARCHAR2) AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('CallProc2 called with ' || p1);
  p1 := p1 || ' returned!';
END CallProc2;
/

CREATE OR REPLACE FUNCTION CallFunc(p1 IN VARCHAR2)
  RETURN VARCHAR2 AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('CallFunc called with ' || p1);
  RETURN p1;
END CallFunc;
/

set serveroutput on

-- Some valid calls direct from SQL.
CALL CallProc1('Hello!');
CALL CallProc1();
VARIABLE v_Output VARCHAR2(50);
CALL CallFunc('Hello!') INTO :v_Output;
PRINT v_Output
CALL CallProc2(:v_Output);
PRINT v_Output

-- This is illegal
BEGIN
  CALL CallProc1();
END;
/

-- But these are legal
DECLARE
  v_Result VARCHAR2(50);
BEGIN
  EXECUTE IMMEDIATE 'CALL CallProc1(''Hello from PL/SQL'')';
  EXECUTE IMMEDIATE
    'CALL CallFunc(''Hello from PL/SQL'') INTO :v_Result'
    USING OUT v_Result;
END;
/

