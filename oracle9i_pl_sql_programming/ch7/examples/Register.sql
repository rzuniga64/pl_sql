REM Register.sql
REM Chapter 7, Oracle9i PL/SQL Programming by Scott Urman
REM This procedure illustrates the use of RAISE_APPLICATION_ERROR.

/* Registers the student identified by the p_StudentID parameter in
   the class identified by the p_Department and p_Course
   parameters. */
CREATE OR REPLACE PROCEDURE Register (
  p_StudentID IN students.id%TYPE,
  p_Department IN classes.department%TYPE,
  p_Course IN classes.course%TYPE) AS

  v_CurrentStudents classes.current_students%TYPE;
  v_MaxStudents classes.max_students%TYPE;
  v_NumCredits classes.num_credits%TYPE;
  v_Count NUMBER;                             

BEGIN
  /* Determine the current number of students registered, and the
     maximum number of students allowed to register. */
  BEGIN
    SELECT current_students, max_students, num_credits
      INTO v_CurrentStudents, v_MaxStudents, v_NumCredits
      FROM classes
      WHERE course = p_Course
      AND department = p_Department;

    /* Make sure there is enough room for this additional student. */
    IF v_CurrentStudents + 1 > v_MaxStudents THEN
      RAISE_APPLICATION_ERROR(-20000,
        'Can''t add more students to ' || p_Department || ' ' || p_Course);
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      /* Class information passed to this procedure doesn't exist. */
      RAISE_APPLICATION_ERROR(-20001,
        p_Department || ' ' || p_Course || ' doesn''t exist');
  END;
    
  /* Ensure that the student is not currently registered */
  SELECT COUNT(*)
    INTO v_Count
    FROM registered_students
    WHERE student_id = p_StudentID
    AND department = p_Department
    AND course = p_Course;
  IF v_Count = 1 THEN
    RAISE_APPLICATION_ERROR(-20002,
      'Student ' || p_StudentID || ' is already registered for ' ||
      p_Department || ' ' || p_Course);
  END IF;
  
  /* There is enough room, and the student is not already in the
     class.  Update the necessary tables. */
  INSERT INTO registered_students (student_id, department, course)
    VALUES (p_StudentID, p_Department, p_Course);
  UPDATE students
    SET current_credits = current_credits + v_NumCredits
    WHERE ID = p_StudentID;
  UPDATE classes
    SET current_students = current_students + 1
    WHERE course = p_Course
    AND department = p_Department;
END Register;
/
show errors

-- Illustrate the ORA-2001 and ORA-2002 errors
exec Register(10000, 'CS', 999);
exec Register(10000, 'CS', 102);

-- Register 2 students for MUS 410, which will raise ORA-2003
exec Register(10002, 'MUS', 410);
exec Register(10005, 'MUS', 410);

BEGIN
  RAISE NO_DATA_FOUND;
END;
/
