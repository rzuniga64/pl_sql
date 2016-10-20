REM tabAssign.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block illustrates legal and illegal table assignments.

DECLARE
  TYPE NumbersTab IS TABLE OF NUMBER;
  v_Numbers NumbersTab := NumbersTab(1, 2, 3);
BEGIN
  -- v_Numbers was initialized to have 3 elements. So the
  -- following assignments are all legal.
  v_Numbers(1) := 7;
  v_Numbers(2) := -1;

  -- However, this assignment will raise ORA-6533.
  v_Numbers(4) := 4;
END;
/
