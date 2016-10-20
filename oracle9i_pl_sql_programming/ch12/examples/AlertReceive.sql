REM AlertReceive.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates receiving an alert using DBMS_ALERT.

set serveroutput on

DECLARE
  v_AlertName VARCHAR2(30) := 'MyAlert';
  v_Message VARCHAR2(100);
  v_Status INTEGER;
BEGIN
  -- In order to receive an alert, we must first register interest
  -- in it.
  DBMS_ALERT.REGISTER(v_AlertName);
  
  -- Now that we have registered, we can wait.
  DBMS_ALERT.WAITONE(v_AlertName, v_Message, v_Status);
  
  IF v_Status = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Received: ' || v_Message);
  ELSE
    DBMS_OUTPUT.PUT_LINE('WAITONE timed out');
  END IF;
END;
/
