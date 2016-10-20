REM CopyFast.sql
REM Chapter 9, Oracle9i PL/SQL Programming by Scott Urman
REM This package shows the performance improvements of the 8i
REM NOCOPY modifier.

set serveroutput on

CREATE OR REPLACE PACKAGE CopyFast AS
  -- PL/SQL table of students.
  TYPE StudentArray IS
    TABLE OF students%ROWTYPE;

  -- Three procedures which take a parameter of StudentArray, in
  -- different ways.  They each do nothing.
  PROCEDURE PassStudents1(p_Parameter IN StudentArray);
  PROCEDURE PassStudents2(p_Parameter IN OUT StudentArray);
  PROCEDURE PassStudents3(p_Parameter IN OUT NOCOPY StudentArray);

  -- Test procedure.
  PROCEDURE Go;
END CopyFast;
/
show errors

CREATE OR REPLACE PACKAGE BODY CopyFast AS
  PROCEDURE PassStudents1(p_Parameter IN StudentArray) IS
  BEGIN
    NULL;
  END PassStudents1;

  PROCEDURE PassStudents2(p_Parameter IN OUT StudentArray) IS
  BEGIN
    NULL;
  END PassStudents2;

  PROCEDURE PassStudents3(p_Parameter IN OUT NOCOPY StudentArray) IS
  BEGIN
    NULL;
  END PassStudents3;

  PROCEDURE Go IS
    v_StudentArray StudentArray := StudentArray(NULL);
    v_StudentRec students%ROWTYPE;
    v_Time1 NUMBER;
    v_Time2 NUMBER;
    v_Time3 NUMBER;
    v_Time4 NUMBER;
  BEGIN
    -- Fill up the array with 50,001 copies of David Dinsmore's
    -- record.
    SELECT *
      INTO v_StudentArray(1)
      FROM students
      WHERE ID = 10007;
    v_StudentArray.EXTEND(50000, 1);

    -- Call each version of PassStudents, and time them.
    -- DBMS_UTILITY.GET_TIME will return the current time, in
    -- hundredths of a second.
    v_Time1 := DBMS_UTILITY.GET_TIME;
    PassStudents1(v_StudentArray);
    v_Time2 := DBMS_UTILITY.GET_TIME;
    PassStudents2(v_StudentArray);
    v_Time3 := DBMS_UTILITY.GET_TIME;
    PassStudents3(v_StudentArray);
    v_Time4 := DBMS_UTILITY.GET_TIME;

    -- Output the results.
    DBMS_OUTPUT.PUT_LINE('Time to pass IN: ' ||
                         TO_CHAR((v_Time2 - v_Time1) / 100));
    DBMS_OUTPUT.PUT_LINE('Time to pass IN OUT: ' ||
                         TO_CHAR((v_Time3 -   v_Time2) / 100));
    DBMS_OUTPUT.PUT_LINE('Time to pass IN OUT NOCOPY: ' ||
                         TO_CHAR((v_Time4 - v_Time3) / 100));
  END Go;
END CopyFast;
/
show errors

BEGIN
  CopyFast.Go;
END;
/
