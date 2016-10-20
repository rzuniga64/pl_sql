REM ReturningInto.sql
REM Chapter 4, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows the RETURNING INTO clause.

set serveroutput on

DECLARE
  v_NewRowid ROWID;
  v_FirstName students.first_name%TYPE;
  v_LastName students.last_name%TYPE;
  v_ID students.ID%TYPE;
BEGIN
  -- Insert a new row into the students table, and get the
  -- rowid of the new row at the same time.
  INSERT INTO students
    (ID, first_name, last_name, major, current_credits)
  VALUES
    (student_sequence.NEXTVAL, 'Xavier', 'Xemes', 'Nutrition', 0)
  RETURNING rowid INTO v_NewRowid;
  
  DBMS_OUTPUT.PUT_LINE('Newly inserted rowid is ' || v_NewRowid);
  
  -- Update this new row to increase the credits, and get
  -- the first and last name back.
  UPDATE students
    SET current_credits = current_credits + 3
    WHERE rowid = v_NewRowid
    RETURNING first_name, last_name INTO v_FirstName, v_LastName;
    
  DBMS_OUTPUT.PUT_LINE('Name: ' || v_FirstName || ' ' || v_LastName);
  
  -- Delete the row,and get the ID of the deleted row back.
  DELETE FROM students
    WHERE rowid = v_NewRowid
    RETURNING ID INTO v_ID;
    
  DBMS_OUTPUT.PUT_LINE('ID of new row was ' || v_ID);
END;
/

