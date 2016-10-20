REM PrintRequired.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This procedure illustrates how to query a stored varray.

CREATE OR REPLACE PROCEDURE PrintRequired(
  p_Department IN class_material.department%TYPE,
  p_Course IN class_material.course%TYPE) IS
  
  v_Books class_material.required_reading%TYPE;
  v_Title books.title%TYPE;
BEGIN
  -- Fetch the entire varray.
  SELECT required_reading
    INTO v_Books
    FROM class_material
    WHERE department = p_Department
    AND course = p_Course;

  DBMS_OUTPUT.PUT('Required reading for ' || RTRIM(p_Department));
  DBMS_OUTPUT.PUT_LINE(' ' || p_Course || ':');

  -- Loop over the table, printing out each row.
  FOR v_Index IN 1..v_Books.COUNT LOOP
    SELECT title
      INTO v_Title
      FROM books
      WHERE catalog_number = v_Books(v_Index);
    DBMS_OUTPUT.PUT_LINE(
      '  ' || v_Books(v_Index) || ': ' || v_Title);
  END LOOP;
END PrintRequired;
/

DECLARE
  CURSOR c_Courses IS
    SELECT department, course
      FROM class_material
      ORDER BY department;
BEGIN
  FOR v_Rec IN c_Courses LOOP
    PrintRequired(v_Rec.department, v_Rec.course);
  END LOOP;
END;
/
