REM GenerateStudentID.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM These triggers demonstrate the use of the :new correlation
REM identifier.

/* This will fail, since we don't specify the primary key */
INSERT INTO students (first_name, last_name)
  VALUES ('Lolita', 'Lazarus');

CREATE OR REPLACE TRIGGER GenerateStudentID
  BEFORE INSERT OR UPDATE ON students
  FOR EACH ROW
BEGIN
  /* Fill in the ID field of students with the next value from
     student_sequence. Since ID is a column in students, :new.ID
     is a valid reference. */
  SELECT student_sequence.NEXTVAL
    INTO :new.ID
    FROM dual;
END GenerateStudentID;
/

/* Now it will succeed. */
INSERT INTO students (first_name, last_name)
  VALUES ('Lolita', 'Lazarus');

/* So will this. */
INSERT INTO students (ID, first_name, last_name)
  VALUES (-7, 'Zelda', 'Zoom');

/* This version uses the REFERENCING clause to rename :new to
   :new_student. */
CREATE OR REPLACE TRIGGER GenerateStudentID
  BEFORE INSERT OR UPDATE ON students
  REFERENCING new AS new_student
  FOR EACH ROW
BEGIN
  /* Fill in the ID field of students with the next value from
     student_sequence. Since ID is a column in students,
     :new_student.ID is a valid reference. */
  SELECT student_sequence.nextval
    INTO :new_student.ID
    FROM dual;
END GenerateStudentID;
/
