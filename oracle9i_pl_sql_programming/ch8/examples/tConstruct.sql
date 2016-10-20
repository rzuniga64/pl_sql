REM tConstruct.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates nested table constructors.

DECLARE
  TYPE NumbersTab IS TABLE OF NUMBER;

  -- Create a table with one element.
  v_Tab1 NumbersTab := NumbersTab(-1);

  -- Create a table with five elements.
  v_Primes NumbersTab := NumbersTab(1, 2, 3, 5, 7);

  -- Create a table with no elements.
  v_Tab2 NumbersTab := NumbersTab();
BEGIN
  -- Assign to v_Tab1(1). This will replace the value already
  -- in v_Tab(1), which was initialized to -1.
  v_Tab1(1) := 12345;

  -- Print out the contents of v_Primes.
  FOR v_Count IN 1..5 LOOP
    DBMS_OUTPUT.PUT(v_Primes(v_Count) || ' ');
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;
END;
/
