REM NativeDynamic.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates the use of native dynamic SQL to 
REM process queries.

CREATE OR REPLACE PACKAGE NativeDynamic AS
  TYPE t_RefCur IS REF CURSOR;

  -- Selects from students using the supplied WHERE clause,
  -- and returns the opened cursor variable.
  FUNCTION StudentsQuery(p_WhereClause IN VARCHAR2)
    RETURN t_RefCur;

  -- Selects from students based on the supplied major,
  -- and returns the opened cursor variable.
  FUNCTION StudentsQuery2(p_Major IN VARCHAR2)
    RETURN t_RefCur;
END NativeDynamic;
/
show errors

CREATE OR REPLACE PACKAGE BODY NativeDynamic AS
  -- Selects from students using the supplied WHERE clause,
  -- and returns the opened cursor variable.
  FUNCTION StudentsQuery(p_WhereClause IN VARCHAR2)
    RETURN t_RefCur IS
    v_ReturnCursor t_RefCur;
    v_SQLStatement VARCHAR2(500);
  BEGIN
    -- Build the query using the supplied WHERE clause
    v_SQLStatement := 'SELECT * FROM students ' || p_WhereClause;

    -- Open the cursor variable, and return it.
    OPEN v_ReturnCursor FOR v_SQLStatement;
    RETURN v_ReturnCursor;
  END StudentsQuery;

  -- Selects from students based on the supplied major,
  -- and returns the opened cursor variable.
  FUNCTION StudentsQuery2(p_Major IN VARCHAR2)
    RETURN t_RefCur IS
    v_ReturnCursor t_RefCur;
    v_SQLStatement VARCHAR2(500);
  BEGIN
    v_SQLStatement := 'SELECT * FROM students WHERE major = :m';

    -- Open the cursor variable, and return it.
    OPEN v_ReturnCursor FOR v_SQLStatement USING p_Major;
    RETURN v_ReturnCursor;
  END StudentsQuery2;
END NativeDynamic;
/
show errors

set serveroutput on format wrapped

DECLARE
  v_Student students%ROWTYPE;
  v_StudentCur NativeDynamic.t_RefCur;
BEGIN
  -- Call StudentsQuery to open the cursor for students with
  -- even IDs.
  v_StudentCur :=
    NativeDynamic.StudentsQuery('WHERE MOD(id, 2) = 0');

  -- Loop through the opened cursor, and print out the results.
  DBMS_OUTPUT.PUT_LINE('The following students have even IDs:');
  LOOP
    FETCH v_StudentCur INTO v_Student;
    EXIT WHEN v_StudentCur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('  ' || v_Student.id || ': ' ||
                         v_Student.first_name || ' ' ||
                         v_Student.last_name);
  END LOOP;
  CLOSE v_StudentCur;

  -- Call StudentsQuery2 to open the cursor for music majors.
  v_StudentCur :=
    NativeDynamic.StudentsQuery2('Music');

  -- Loop through the opened cursor, and print out the results.
  DBMS_OUTPUT.PUT_LINE(
    'The following students are music majors:');
  LOOP
    FETCH v_StudentCur INTO v_Student;
    EXIT WHEN v_StudentCur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('  ' || v_Student.id || ': ' ||
                         v_Student.first_name || ' ' ||
                         v_Student.last_name);
  END LOOP;
  CLOSE v_StudentCur;
END;
/

-- This block illustrates the use of EXECUTE IMMEDIATE for
-- single-row queries.
DECLARE
  v_SQLQuery VARCHAR2(200);
  v_Class classes%ROWTYPE;
  v_Description classes.description%TYPE;
BEGIN
  -- First select into a single variable.
  v_SQLQuery :=
    'SELECT description ' ||
    '  FROM classes ' ||
    '  WHERE department = ''ECN''' ||
    '  AND course = 203';

  EXECUTE IMMEDIATE v_SQLQuery
    INTO v_Description;

  DBMS_OUTPUT.PUT_LINE('Fetched ' || v_Description);

  -- Now select into a record, using a bind variable.
  v_SQLQuery :=
    'SELECT * ' ||
    '  FROM classes ' ||
    '  WHERE description = :description';
  EXECUTE IMMEDIATE v_SQLQuery
    INTO v_Class
    USING v_Description;

  DBMS_OUTPUT.PUT_LINE(
    'Fetched ' || v_Class.department || ' ' || v_Class.course);

  -- Fetch more than one row, which will raise ORA-1422.
  v_SQLQuery := 'SELECT * FROM classes';
  EXECUTE IMMEDIATE v_SQLQuery
    INTO v_Class;
END;
/
