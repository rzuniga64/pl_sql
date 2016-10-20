REM LibraryOperator.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This version of the Library package uses the TABLE operator
REM to manipulate individual elements of the nested tables.

CREATE OR REPLACE PACKAGE Library AS
  -- Prints out the students who have a particular book checked out.
  PROCEDURE PrintCheckedOut(
    p_CatalogNumber IN library_catalog.catalog_number%TYPE);
    
  -- Checks out the book with p_CatalogNumber to the student with 
  -- p_StudentID.
  PROCEDURE CheckOut(
    p_CatalogNumber IN library_catalog.catalog_number%TYPE,
    p_StudentID IN NUMBER);
                     
  -- Checks in the book with p_CatalogNumber from the student with
  -- p_StudentID.
  PROCEDURE CheckIn(
    p_CatalogNumber IN library_catalog.catalog_number%TYPE,
    p_StudentID IN NUMBER);
END Library;
/
show errors

CREATE OR REPLACE PACKAGE BODY Library AS
  -- Prints out the students who have a particular book checked out.
  PROCEDURE PrintCheckedOut(
    p_CatalogNumber IN library_catalog.catalog_number%TYPE) IS
    
    v_StudentList StudentList;
    v_Student students%ROWTYPE;
    v_Book    books%ROWTYPE;
    v_FoundOne BOOLEAN := FALSE;

    CURSOR c_CheckedOut IS
      SELECT column_value ID
        FROM TABLE(SELECT checked_out
                   FROM library_catalog
                   WHERE catalog_number = p_CatalogNumber);
  BEGIN
    SELECT *
      INTO v_Book
      FROM books
      WHERE catalog_number = p_CatalogNumber;
    
    DBMS_OUTPUT.PUT_LINE(
      'Students who have ' || v_Book.catalog_number || ': ' ||
      v_Book.title || ' checked out: ');
    
    -- Loop over the nested table, and print out the student names.
    FOR v_Rec IN c_CheckedOut LOOP
      v_FoundOne := TRUE;
        
        SELECT *
          INTO v_Student
          FROM students
          WHERE ID = v_Rec.ID;
        
        DBMS_OUTPUT.PUT_LINE('  ' || v_Student.first_name || ' ' || 
                             v_Student.last_name);
    END LOOP;

    IF NOT v_FoundOne THEN
      DBMS_OUTPUT.PUT_LINE('  None');
    END IF;
  END PrintCheckedOut;

  -- Checks out the book with p_CatalogNumber to the student with 
  -- p_StudentID.
  PROCEDURE CheckOut(
    p_CatalogNumber IN library_catalog.catalog_number%TYPE,
    p_StudentID IN NUMBER) IS

    v_NumCopies library_catalog.num_copies%TYPE;
    v_NumOut library_catalog.num_out%TYPE;
    v_CheckedOut library_catalog.checked_out%TYPE;
  BEGIN
    -- First verify that the book exists, and that there is a copy
    -- available to be checked out.
    BEGIN
      SELECT num_copies, num_out, checked_out
        INTO v_NumCopies, v_NumOut, v_CheckedOut
        FROM library_catalog
        WHERE catalog_number = p_CatalogNumber
        FOR UPDATE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,
          'There is no book with catalog number ' ||
          p_CatalogNumber || ' in the library');
    END;
  
    IF v_NumCopies = v_NumOut THEN
      RAISE_APPLICATION_ERROR(-20001,
        'All of the copies of book ' || p_CatalogNumber || 
        ' are checked out');
    END IF;
  
    -- Search the list to see if this student already has this book.
    IF v_CheckedOut IS NOT NULL THEN
      FOR v_Counter IN 1..v_CheckedOut.COUNT LOOP
        IF v_CheckedOut(v_Counter) = p_StudentID THEN
          RAISE_APPLICATION_ERROR(-20002,
            'Student ' || p_StudentID || ' already has book ' ||
            p_CatalogNumber || ' checked out');
        END IF;
      END LOOP;
    END IF;
    
    -- Make room in the list
    IF v_CheckedOut IS NULL THEN
      v_CheckedOut := StudentList(NULL);
    ELSE
      v_CheckedOut.EXTEND;
    END IF;
    
    -- Check out the book by adding it to the list.
    v_CheckedOut(v_CheckedOut.COUNT) := p_StudentID;

    -- And put it back in the database, adding 1 to num_out.
    UPDATE library_catalog
      SET checked_out = v_CheckedOut,
          num_out = num_out + 1
      WHERE catalog_number = p_CatalogNumber;
  END CheckOut;

  -- Checks in the book with p_CatalogNumber from the student with
  -- p_StudentID.
  PROCEDURE CheckIn(
    p_CatalogNumber IN library_catalog.catalog_number%TYPE,
    p_StudentID IN NUMBER) IS
    
    v_NumCopies library_catalog.num_copies%TYPE;
    v_NumOut library_catalog.num_out%TYPE;
    v_CheckedOut library_catalog.checked_out%TYPE;
    v_AlreadyCheckedOut BOOLEAN := FALSE;
  BEGIN
    -- First verify that the book exists
    BEGIN
      SELECT num_copies, num_out, checked_out
        INTO v_NumCopies, v_NumOut, v_CheckedOut
        FROM library_catalog
        WHERE catalog_number = p_CatalogNumber
        FOR UPDATE;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,
          'There is no book with catalog number ' ||
          p_CatalogNumber || ' in the library');
    END;
    
    -- Search the list to verify that this student has checked it
    -- out.
    IF v_CheckedOut IS NOT NULL THEN
      FOR v_Counter IN 1..v_CheckedOut.COUNT LOOP
        IF v_CheckedOut(v_Counter) = p_StudentID THEN
          v_AlreadyCheckedOut := TRUE;
          -- Delete it from the list.
          v_CheckedOut.DELETE(v_Counter);
        END IF;
      END LOOP;
    END IF;
    
    IF NOT v_AlreadyCheckedOut THEN
      RAISE_APPLICATION_ERROR(-20003,
        'Student ' || p_StudentID || ' does not have book ' ||
        p_CatalogNumber || ' checked out');
    END IF;
    
    -- And put it back in the database, subtracting from num_out.
    UPDATE library_catalog
      SET checked_out = v_CheckedOut,
          num_out = num_out - 1
      WHERE catalog_number = p_CatalogNumber;
  END CheckIn;
END Library;
/
show errors

