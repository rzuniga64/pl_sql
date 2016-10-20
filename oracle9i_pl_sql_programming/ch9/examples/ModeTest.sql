REM ModeTest.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This procedure illustrates different parameter modes and
REM assignments to the parameters.

CREATE OR REPLACE PROCEDURE ModeTest (
  p_InParameter    IN NUMBER,
  p_OutParameter   OUT NUMBER,
  p_InOutParameter IN OUT NUMBER) IS

  v_LocalVariable  NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Inside ModeTest:');
  IF (p_InParameter IS NULL) THEN
    DBMS_OUTPUT.PUT('p_InParameter is NULL');
  ELSE
    DBMS_OUTPUT.PUT('p_InParameter = ' || p_InParameter);
  END IF;

  IF (p_OutParameter IS NULL) THEN
    DBMS_OUTPUT.PUT('  p_OutParameter is NULL');
  ELSE
    DBMS_OUTPUT.PUT('  p_OutParameter = ' || p_OutParameter);
  END IF;

  IF (p_InOutParameter IS NULL) THEN
    DBMS_OUTPUT.PUT_LINE('  p_InOutParameter is NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('  p_InOutParameter = ' ||
                         p_InOutParameter);
  END IF;

  /* Assign p_InParameter to v_LocalVariable. This is legal,
     since we are reading from an IN parameter and not writing
     to it. */
  v_LocalVariable := p_InParameter;  -- Legal

  /* Assign 7 to p_InParameter. This is ILLEGAL, since we
     are writing to an IN parameter. */
  -- p_InParameter := 7;  -- Illegal

  /* Assign 7 to p_OutParameter. This is legal, since we
     are writing to an OUT parameter. */
  p_OutParameter := 7;  -- Legal

  /* Assign p_OutParameter to v_LocalVariable. In Oracle7 version
     7.3.4, and Oracle8 version 8.0.4 or higher (including 8i),
     this is legal.  Prior to 7.3.4, it is illegal to read from an
     OUT parameter. */
  v_LocalVariable := p_OutParameter;  -- Possibly illegal

  /* Assign p_InOutParameter to v_LocalVariable. This is legal,
     since we are reading from an IN OUT parameter. */
  v_LocalVariable := p_InOutParameter;  -- Legal

  /* Assign 8 to p_InOutParameter. This is legal, since we
     are writing to an IN OUT parameter. */
  p_InOutParameter := 8;  -- Legal

  DBMS_OUTPUT.PUT_LINE('At end of ModeTest:');
  IF (p_InParameter IS NULL) THEN
    DBMS_OUTPUT.PUT('p_InParameter is NULL');
  ELSE
    DBMS_OUTPUT.PUT('p_InParameter = ' || p_InParameter);
  END IF;

  IF (p_OutParameter IS NULL) THEN
    DBMS_OUTPUT.PUT('  p_OutParameter is NULL');
  ELSE
    DBMS_OUTPUT.PUT('  p_OutParameter = ' || p_OutParameter);
  END IF;

  IF (p_InOutParameter IS NULL) THEN
    DBMS_OUTPUT.PUT_LINE('  p_InOutParameter is NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('  p_InOutParameter = ' ||
                         p_InOutParameter);
  END IF;

END ModeTest;
/
