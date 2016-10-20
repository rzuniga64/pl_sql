REM RecordSelect.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows how to select into a record.

DECLARE
  -- Define a record to match some fields in the students table.
  -- Note the use of %TYPE for the fields.
  TYPE t_StudentRecord IS RECORD (
    FirstName  students.first_name%TYPE,
    LastName   students.last_name%TYPE,
    Major      students.major%TYPE);

  -- Declare a variable to receive the data.
  v_Student  t_StudentRecord;
BEGIN
  -- Retrieve information about student with ID 10,000.
  -- Note how the query is returning columns which match the
  -- fields in v_Student.
  SELECT first_name, last_name, major
    INTO v_Student
    FROM students
    WHERE ID = 10000;
END;
/
