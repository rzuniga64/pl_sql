REM Parameterized.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates the declaration of a parameterized cursor.

DECLARE
  CURSOR c_Classes(p_Department classes.department%TYPE,
                   p_Course classes.course%TYPE) IS
  SELECT *
    FROM classes
    WHERE department = p_Department
    AND course = p_Course;
BEGIN
  OPEN c_Classes('HIS', 101);
END;
/
