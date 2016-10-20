REM ErrorPkg.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This file illustrates a more advanced error handling package.

set serveroutput on size 200000
set linesize 250

-- These 3 procedures illustrate the use of FORMAT_CALL_STACK.
CREATE OR REPLACE PROCEDURE C AS
  v_CallStack VARCHAR2(2000);
BEGIN
  v_CallStack := DBMS_UTILITY.FORMAT_CALL_STACK;
  DBMS_OUTPUT.PUT_LINE(v_CallStack);
END C;
/

CREATE OR REPLACE PROCEDURE B AS
BEGIN
  C;
END B;
/

CREATE OR REPLACE PROCEDURE A AS
BEGIN
  B;
END A;
/

exec A;

DROP TABLE errors;
CREATE TABLE errors (
  module       VARCHAR2(50),
  seq_number   NUMBER,
  error_number NUMBER,
  error_mesg   VARCHAR2(100),
  error_stack  VARCHAR2(2000),
  call_stack   VARCHAR2(2000),
  timestamp    DATE,
  PRIMARY KEY (module, seq_number));

DROP TABLE call_stacks;
CREATE TABLE call_stacks (
  module        VARCHAR2(50),
  seq_number    NUMBER,
  call_order    NUMBER,
  object_handle VARCHAR2(10),
  line_num      NUMBER,
  object_name   VARCHAR2(80),
  PRIMARY KEY (module, seq_number, call_order),
  FOREIGN KEY (module, seq_number) REFERENCES errors ON DELETE CASCADE);

DROP TABLE error_stacks;
CREATE TABLE error_stacks (
  module        VARCHAR2(50),
  seq_number    NUMBER,
  error_order   NUMBER,
  facility      CHAR(3),
  error_number  NUMBER(5),
  error_mesg    VARCHAR2(100),
  PRIMARY KEY (module, seq_number, error_order),
  FOREIGN KEY (module, seq_number) REFERENCES errors ON DELETE CASCADE);

DROP SEQUENCE error_seq;
CREATE SEQUENCE error_seq
  START WITH 1
  INCREMENT BY 1;

/* Generic error-handling package, using
 DBMS_UTILITY.FORMAT_ERROR_STACK and DBMS_UTILITY.FORMAT_CALL_STACK. 
 This package will store general error information in the errors
 table, with detailed call stack and error stack information in the
 call_stacks and error_stacks tables, respectively. */
CREATE OR REPLACE PACKAGE ErrorPkg AS

  -- Entry point for handling errors.  HandleAll should be called
  -- from all exception handlers where you want the error to be
  -- logged.  p_Top should be TRUE only at the topmost level of
  -- procedure nesting.  It should be FALSE at other levels.
  PROCEDURE HandleAll(p_Top BOOLEAN);

  -- Prints the error and call stacks (using DBMS_OUTPUT) for the
  -- given module and sequence number.
  PROCEDURE PrintStacks(p_Module IN errors.module%TYPE,
                        p_SeqNum IN errors.seq_number%TYPE);

  -- Unwinds the call and error stacks, and stores them in the errors
  -- and call_stacks tables.  Returns the sequence number under which
  -- the error is stored.
  -- If p_CommitFlag is TRUE, then the inserts are committed.
  -- In order to use StoreStacks, an error must have been handled. 
  -- Thus HandleAll should have been called with p_Top = TRUE.
  PROCEDURE StoreStacks(p_Module IN errors.module%TYPE,
                        p_SeqNum OUT errors.seq_number%TYPE,
                        p_CommitFlag BOOLEAN DEFAULT FALSE);
END ErrorPkg;
/
show errors

