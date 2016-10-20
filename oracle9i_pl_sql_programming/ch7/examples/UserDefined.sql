REM UserDefined.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This example illustrates user defined exceptions.

-- This block may raise the exception, but does not handle it.
DECLARE
  -- Exception to indicate an error condition
  e_TooManyStudents EXCEPTION;

  -- Current number of students registered for HIS-101
  v_CurrentStudents NUMBER(3);

  -- Maximum number of students allowed in HIS-101
  v_MaxStudents NUMBER(3);
BEGIN
  /* Find the current number of registered students, and the maximum
     number of students allowed. */
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM classes
    WHERE department = 'HIS' AND course = 101;

  /* Check the number of students in this class. */
  IF v_CurrentStudents > v_MaxStudents THEN
    /* Too many students registered -- raise exception. */
    RAISE e_TooManyStudents;
  END IF;
END;
/

-- This block adds an exception handler for e_TooManyStudents.
DECLARE
  -- Exception to indicate an error condition
  e_TooManyStudents EXCEPTION;

  -- Current number of students registered for HIS-101
  v_CurrentStudents NUMBER(3);

  -- Maximum number of students allowed in HIS-101
  v_MaxStudents NUMBER(3);
BEGIN
  /* Find the current number of registered students, and the maximum
     number of students allowed. */
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM classes
    WHERE department = 'HIS' AND course = 101;

  /* Check the number of students in this class. */
  IF v_CurrentStudents > v_MaxStudents THEN
    /* Too many students registered -- raise exception. */
    RAISE e_TooManyStudents;
  END IF;
EXCEPTION
  WHEN e_TooManyStudents THEN
    /* Handler which executes when there are too many students
       registered for HIS-101. We will insert a log message
       explaining what has happened. */
    INSERT INTO log_table (info)
      VALUES ('History 101 has ' || v_CurrentStudents ||
              'students: max allowed is ' || v_MaxStudents);
END;
/

-- This block adds a WHEN OTHERS handler to catch all runtime
-- exceptions.
DECLARE
  -- Exception to indicate an error condition
  e_TooManyStudents EXCEPTION;

  -- Current number of students registered for HIS-101
  v_CurrentStudents NUMBER(3);

  -- Maximum number of students allowed in HIS-101
  v_MaxStudents NUMBER(3);
BEGIN
  /* Find the current number of registered students, and the maximum
     number of students allowed. */
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM classes
    WHERE department = 'HIS' AND course = 101;

  /* Check the number of students in this class. */
  IF v_CurrentStudents > v_MaxStudents THEN
    /* Too many students registered -- raise exception. */
    RAISE e_TooManyStudents;
  END IF;
EXCEPTION
  WHEN e_TooManyStudents THEN
    /* Handler which executes when there are too many students
       registered for HIS-101. We will insert a log message
       explaining what has happened. */
    INSERT INTO log_table (info)
      VALUES ('History 101 has ' || v_CurrentStudents ||
              'students: max allowed is ' || v_MaxStudents);
  WHEN OTHERS THEN
    /* Handler which executes for all other errors. */
    INSERT INTO log_table (info) VALUES ('Another error occurred');
END;
/


-- This block contains a WHEN OTHERS handler that records which
-- runtime error occurred.
DECLARE
  -- Exception to indicate an error condition
  e_TooManyStudents EXCEPTION;

  -- Current number of students registered for HIS-101
  v_CurrentStudents NUMBER(3);

  -- Maximum number of students allowed in HIS-101
  v_MaxStudents NUMBER(3);

  -- Code and text of other runtime errors
  v_ErrorCode log_table.code%TYPE;
  v_ErrorText log_table.message%TYPE;
BEGIN
  /* Find the current number of registered students, and the maximum
     number of students allowed. */
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM classes
    WHERE department = 'HIS' AND course = 101;

  /* Check the number of students in this class. */
  IF v_CurrentStudents > v_MaxStudents THEN
    /* Too many students registered -- raise exception. */
    RAISE e_TooManyStudents;
  END IF;
EXCEPTION
  WHEN e_TooManyStudents THEN
    /* Handler which executes when there are too many students
       registered for HIS-101. We will insert a log message
       explaining what has happened. */
    INSERT INTO log_table (info)
      VALUES ('History 101 has ' || v_CurrentStudents ||
              'students: max allowed is ' || v_MaxStudents);
  WHEN OTHERS THEN
    /* Handler which executes for all other errors. */
    v_ErrorCode := SQLCODE;
    -- Note the use of SUBSTR here.
    v_ErrorText := SUBSTR(SQLERRM, 1, 200);
    INSERT INTO log_table (code, message, info) VALUES
      (v_ErrorCode, v_ErrorText, 'Oracle error occurred');
END;
/
