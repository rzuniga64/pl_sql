REM anonymousDependencies.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This package is used to illustrate dependencies between an
REM anonymous calling block and package runtime state.

CREATE OR REPLACE PACKAGE SimplePkg AS
  v_GlobalVar NUMBER := 1;
  PROCEDURE UpdateVar;
END SimplePkg;
/

CREATE OR REPLACE PACKAGE BODY SimplePkg AS
  PROCEDURE UpdateVar IS
  BEGIN
    v_GlobalVar := 7;
  END UpdateVar;
END SimplePkg;
/
