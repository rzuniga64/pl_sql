REM collectionDML.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This file contains examples of DML operations on collections.

DECLARE
  v_CSBooks BookList := BookList(1000, 1001, 1002);
  v_HistoryBooks BookList := BookList(2001);
BEGIN
  -- INSERT using a newly constructed varray of 2 elements.
  INSERT INTO class_material
    VALUES ('MUS', 100, BookList(3001, 3002));
    
  -- INSERT using a previously initialized varray of 3 elements.
  INSERT INTO class_material VALUES ('CS', 102, v_CSBooks);

  -- INSERT using a previously initialized varray of 1 element.
  INSERT INTO class_material VALUES ('HIS', 101, v_HistoryBooks);
END;
/

DECLARE
  v_StudentList1 StudentList := StudentList(10000, 10002, 10003);
  v_StudentList2 StudentList := StudentList(10000, 10002, 10003);
  v_StudentList3 StudentList := StudentList(10000, 10002, 10003);
BEGIN
  -- First insert rows with NULL nested tables.
  INSERT INTO library_catalog (catalog_number, num_copies, num_out)
    VALUES (1000, 20, 3);
  INSERT INTO library_catalog (catalog_number, num_copies, num_out)
    VALUES (1001, 20, 3);
  INSERT INTO library_catalog (catalog_number, num_copies, num_out)
    VALUES (1002, 10, 3);
  INSERT INTO library_catalog (catalog_number, num_copies, num_out)
    VALUES (2001, 50, 0);
  INSERT INTO library_catalog (catalog_number, num_copies, num_out)
    VALUES (3001, 5, 0);
  INSERT INTO library_catalog (catalog_number, num_copies, num_out)
    VALUES (3002, 5, 1);
    
  -- Now update using the PL/SQL variables.
  UPDATE library_catalog
    SET checked_out = v_StudentList1
    WHERE catalog_number = 1000;
  UPDATE library_catalog
    SET checked_out = v_StudentList2
    WHERE catalog_number = 1001;
  UPDATE library_catalog
    SET checked_out = v_StudentList3
    WHERE catalog_number = 1002;

  -- And update the last row using a new variable.
  UPDATE library_catalog
    SET checked_out = StudentList(10009)
    WHERE catalog_number = 3002;
END;
/

DELETE FROM library_catalog
  WHERE catalog_number = 3001;
