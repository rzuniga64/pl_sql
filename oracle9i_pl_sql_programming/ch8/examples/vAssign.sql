REM vAssign.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This file illustrates legal and illegal varray assignments.

DECLARE
  TYPE Strings IS VARRAY(5) OF VARCHAR2(10);

  -- Declare a varray with three elements
  v_List Strings :=
    Strings('One', 'Two', 'Three');
BEGIN
  -- Subscript between 1 and 3, so this is legal.
  v_List(2) := 'TWO';

  -- Subscript beyond count, raises ORA-6533.
  v_List(4) := '!!!';
END;
/

DECLARE
  TYPE Strings IS VARRAY(5) OF VARCHAR2(10);
  -- Declare a varray with four elements,
  v_List Strings :=
    Strings('One', 'Two', 'Three', 'Four');
BEGIN
  -- Subscript between 1 and 4, so this is legal.
  v_List(2) := 'TWO';
  
  -- Extend the table to 5 elements and set the value.
  v_List.EXTEND;
  v_List(5) := 'Five';
  
  -- Attempt to extend the table to 6 elements.  This will raise
  -- ORA-6532. 
  v_list.EXTEND;
END;
/
