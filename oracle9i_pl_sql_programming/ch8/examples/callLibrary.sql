REM callLibrary.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This file contains examples of calls to the Library package.

BEGIN
  Library.PrintCheckedOut(1000);
END;
/

DECLARE
  CURSOR c_History101Students IS
    SELECT student_ID
      FROM registered_students
      WHERE department = 'HIS'
      AND course = 101;
  v_RequiredReading class_material.required_reading%TYPE;
BEGIN
  -- Check out the required books for all students in HIS 101:

  -- Get the books required for HIS 101
  SELECT required_reading
    INTO v_RequiredReading
    FROM class_material
    WHERE department = 'HIS'
    AND course = 101;
  
  -- Loop over the History 101 students
  FOR v_Rec IN c_History101Students LOOP
    -- Loop over the required reading list
    FOR v_Index IN 1..v_RequiredReading.COUNT LOOP
      -- And check out the book!
      Library.CheckOut(v_RequiredReading(v_Index),
                       v_Rec.student_ID);
    END LOOP;
  END LOOP;
  
  -- Print out the students who have the book checked out now
  Library.PrintCheckedOut(2001);
  
  -- Check in the book for some of the students
  Library.CheckIn(2001, 10001);
  Library.CheckIn(2001, 10002);
  Library.CheckIn(2001, 10003);
  
  -- And print again.
  Library.PrintCheckedOut(2001);
END;
/
