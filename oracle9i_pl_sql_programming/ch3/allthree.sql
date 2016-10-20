REM allthree.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This block contains all three sections - declarative, executable,
REM and exception.

DECLARE
  /* Start of declarative section */
  v_StudentID NUMBER(5) := 10000;  -- Numeric variable initialized
                                   -- to 10,000
  v_FirstName VARCHAR2(20);        -- Variable length character string
                                   -- with maximum length of 20
BEGIN 
  /* Start of executable section */
  -- Retrieve first name of student with ID 10,000
  SELECT first_name
    INTO v_FirstName
    FROM students
    WHERE id = v_StudentID;
EXCEPTION
  /* Start of exception section */
  WHEN NO_DATA_FOUND THEN
    -- Handle the error condition
    INSERT INTO log_table (info)
      VALUES ('Student 10,000 does not exist!');
END;
/
