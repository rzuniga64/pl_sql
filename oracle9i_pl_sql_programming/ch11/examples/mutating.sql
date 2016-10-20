REM mutating.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This script shows how to avoid the mutating table error.

PROMPT StudentData package...
CREATE OR REPLACE PACKAGE StudentData AS
  TYPE t_Majors IS TABLE OF students.major%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE t_IDs IS TABLE OF students.ID%TYPE
    INDEX BY BINARY_INTEGER;

  v_StudentMajors t_Majors;
  v_StudentIDs    t_IDs;
  v_NumEntries    BINARY_INTEGER := 0;
END StudentData;
/

PROMPT RLimitMajors trigger...
CREATE OR REPLACE TRIGGER RLimitMajors
  BEFORE INSERT OR UPDATE OF major ON students
  FOR EACH ROW
BEGIN
  /* Record the new data in StudentData. We don't make any
     changes to students, to avoid the ORA-4091 error. */
  StudentData.v_NumEntries := StudentData.v_NumEntries + 1;
  StudentData.v_StudentMajors(StudentData.v_NumEntries) :=
    :new.major;
  StudentData.v_StudentIDs(StudentData.v_NumEntries) := :new.id;
END RLimitMajors;
/

PROMPT SLimitMajors trigger...
CREATE OR REPLACE TRIGGER SLimitMajors
  AFTER INSERT OR UPDATE OF major ON students
DECLARE
  v_MaxStudents     CONSTANT NUMBER := 5;
  v_CurrentStudents NUMBER;
  v_StudentID       students.ID%TYPE;
  v_Major           students.major%TYPE;
BEGIN
  /* Loop through each student inserted or updated, and verify
     that we are still within the limit. */
  FOR v_LoopIndex IN 1..StudentData.v_NumEntries LOOP
    v_StudentID := StudentData.v_StudentIDs(v_LoopIndex);
    v_Major := StudentData.v_StudentMajors(v_LoopIndex);

    -- Determine the current number of students in this major.
    SELECT COUNT(*)
      INTO v_CurrentStudents
      FROM students
      WHERE major = v_Major;

    -- If there isn't room, raise an error.
    IF v_CurrentStudents > v_MaxStudents THEN
      RAISE_APPLICATION_ERROR(-20000,
        'Too many students for major ' || v_Major ||
        ' because of student ' || v_StudentID);
    END IF;
  END LOOP;

  -- Reset the counter so the next execution will use new data.
  StudentData.v_NumEntries := 0;
END SLimitMajors;
/

UPDATE students
  SET major = 'History'
  WHERE ID = 10003;

UPDATE students
  SET major = 'History'
  WHERE ID = 10002;

UPDATE students
  SET major = 'History'
  WHERE ID = 10009;
