REM AlertSend.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates sending an alert through DBMS_ALERT.

set serveroutput on

DECLARE
  v_AlertName VARCHAR2(30) := 'MyAlert';
BEGIN
  -- An alert is sent by the SIGNAL procedure.
  DBMS_ALERT.SIGNAL(v_AlertName, 'Alert!  Alert!  Alert!');
  
  -- It is not actually sent until we commit.
  COMMIT;
END;
/
