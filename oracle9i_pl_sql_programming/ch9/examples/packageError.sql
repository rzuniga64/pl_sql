REM packageError.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This package will not compile because the body does not
REM match the specification.

CREATE OR REPLACE PACKAGE PackageA AS
  FUNCTION FunctionA(p_Parameter1 IN NUMBER,
                      p_Parameter2 IN DATE)
    RETURN VARCHAR2;
END PackageA;
/
show errors

CREATE OR REPLACE PACKAGE BODY PackageA AS
  FUNCTION FunctionA(p_Parameter1 IN CHAR,
                      p_Parameter2 IN DATE)
    RETURN VARCHAR2;
END PackageA;
/
show errors

