REM nested.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates some nested tables.

DECLARE
  -- Define a nested table type based on an object type
  TYPE ObjectTab IS TABLE OF MyObject;

  -- A nested table type based on %ROWTYPE
  TYPE StudentsTab IS TABLE OF students%ROWTYPE;

  -- Variables of the above types
  v_StudentList StudentsTab;
  v_ObjectList ObjectTab;
BEGIN
  -- This assignment will raise COLLECTION_IS_NULL because
  -- v_ObjectList is atomically NULL.
  v_ObjectList(1) :=
    MyObject(-17, 'Goodbye', TO_DATE('01-01-2001', 'DD-MM-YYYY'));
END;
/
