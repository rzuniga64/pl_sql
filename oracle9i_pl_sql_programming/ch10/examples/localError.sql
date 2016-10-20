REM localError.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates an illegal location for a subprogram.

DECLARE
  /* Declare FormatName first. This will generate a compile
     error, since all other declarations have to be before
     any local subprograms. */
  FUNCTION FormatName(p_FirstName IN VARCHAR2,
                      p_LastName IN VARCHAR2)
    RETURN VARCHAR2 IS
  BEGIN
    RETURN p_FirstName || ' ' || p_LastName;
  END FormatName;

  CURSOR c_AllStudents IS
    SELECT first_name, last_name
      FROM students;

  v_FormattedName VARCHAR2(50);
-- Begin main block
BEGIN
  NULL;
END;
/
