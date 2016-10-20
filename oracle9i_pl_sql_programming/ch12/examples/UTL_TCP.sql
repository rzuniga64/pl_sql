REM UTL_TCP.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates how to use the UTL_TCP package. 

set echo on
set serveroutput on size 200000

DECLARE
  v_Connection UTL_TCP.CONNECTION;
  v_NumWritten PLS_INTEGER;
BEGIN
  -- Open the connection at port 80, which is the standard HTTP port
  v_Connection := UTL_TCP.OPEN_CONNECTION('www.oracle.com', 80);

  -- Send HTTP request
  v_NumWritten := UTL_TCP.WRITE_LINE(v_Connection, 'GET / HTTP/1.0');
  v_NumWritten := UTL_TCP.WRITE_LINE(v_Connection);
  
  -- Print out the first 10 lines returned
  BEGIN
    FOR v_Count IN 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE(UTL_TCP.GET_LINE(v_Connection, TRUE));
    END LOOP;
  EXCEPTION
    WHEN UTL_TCP.END_OF_INPUT THEN
      NULL;
  END;
  
  UTL_TCP.CLOSE_CONNECTION(v_Connection);
END;
/

