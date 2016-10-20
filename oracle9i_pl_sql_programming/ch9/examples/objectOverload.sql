REM objectOverload.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates overloading packaged subprograms
REM based on object types.

CREATE OR REPLACE TYPE t1 AS OBJECT (
  f NUMBER
);
/
show errors

CREATE OR REPLACE TYPE t2 AS OBJECT (
  f NUMBER
);
/
show errors

CREATE OR REPLACE PACKAGE Overload AS
  PROCEDURE Proc(p_Parameter1 IN t1);
  PROCEDURE Proc(p_Parameter1 IN t2);
END Overload;
/
show errors

CREATE OR REPLACE PACKAGE BODY Overload AS
  PROCEDURE Proc(p_Parameter1 IN t1) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Proc(t1): ' || p_Parameter1.f);
  END Proc;

  PROCEDURE Proc(p_Parameter1 IN t2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Proc(t2): ' || p_Parameter1.f);
  END Proc;
END Overload;
/
show errors

set serveroutput on

DECLARE
  v_Obj1 t1 := t1(1);
  v_Obj2 t2 := t2(2);
BEGIN
  Overload.Proc(v_Obj1);
  Overload.Proc(v_Obj2);
END;
/
