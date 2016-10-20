REM Overload.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This package uses RESTRICT_REFERENCES with overloaded
REM subprograms.

CREATE OR REPLACE PACKAGE Overload AS
  FUNCTION TestFunc(p_Parameter1 IN NUMBER)
    RETURN VARCHAR2;
  PRAGMA RESTRICT_REFERENCES(TestFunc, WNDS, RNDS, WNPS, RNPS);

  FUNCTION TestFunc(p_ParameterA IN VARCHAR2,
                    p_ParameterB IN DATE)
    RETURN VARCHAR2;
  PRAGMA RESTRICT_REFERENCES(TestFunc, WNDS, RNDS, WNPS, RNPS);
END Overload;
/

CREATE OR REPLACE PACKAGE BODY Overload AS
  FUNCTION TestFunc(p_Parameter1 IN NUMBER)
    RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Version 1';
  END TestFunc;

  FUNCTION TestFunc(p_ParameterA IN VARCHAR2,
                    p_ParameterB IN DATE)
    RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Version 2';
  END TestFunc;
END Overload;
/

SELECT Overload.TestFunc(1) FROM dual;
SELECT Overload.TestFunc('abc', SYSDATE) FROM dual;

