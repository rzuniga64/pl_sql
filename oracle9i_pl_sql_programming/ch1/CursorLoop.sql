REM CursorLoop.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a cursor fetch loop.

DECLARE
  v_FirstName VARCHAR2(20);
  v_LastName  VARCHAR2(20);
  -- Cursor declaration.  This defines the SQL statement to
  -- return the rows.
  CURSOR c_Students IS
    SELECT first_name, last_name
      FROM students;
BEGIN
  -- Begin cursor processing.
  OPEN c_Students;
  LOOP
    -- Retrieve one row.
    FETCH c_Students INTO v_FirstName, v_LastName;
    -- Exit the loop after all rows have been retrieved.
    EXIT WHEN c_Students%NOTFOUND;
    /* Process data here */
  END LOOP;
  -- End processing.
  CLOSE c_Students;
END;
/
