REM select.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This block contains examples of 2 SELECT statements.

DECLARE
  v_StudentRecord  students%ROWTYPE;
  v_Department     classes.department%TYPE;
  v_Course         classes.course%TYPE;
BEGIN
  -- Retrieve one record from the students table, and store it
  -- in v_StudentRecord. Note that the WHERE clause will only
  -- match one row in the table.
  -- Note also that the query is returning all of the fields in
  -- the students table (since we are selecting *). Thus the
  -- record into which we fetch is defined as students%ROWTYPE.
  SELECT *
    INTO v_StudentRecord
    FROM students
    WHERE id = 10000;

  -- Retrieve two fields from the classes table, and store them
  -- in v_Department and v_Course. Again, the WHERE clause will
  -- only match one row in the table.
  SELECT department, course
    INTO v_Department, v_Course
    FROM classes
    WHERE room_id = 20003;
END;
/
