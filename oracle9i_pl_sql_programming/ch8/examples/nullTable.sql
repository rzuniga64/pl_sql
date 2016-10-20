REM nullTable.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates a NULL table, and a table with a 
REM NULL element.

DECLARE
  TYPE WordsTab IS TABLE OF VARCHAR2(50);

  -- Create a NULL table.
  v_Tab1 WordsTab;

  -- Create a table with one element, which itself is NULL.
  v_Tab2 WordsTab := WordsTab();
BEGIN
  IF v_Tab1 IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('v_Tab1 is NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('v_Tab1 is not NULL');
  END IF;

  IF v_Tab2 IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('v_Tab2 is NULL');
  ELSE
    DBMS_OUTPUT.PUT_LINE('v_Tab2 is not NULL');
  END IF;
END;
/
