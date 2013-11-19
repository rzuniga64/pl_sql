create or replace 
TRIGGER BB_LOGON_PASS_TRG 
AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO bb_audit_logon(userid, logdate)
      VALUES(USER, SYSDATE);
END;