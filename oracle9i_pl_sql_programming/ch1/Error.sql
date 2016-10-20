REM Error.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates some of the error-handling features
REM of PL/SQL.

DECLARE
  v_ErrorCode NUMBER;          -- Code for the error
  v_ErrorMsg  VARCHAR2(200);   -- Message text for the error
  v_CurrentUser VARCHAR2(8);   -- Current database user
  v_Information VARCHAR2(100); -- Information about the error
BEGIN
  /* Code that processes some data here */
EXCEPTION
  WHEN OTHERS THEN
    -- Assign values to the log variables, using built-in
    -- functions.
    v_ErrorCode := SQLCODE;
    v_ErrorMsg := SQLERRM;
    v_CurrentUser := USER;
    v_Information := 'Error encountered on ' ||
      TO_CHAR(SYSDATE) || ' by database user ' || v_CurrentUser;
    -- Insert the log message into log_table.
    INSERT INTO log_table (code, message, info)
      VALUES (v_ErrorCode, v_ErrorMsg, v_Information);
END;
/
