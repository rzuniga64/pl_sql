REM PipeReceive.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the use of the DBMS_PIPE package to
REM receive a message.

set serveroutput on

DECLARE
  v_PipeName VARCHAR2(30) := 'MyPipe';
  v_Status INTEGER;
  v_DateVal DATE;
  v_NumberVal NUMBER;
  v_StringVal VARCHAR2(100);
BEGIN
  -- First receive the message.  This call will block until
  -- the message is actually sent.
  v_Status := DBMS_PIPE.RECEIVE_MESSAGE(v_PipeName);
  IF v_Status != 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error ' || v_Status || 
                         ' while receiving message');
  END IF;
  
  -- Now we can unpack the parts of the message.  This is done
  -- in the same order in which they were sent.
  DBMS_PIPE.UNPACK_MESSAGE(v_DateVal);
  DBMS_PIPE.UNPACK_MESSAGE(v_NumberVal);
  DBMS_PIPE.UNPACK_MESSAGE(v_StringVal);
  
  -- And print them out.
  DBMS_OUTPUT.PUT_LINE('Unpacked ' || v_DateVal);
  DBMS_OUTPUT.PUT_LINE('Unpacked ' || v_NumberVal);
  DBMS_OUTPUT.PUT_LINE('Unpacked ' || v_StringVal);
END;
/

