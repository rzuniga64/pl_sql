REM TrustPkg.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This package uses the TRUST keyword with RESTRICT_REFERENCES.

CREATE OR REPLACE PACKAGE TrustPkg AS
  FUNCTION ToUpper (p_a VARCHAR2) RETURN VARCHAR2 IS
    LANGUAGE JAVA
    NAME 'Test.Uppercase(char[]) return char[]';
    PRAGMA RESTRICT_REFERENCES(ToUpper, WNDS, TRUST);

  PROCEDURE Demo(p_in IN VARCHAR2, p_out OUT VARCHAR2);
  PRAGMA RESTRICT_REFERENCES(Demo, WNDS);
END TrustPkg;
/

CREATE OR REPLACE PACKAGE BODY TrustPkg AS
  PROCEDURE Demo(p_in IN VARCHAR2, p_out OUT VARCHAR2) IS
  BEGIN
    p_out := ToUpper(p_in);
  END Demo;
END TrustPkg;
/
