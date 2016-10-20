REM CursorLoop.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates an explicit cursor fetch loop.

DECLARE
  /* Output variables to hold the results of the query */
  v_StudentID    students.id%TYPE;
  v_FirstName    students.first_name%TYPE;
  v_LastName     students.last_name%TYPE;

  /* Bind variable used in the query */
  v_Major        students.major%TYPE := 'Computer Science';

  /* Cursor declaration */
  CURSOR c_Students IS
    SELECT id, first_name, last_name
      FROM students
      WHERE major = v_Major;
BEGIN 
  /* Identify the rows in the active set, and prepare for further
     processing of the data */
  OPEN c_Students;
  LOOP
    /* Retrieve each row of the active set into PL/SQL variables */
    FETCH c_Students INTO v_StudentID, v_FirstName, v_LastName;

    /* If there are no more rows to fetch, exit the loop */
    EXIT WHEN c_Students%NOTFOUND;
  END LOOP;

  /* Free resources used by the query */
  CLOSE c_Students;
END; 
/
