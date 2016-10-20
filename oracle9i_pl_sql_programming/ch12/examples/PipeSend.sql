REM PipeSend.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the use of the DBMS_PIPE package to
REM send a message.

DECLARE
  v_PipeName VARCHAR2(30) := 'MyPipe';
  v_Status INTEGER;
BEGIN
  -- Pack some information into the pipe.  We will send the current
  -- date, along with a number and varchar2 value.
  DBMS_PIPE.PACK_MESSAGE(SYSDATE);
  DBMS_PIPE.PACK_MESSAGE(123456);
  DBMS_PIPE.PACK_MESSAGE('This is a message sent from the pipe!');
  
  -- Now we can send the message.
  v_Status := DBMS_PIPE.SEND_MESSAGE(v_PipeName);
  IF v_Status != 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error ' || v_Status || 
                         ' while sending message');
  END IF;
END;
/

