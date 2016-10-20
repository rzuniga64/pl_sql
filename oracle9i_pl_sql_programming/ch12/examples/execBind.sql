REM execBind.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the use of the USING clause with EXECUTE
REM IMMEDIATE to handle bind variables.

DECLARE
  v_SQLString  VARCHAR2(1000);
  v_PLSQLBlock VARCHAR2(1000);

  CURSOR c_EconMajor IS
    SELECT *
      FROM students
      WHERE major = 'Economics';
BEGIN
  -- Insert ECN 103 into classes, using a string for the SQL
  -- statement.
  v_SQLString :=
    'INSERT INTO CLASSES (department, course, description,
                          max_students, current_students,
                          num_credits)
       VALUES (:dep, :course, :descr, :max_s, :cur_s, :num_c)';

  -- Execute the INSERT, using literal values.
  EXECUTE IMMEDIATE v_SQLString USING
    'ECN', 103, 'Economics 103', 10, 0, 3;

  -- Register all of the Economics majors for the new class.
  FOR v_StudentRec IN c_EconMajor LOOP
    -- Here we have a literal SQL statement, but PL/SQL variables
    -- in the USING clause.
    EXECUTE IMMEDIATE
        'INSERT INTO registered_students
           (student_ID, department, course, grade)
         VALUES (:id, :dep, :course, NULL)'
      USING v_StudentRec.ID, 'ECN', 103;

    -- Update the number of students for the class, using an
    -- anonymous PL/SQL block.
    v_PLSQLBlock :=
      'BEGIN
         UPDATE classes SET current_students = current_students + 1
         WHERE department = :d and course = :c;
       END;';

    EXECUTE IMMEDIATE v_PLSQLBlock USING 'ECN', 103;
  END LOOP;
END;
/

ROLLBACK;
