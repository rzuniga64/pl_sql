REM ClassInfo.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This function demonstrates the use of the RETURN statement.

CREATE OR REPLACE FUNCTION ClassInfo(
  /* Returns 'Full' if the class is completely full,
     'Some Room' if the class is over 80% full,
     'More Room' if the class is over 60% full,
     'Lots of Room' if the class is less than 60% full, and
     'Empty' if there are no students registered. */
  p_Department classes.department%TYPE,
  p_Course     classes.course%TYPE)
  RETURN VARCHAR2 IS

  v_CurrentStudents NUMBER;
  v_MaxStudents     NUMBER;
  v_PercentFull     NUMBER;
BEGIN
  -- Get the current and maximum students for the requested
  -- course.
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM classes
    WHERE department = p_Department
    AND course = p_Course;

  -- Calculate the current percentage.
  v_PercentFull := v_CurrentStudents / v_MaxStudents * 100;

  IF v_PercentFull = 100 THEN
    RETURN 'Full';
  ELSIF v_PercentFull > 80 THEN
    RETURN 'Some Room';
  ELSIF v_PercentFull > 60 THEN
    RETURN 'More Room';
  ELSIF v_PercentFull > 0 THEN
    RETURN 'Lots of Room';
  ELSE
    RETURN 'Empty';
  END IF;
END ClassInfo;
/
