REM CascadeRSInserts.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This trigger cascades inserts into registered_students into
REM classes and students.

CREATE OR REPLACE TRIGGER CascadeRSInserts
  /* Keep the registered_students, students, and classes
     tables in synch when an INSERT is done to registered_students.
     */
  BEFORE INSERT ON registered_students
  FOR EACH ROW
DECLARE
  v_Credits classes.num_credits%TYPE;
BEGIN
  -- Determine the number of credits for this class.
  SELECT num_credits
    INTO v_Credits
    FROM classes
    WHERE department = :new.department
    AND course = :new.course;

  -- Modify the current credits for this student.
  UPDATE students
    SET current_credits = current_credits + v_Credits
    WHERE ID = :new.student_id;

  -- Add one to the number of students in the class.
  UPDATE classes
    SET current_students = current_students + 1
    WHERE department = :new.department
    AND course = :new.course;
END CascadeRSInserts;
/
