REM tabRecord.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates an index-by table of records.

DECLARE
  TYPE StudentTab IS TABLE OF students%ROWTYPE
    INDEX BY BINARY_INTEGER;
  /* Each element of v_Students is a record */
  v_Students StudentTab;
BEGIN
  /* Retrieve the record with id = 10,001 and store it into
     v_Students(10001). */
  SELECT *
    INTO v_Students(10001)
    FROM students
    WHERE id = 10001;

  /* Directly assign to v_Students(1). */
  v_Students(1).first_name := 'Larry';
  v_Students(1).last_name := 'Lemon';
END;
/
