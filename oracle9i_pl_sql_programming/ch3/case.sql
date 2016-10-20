REM case.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates the CASE statement.

set serveroutput on

DECLARE
  v_Major students.major%TYPE;
  v_CourseName VARCHAR2(10);
BEGIN
  -- Retrieve the major for a given student
  SELECT major
    INTO v_Major
    FROM students
    WHERE ID = 10011;

  -- Based on the major, choose a course
  IF v_Major = 'Computer Science' THEN
    v_CourseName := 'CS  101';
  ELSIF v_Major = 'Economics' THEN
    v_CourseName := 'ECN 203';
  ELSIF v_Major = 'History' THEN
    v_CourseName := 'HIS 101';
  ELSIF v_Major = 'Music' THEN
    v_CourseName := 'MUS 100';
  ELSIF v_Major = 'Nutrition' THEN
    v_CourseName := 'NUT 307';
  ELSE
    v_CourseName := 'Unknown';
  END IF;
  DBMS_OUTPUT.PUT_LINE(v_CourseName);
END;
/


DECLARE
  v_Major students.major%TYPE;
  v_CourseName VARCHAR2(10);
BEGIN
  -- Retrieve the major for a given student
  SELECT major
    INTO v_Major
    FROM students
    WHERE ID = 10011;

  -- Based on the major, choose a course
  CASE v_Major
    WHEN 'Computer Science' THEN
      v_CourseName := 'CS  101';
    WHEN 'Economics' THEN
      v_CourseName :='ECN 203';
    WHEN 'History' THEN
      v_CourseName := 'HIS 101';
    WHEN 'Music' THEN
      v_CourseName := 'MUS 100';
    WHEN 'Nutrition' THEN
      v_CourseName := 'NUT 307';
    ELSE
      v_CourseName := 'Unknown';
  END CASE;

  DBMS_OUTPUT.PUT_LINE(v_CourseName);
END;
/

DECLARE
  v_TestVar NUMBER := 1;
BEGIN
  -- Since none of the WHEN clauses tests for the value 1,
  -- this will raise ORA-6592.
  CASE v_TestVar
    WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('Two!');
    WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('Three!');
    WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('Four!');
  END CASE;
END;
/

DECLARE
  v_TestVar NUMBER := 1;
BEGIN
  -- This CASE statement is labeled.
  <<MyCase>>
  CASE v_TestVar
    WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('One!');
    WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('Two!');
    WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('Three!');
    WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('Four!');
  END CASE MyCase;
END;
/

DECLARE
  v_Test1 NUMBER := 2;
  v_Test2 VARCHAR2(20) := 'Goodbye';
BEGIN
  CASE
    WHEN v_Test1 = 1 THEN
      DBMS_OUTPUT.PUT_LINE('One!');
      DBMS_OUTPUT.PUT_LINE('Another one!');
    WHEN v_Test1 > 1 THEN
      DBMS_OUTPUT.PUT_LINE('> 1!');
      DBMS_OUTPUT.PUT_LINE('Still > 1!');
    WHEN v_Test2 = 'Goodbye' THEN
      DBMS_OUTPUT.PUT_LINE('Goodbye!');
      DBMS_OUTPUT.PUT_LINE('Adios!');
    ELSE
      DBMS_OUTPUT.PUT_LINE('No match');
  END CASE;
END;
/
