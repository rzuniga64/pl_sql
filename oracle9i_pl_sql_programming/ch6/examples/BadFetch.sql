REM BadFetch.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates legal and illegal FETCH statements.

DECLARE
  v_Department  classes.department%TYPE;
  v_Course      classes.course%TYPE;
  CURSOR c_AllClasses IS
    SELECT *
      FROM classes;
  v_ClassesRecord  c_AllClasses%ROWTYPE;
BEGIN
  OPEN c_AllClasses;

  -- This is a legal FETCH statement, returning the first
  -- row into a PL/SQL record which matches the select list
  -- of the query.
  FETCH c_AllClasses INTO v_ClassesRecord;

  -- This FETCH statement is illegal, since the select list
  -- of the query returns all 7 columns in the classes table
  -- but we are only fetching into 2 variables.
  -- This will raise the error "PLS-394: wrong number of values
  -- in the INTO list of a FETCH statement".
  FETCH c_AllClasses INTO v_Department, v_Course;
END;
/
