REM BindVariable.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the use of a bind variable.

DECLARE
  v_NumCredits  classes.num_credits%TYPE;
BEGIN
  /* Assign to v_NumCredits */
  v_NumCredits := 3;
  UPDATE CLASSES
    SET num_credits = v_NumCredits
    WHERE department = 'HIS'
    AND course = 101;
END;
/
