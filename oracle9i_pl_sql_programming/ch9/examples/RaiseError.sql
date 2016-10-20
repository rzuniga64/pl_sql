REM RaiseError.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This procedure illustrates the behavior of unhandled exceptions
REM and OUT variables.

/* Illustrates the behavior of unhandled exceptions and
 * OUT variables. If p_Raise is TRUE, then an unhandled
 * error is raised. If p_Raise is FALSE, the procedure
 * completes successfully.
 */
CREATE OR REPLACE PROCEDURE RaiseError (
  p_Raise IN BOOLEAN,
  p_ParameterA OUT NUMBER) AS
BEGIN
  p_ParameterA := 7;

  IF p_Raise THEN
    /* Even though we have assigned 7 to p_ParameterA, this
     * unhandled exception causes control to return immediately
     * without returning 7 to the actual parameter associated
     * with p_ParameterA.
     */
    RAISE DUP_VAL_ON_INDEX;
  ELSE
    -- Simply return with no error. This will return 7 to the
    -- actual parameter.
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
