REM nested.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This example illustrates 2 nested blocks.

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
    
  -- Start of a nested block, which contains only an executable
  -- section
  BEGIN
    INSERT INTO log_table (info)
      VALUES ('Hello from a nested block!');
  END;
EXCEPTION
  /* Start of exception section */
  WHEN NO_DATA_FOUND THEN
    -- Start of a nested block, which itself contains an executable
    -- and exception section
    BEGIN
      -- Handle the error condition
      INSERT INTO log_table (info)
        VALUES ('Student 10,000 does not exist!');
    EXCEPTION
      WHEN OTHERS THEN
        -- Something went wrong with the INSERT
        DBMS_OUTPUT.PUT_LINE('Error inserting into log_table!');
    END;
END;
/
