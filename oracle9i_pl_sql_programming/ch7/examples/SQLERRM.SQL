REM SQLERRM.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows the behavior of the SQLERRM function.

set serveroutput on

BEGIN
  DBMS_OUTPUT.PUT_LINE('SQLERRM(0): ' || SQLERRM(0));
  DBMS_OUTPUT.PUT_LINE('SQLERRM(100): ' || SQLERRM(100));
  DBMS_OUTPUT.PUT_LINE('SQLERRM(10): ' || SQLERRM(10));
  DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
  DBMS_OUTPUT.PUT_LINE('SQLERRM(-1): ' || SQLERRM(-1));
  DBMS_OUTPUT.PUT_LINE('SQLERRM(-54): ' || SQLERRM(-54));
END;
/
