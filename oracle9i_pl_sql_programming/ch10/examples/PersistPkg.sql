REM PersistPkg.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This package demonstrates the persistance of packaged variables.

CREATE OR REPLACE PACKAGE PersistPkg AS
  -- Type which holds an array of student ID's.
  TYPE t_StudentTable IS TABLE OF students.ID%TYPE
    INDEX BY BINARY_INTEGER;

  -- Maximum number of rows to return each time.
  v_MaxRows NUMBER := 5;

  -- Returns up to v_MaxRows student ID's.
  PROCEDURE ReadStudents(p_StudTable OUT t_StudentTable,
                         p_NumRows   OUT NUMBER);

END PersistPkg;
/

CREATE OR REPLACE PACKAGE BODY PersistPkg AS
  -- Query against students.  Since this is global to the package
  -- body, it will remain past a database call.
  CURSOR StudentCursor IS
    SELECT ID
      FROM students
      ORDER BY last_name;

  PROCEDURE ReadStudents(p_StudTable OUT t_StudentTable,
                         p_NumRows   OUT NUMBER) IS
    v_Done BOOLEAN := FALSE;
    v_NumRows NUMBER := 1;
  BEGIN
    IF NOT StudentCursor%ISOPEN THEN
      -- First open the cursor
      OPEN StudentCursor;
    END IF;

    -- Cursor is open, so we can fetch up to v_MaxRows
    WHILE NOT v_Done LOOP
      FETCH StudentCursor INTO p_StudTable(v_NumRows);
      IF StudentCursor%NOTFOUND THEN
        -- No more data, so we're finished.
        CLOSE StudentCursor;
        v_Done := TRUE;
      ELSE
        v_NumRows := v_NumRows + 1;
        IF v_NumRows > v_MaxRows THEN
          v_Done := TRUE;
        END IF;
      END IF;
    END LOOP;

    -- Return the actual number of rows fetched.
    p_NumRows := v_NumRows - 1;

  END ReadStudents;
END PersistPkg;
/