CREATE OR REPLACE PACKAGE BODY ErrorPkg AS

  v_NewLine     CONSTANT CHAR(1) := CHR(10);

  v_Handled     BOOLEAN := FALSE;
  v_ErrorStack  VARCHAR2(2000);
  v_CallStack   VARCHAR2(2000);

  PROCEDURE HandleAll(p_Top BOOLEAN) IS
  BEGIN
    IF p_Top THEN
      v_Handled := FALSE;
    ELSIF NOT v_Handled THEN
      v_Handled := TRUE;
      v_ErrorStack := DBMS_UTILITY.FORMAT_ERROR_STACK;
      v_CallStack := DBMS_UTILITY.FORMAT_CALL_STACK;
    END IF;      
  END HandleAll;

  PROCEDURE PrintStacks(p_Module IN errors.module%TYPE,
                        p_SeqNum IN errors.seq_number%TYPE) IS
    v_TimeStamp errors.timestamp%TYPE;
    v_ErrorMsg  errors.error_mesg%TYPE;

    CURSOR c_CallCur IS
      SELECT object_handle, line_num, object_name
        FROM call_stacks
        WHERE module = p_Module
        AND seq_number = p_SeqNum
        ORDER BY call_order;

    CURSOR c_ErrorCur IS
      SELECT facility, error_number, error_mesg
        FROM error_stacks
        WHERE module = p_Module
        AND seq_number = p_SeqNum
        ORDER BY error_order;
  BEGIN
    SELECT timestamp, error_mesg
      INTO v_TimeStamp, v_ErrorMsg
      FROM errors
      WHERE module = p_Module
      AND seq_number = p_SeqNum;

    -- Output general error information.
    DBMS_OUTPUT.PUT(TO_CHAR(v_TimeStamp, 'DD-MON-YY HH24:MI:SS'));
    DBMS_OUTPUT.PUT('  Module: ' || p_Module);
    DBMS_OUTPUT.PUT('  Error #' || p_SeqNum || ':  ');
    DBMS_OUTPUT.PUT_LINE(v_ErrorMsg);

    -- Output the call stack.
    DBMS_OUTPUT.PUT_LINE('Complete Call Stack:');
    DBMS_OUTPUT.PUT_LINE('  Object Handle  Line Number  Object Name');
    DBMS_OUTPUT.PUT_LINE('  -------------  -----------  -----------');
    FOR v_CallRec in c_CallCur LOOP
      DBMS_OUTPUT.PUT(RPAD('  ' || v_CallRec.object_handle, 15));
      DBMS_OUTPUT.PUT(RPAD('  ' || TO_CHAR(v_CallRec.line_num), 13));
      DBMS_OUTPUT.PUT_LINE('  ' || v_CallRec.object_name);
    END LOOP;

    -- Output the error stack.
    DBMS_OUTPUT.PUT_LINE('Complete Error Stack:');
    FOR v_ErrorRec in c_ErrorCur LOOP
      DBMS_OUTPUT.PUT('  ' || v_ErrorRec.facility || '-');
      DBMS_OUTPUT.PUT(TO_CHAR(v_ErrorRec.error_number) || ': ');
      DBMS_OUTPUT.PUT_LINE(v_ErrorRec.error_mesg);
    END LOOP;
    
  END PrintStacks;

  PROCEDURE StoreStacks(p_Module IN errors.module%TYPE,
                        p_SeqNum OUT errors.seq_number%TYPE,
                        p_CommitFlag BOOLEAN DEFAULT FALSE) IS
    v_SeqNum     NUMBER;

    v_Index      NUMBER;
    v_Length     NUMBER;
    v_End        NUMBER;

    v_Call       VARCHAR2(100);
    v_CallOrder  NUMBER := 1;
    v_Handle     call_stacks.object_handle%TYPE;
    v_LineNum    call_stacks.line_num%TYPE;
    v_ObjectName call_stacks.object_name%TYPE;

    v_Error      VARCHAR2(120);
    v_ErrorOrder NUMBER := 1;
    v_Facility   error_stacks.facility%TYPE;
    v_ErrNum     error_stacks.error_number%TYPE;
    v_ErrMsg     error_stacks.error_mesg%TYPE;

    v_FirstErrNum errors.error_number%TYPE;
    v_FirstErrMsg errors.error_mesg%TYPE;
  BEGIN
    -- First get the error sequence number.
    SELECT error_seq.nextval
      INTO v_SeqNum
      FROM dual;

    p_SeqNum := v_SeqNum;

    -- Insert the first part of the header information into the
    -- errors table.
    INSERT INTO errors
      (module, seq_number, error_stack, call_stack, timestamp)
    VALUES
      (p_Module, v_SeqNum, v_ErrorStack, v_CallStack, SYSDATE);

    -- Unwind the error stack to get each error out.  We do this by
    -- scanning the error stack string.  Start with the index at the
    -- beginning of the string.
    v_Index := 1;
 
    -- Loop through the string, finding each newline.  A newline ends
    -- each error on the stack.
    WHILE v_Index <  LENGTH(v_ErrorStack) LOOP
      -- v_End is the position of the newline.
      v_End := INSTR(v_ErrorStack, v_NewLine, v_Index);

      -- Thus, the error is between the current index and the
      -- newline.
      v_Error := SUBSTR(v_ErrorStack, v_Index, v_End - v_Index);

      -- Skip over the current error, for the next iteration.
      v_Index := v_Index + LENGTH(v_Error) + 1;

      -- An error looks like 'facility-number: mesg'.  We need to get
      -- each piece out for insertion.

      -- First, the facility is the first 3 characters of the error.
      v_Facility := SUBSTR(v_Error, 1, 3); 

      -- Remove the facility and the dash (always 4 characters).
      v_Error := SUBSTR(v_Error, 5);

      -- Now we can get the error number.
      v_ErrNum :=
        TO_NUMBER(SUBSTR(v_Error, 1, INSTR(v_Error, ':') - 1));

      -- Remove the error number, colon and space (always 7
      -- characters).
      v_Error := SUBSTR(v_Error, 8);

      -- What's left is the error message.
      v_ErrMsg := v_Error;

      -- Insert the errors, and grab the first error number and
      -- message while we're at it.
      INSERT INTO error_stacks
        (module, seq_number, error_order, facility, error_number,
         error_mesg)
      VALUES
        (p_Module, p_SeqNum, v_ErrorOrder, v_Facility, v_ErrNum, v_ErrMsg);

      IF v_ErrorOrder = 1 THEN
        v_FirstErrNum := v_ErrNum;
        v_FirstErrMsg := v_Facility || '-' || TO_NUMBER(v_ErrNum) ||
                         ': ' || v_ErrMsg;
      END IF;

      v_ErrorOrder := v_ErrorOrder + 1;
    END LOOP;
 
    -- Update the errors table with the message and code.
    UPDATE errors
      SET error_number = v_FirstErrNum,
          error_mesg = v_FirstErrMsg
      WHERE module = p_Module
      AND seq_number = v_SeqNum;

    -- Now we need to unwind the call stack, to get each call out.
    -- We do this by scanning the call stack string.  Start with the
    -- index after the first call on the stack.  This will be after
    -- the first occurrence of 'name' and the newline.
    v_Index := INSTR(v_CallStack, 'name') + 5;

    -- Loop through the string, finding each newline.  A newline ends
    -- each call on the stack.
    WHILE v_Index <  LENGTH(v_CallStack) LOOP
      -- v_End is the position of the newline.
      v_End := INSTR(v_CallStack, v_NewLine, v_Index);

      -- Thus, the call is between the current index and the newline.
      v_Call := SUBSTR(v_CallStack, v_Index, v_End - v_Index);

      -- Skip over the current call, for the next iteration.
      v_Index := v_Index + LENGTH(v_Call) + 1;

      -- Within a call, we have the object handle, then the line
      -- number, then the object name, separated by spaces.  We need
      -- to separate them out for insertion.

      -- Trim white space from the call first.
      v_Call := LTRIM(v_Call);

      -- First get the object handle.
      v_Handle := SUBSTR(v_Call, 1, INSTR(v_Call, ' '));

      -- Now, remove the object handle, then the white space from
      -- the call.
      v_Call := SUBSTR(v_Call, LENGTH(v_Handle) + 1);
      v_Call := LTRIM(v_Call);

      -- Now we can get the line number.
      v_LineNum := TO_NUMBER(SUBSTR(v_Call, 1, INSTR(v_Call, ' ')));

      -- Remove the line number, and white space.
      v_Call := SUBSTR(v_Call, LENGTH(v_LineNum) + 1);
      v_Call := LTRIM(v_Call);

      -- What is left is the object name.
      v_ObjectName := v_Call;

      -- Insert all calls except the call for ErrorPkg.
      IF v_CallOrder > 1 THEN
        INSERT INTO call_stacks
          (module, seq_number, call_order, object_handle, line_num, 
           object_name)
        VALUES
          (p_Module, v_SeqNum, v_CallOrder, v_Handle, v_LineNum, 
           v_ObjectName);
      END IF;

      v_Callorder := v_CallOrder + 1;

    END LOOP;

    IF p_CommitFlag THEN 
      COMMIT;
    END IF;
  END StoreStacks;

END ErrorPkg;
/
show errors


CREATE OR REPLACE TRIGGER temp_insert
  BEFORE INSERT ON temp_table
BEGIN
  RAISE ZERO_DIVIDE;
END ttt_insert;
/

CREATE OR REPLACE PROCEDURE C AS
BEGIN
  INSERT INTO temp_table (num_col) VALUES (7);
EXCEPTION
  WHEN OTHERS THEN
    ErrorPkg.HandleAll(FALSE);
    RAISE;
END C;
/

CREATE OR REPLACE PROCEDURE B AS
BEGIN
  C;
EXCEPTION
  WHEN OTHERS THEN
    ErrorPkg.HandleAll(FALSE);
    RAISE;
END B;
/

CREATE OR REPLACE PROCEDURE A AS
  v_ErrorSeq NUMBER;
BEGIN
  B;
EXCEPTION
  WHEN OTHERS THEN
    ErrorPkg.HandleAll(TRUE);
    ErrorPkg.StoreStacks('Error Test', v_ErrorSeq, TRUE);
    ErrorPkg.PrintStacks('Error Test', v_ErrorSeq);
END A;
/


SET SERVEROUTPUT ON SIZE 1000000 FORMAT TRUNCATED
exec A;
