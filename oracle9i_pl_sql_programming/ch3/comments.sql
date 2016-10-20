REM comments.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This example demonstrates legal and illegal comments.

DECLARE
  v_Department  CHAR(3);
  v_Course      NUMBER;
BEGIN
  INSERT INTO classes (department, course)
    VALUES (v_Department, v_Course);
END;
/

DECLARE
  v_Department  CHAR(3);  -- Variable to hold the 3 character
                          -- department code
  v_Course      NUMBER;   -- Variable to hold the course number
BEGIN
  -- Insert the course identified by v_Department and v_Course
  -- into the classes table in the database.
  INSERT INTO classes (department, course)
    VALUES (v_Department, v_Course);
END;
/


DECLARE
  v_Department  CHAR(3);  /* Variable to hold the 3 character
                             department name */
  v_Course      NUMBER;   /* Variable to hold the course number */
BEGIN
  /* Insert the course identified by v_Department and v_Course
     into the classes table in the database. */
  INSERT INTO classes (department, course)
    VALUES (v_Department, v_Course);
END;
/


BEGIN
  /* We are now inside a comment. If we were to begin another
     comment such as /* this */ it would be illegal. */
  NULL;
END;
/
