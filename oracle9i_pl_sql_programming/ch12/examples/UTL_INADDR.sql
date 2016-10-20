REM UTL_INADDR.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows the UTL_INADDR package.

set serveroutput on

DECLARE
  v_HostName VARCHAR2(100) := 'www.oracle.com';
BEGIN
  DBMS_OUTPUT.PUT_LINE('Address of ' || v_HostName || ' is ' ||
    UTL_INADDR.GET_HOST_ADDRESS(v_HostName));
  DBMS_OUTPUT.PUT_LINE('Name of local host is ' ||
    UTL_INADDR.GET_HOST_NAME);
END;
/

