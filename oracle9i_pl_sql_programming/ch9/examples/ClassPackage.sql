REM ClassPackage.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This is an example of a package.

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
  -- Add a new student for the specified class.
  PROCEDURE AddStudent(p_StudentID  IN students.id%TYPE,
                       p_Department IN classes.department%TYPE,
                       p_Course     IN classes.course%TYPE) IS
  BEGIN
    INSERT INTO registered_students (student_id, department, course)
      VALUES (p_StudentID, p_Department, p_Course);
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
