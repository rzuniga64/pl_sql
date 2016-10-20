REM ClassPackage2.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This package contains an extra procedure in the package body.

CREATE OR REPLACE PACKAGE ClassPackage AS
  -- Add a new student into the specified class.
  PROCEDURE AddStudent(p_StudentID  IN students.id%TYPE,
                       p_Department IN classes.department%TYPE,
                       p_Course     IN classes.course%TYPE);

  -- Removes the specified student from the specified class.
  PROCEDURE RemoveStudent(p_StudentID  IN students.id%TYPE,
                          p_Department IN classes.department%TYPE,
                          p_Course     IN classes.course%TYPE);

  -- Exception raised by RemoveStudent.
  e_StudentNotRegistered EXCEPTION;

  -- Table type used to hold student info.
  TYPE t_StudentIDTable IS TABLE OF students.id%TYPE
    INDEX BY BINARY_INTEGER;

  -- Returns a PL/SQL table containing the students currently
  -- in the specified class.
  PROCEDURE ClassList(p_Department  IN  classes.department%TYPE,
                      p_Course      IN  classes.course%TYPE,
                      p_IDs         OUT t_StudentIDTable,
                      p_NumStudents IN OUT BINARY_INTEGER);
END ClassPackage;
/
show errors

CREATE OR REPLACE PACKAGE BODY ClassPackage AS
  -- Utility procedure that updates students and classes to reflect
  -- the change.  If p_Add is TRUE, then the tables are updated for
  -- the addition of the student to the class.  If it is FALSE,
  -- then they are updated for the removal of the student.
  PROCEDURE UpdateStudentsAndClasses(
    p_Add       IN BOOLEAN,
    p_StudentID IN students.id%TYPE,
    p_Department IN classes.department%TYPE,
    p_Course     IN classes.course%TYPE) IS

    -- Number of credits for the requested class
    v_NumCredits  classes.num_credits%TYPE;
  BEGIN
    -- First determine NumCredits.
    SELECT num_credits
      INTO v_NumCredits
      FROM classes
      WHERE department = p_Department
      AND course = p_Course;

    IF (p_Add) THEN
      -- Add NumCredits to the student's course load
      UPDATE STUDENTS
        SET current_credits = current_credits + v_NumCredits
        WHERE ID = p_StudentID;

      -- And increase current_students
      UPDATE classes
        SET current_students = current_students + 1
        WHERE department = p_Department
        AND course = p_Course;
     ELSE
       -- Remove NumCredits from the students course load
       UPDATE STUDENTS
         SET current_credits = current_credits - v_NumCredits
         WHERE ID = p_StudentID;

       -- And decrease current_students
       UPDATE classes
         SET current_students = current_students - 1
         WHERE department = p_Department
         AND course = p_Course;
     END IF;
  END UpdateStudentsAndClasses;

  -- Add a new student for the specified class.
  PROCEDURE AddStudent(p_StudentID  IN students.id%TYPE,
                       p_Department IN classes.department%TYPE,
                       p_Course     IN classes.course%TYPE) IS
  BEGIN
    INSERT INTO registered_students (student_id, department, course)
      VALUES (p_StudentID, p_Department, p_Course);

    UpdateStudentsAndClasses(TRUE, p_StudentID, p_Department,
                                   p_Course);
  END AddStudent;

  -- Removes the specified student from the specified class.
  PROCEDURE RemoveStudent(p_StudentID  IN students.id%TYPE,
                          p_Department IN classes.department%TYPE,
                          p_Course     IN classes.course%TYPE) IS
  BEGIN
    DELETE FROM registered_students
      WHERE student_id = p_StudentID
      AND department = p_Department
      AND course = p_Course;

    -- Check to see if the DELETE operation was successful. If
    -- it didn't match any rows, raise an error.
    IF SQL%NOTFOUND THEN
      RAISE e_StudentNotRegistered;
    END IF;

    UpdateStudentsAndClasses(FALSE, p_StudentID, p_Department,
                                   p_Course);

  END RemoveStudent;

  -- Returns a PL/SQL table containing the students currently
  -- in the specified class.
  PROCEDURE ClassList(p_Department  IN  classes.department%TYPE,
                      p_Course      IN  classes.course%TYPE,
                      p_IDs         OUT t_StudentIDTable,
                      p_NumStudents IN OUT BINARY_INTEGER) IS

    v_StudentID  registered_students.student_id%TYPE;

    -- Local cursor to fetch the registered students.
    CURSOR c_RegisteredStudents IS
      SELECT student_id
        FROM registered_students
        WHERE department = p_Department
        AND course = p_Course;
  BEGIN
    /* p_NumStudents will be the table index. It will start at
     * 0, and be incremented each time through the fetch loop.
     * At the end of the loop, it will have the number of rows
     * fetched, and therefore the number of rows returned in
     * p_IDs.
     */
    p_NumStudents := 0;

    OPEN c_RegisteredStudents;
    LOOP
      FETCH c_RegisteredStudents INTO v_StudentID;
      EXIT WHEN c_RegisteredStudents%NOTFOUND;

      p_NumStudents := p_NumStudents + 1;
      p_IDs(p_NumStudents) := v_StudentID;
    END LOOP;
  END ClassList;
END ClassPackage;
/
show errors
