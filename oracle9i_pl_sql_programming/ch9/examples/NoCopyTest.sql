REM NoCopyTest.sql
REM Chapter 9, Oracle8i Advanced PL/SQL Programming
REM This procedure illustrates the behavior of the Oracle8i
REM NOCOPY modifier.

CREATE OR REPLACE PROCEDURE NoCopyTest (
  p_InParameter    IN NUMBER,
  p_OutParameter   OUT NOCOPY VARCHAR2,
  p_InOutParameter IN OUT NOCOPY CHAR) IS
BEGIN
  NULL;
END NoCopyTest;
/

-- RaiseError with NOCOPY
/* Illustrates the behavior of unhandled exceptions and
 * OUT variables. If p_Raise is TRUE, then an unhandled
 * error is raised. If p_Raise is FALSE, the procedure
 * completes successfully.
 */
CREATE OR REPLACE PROCEDURE RaiseError (
  p_Raise IN BOOLEAN,
  p_ParameterA OUT NOCOPY NUMBER) AS
BEGIN
  p_ParameterA := 7;
  IF p_Raise THEN
    RAISE DUP_VAL_ON_INDEX;
  ELSE
    RETURN;
  END IF;
END RaiseError;
/

set serveroutput on

DECLARE
  v_TempVar NUMBER := 1;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Initial value: ' || v_TempVar);
  RaiseError(FALSE, v_TempVar);
  DBMS_OUTPUT.PUT_LINE('Value after successful call: ' ||
                       v_TempVar);

  v_TempVar := 2;
  DBMS_OUTPUT.PUT_LINE('Value before 2nd call: ' || v_TempVar);
  RaiseError(TRUE, v_TempVar);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Value after unsuccessful call: ' ||
                         v_TempVar);
END;
/
