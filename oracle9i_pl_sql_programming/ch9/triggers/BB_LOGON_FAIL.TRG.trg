/*
	System triggers are fired by database events, such as startup
	and shutdown, and server error messages.  System events that 
	can be used in triggers include STARTUP, SHUTDOWN, and SERVERERROR.
*/
create or replace 
TRIGGER BB_LOGON_FAIL_TRG 
AFTER SERVERERROR ON SCHEMA 
BEGIN
  IF (IS_SERVERERROR(1017)) THEN
    INSERT INTO bb_audit_logon(userid, logdate)
      VALUES(SYS_CONTEXT('USERENV','OS_USER'), SYSDATE);
  ELSE
    NULL; -- could address additional server errors
  END IF;
END;