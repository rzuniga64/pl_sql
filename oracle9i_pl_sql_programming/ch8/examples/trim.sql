REM trim.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows the TRIM collection method.

set serveroutput on

DECLARE
  -- Initialize a table to 7 elements.
  v_Numbers NumTab := NumTab(-3, -2, -1, 0, 1, 2, 3);

  -- Local procedure to print out a table.
  PROCEDURE Print(p_Table IN NumTab) IS
    v_Index INTEGER;
  BEGIN
    v_Index := p_Table.FIRST;
    WHILE v_Index <= p_Table.LAST LOOP
      DBMS_OUTPUT.PUT('Element ' || v_Index || ': ');
      DBMS_OUTPUT.PUT_LINE(p_Table(v_Index));
      v_Index := p_Table.NEXT(v_Index);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('COUNT = ' || p_Table.COUNT);
    DBMS_OUTPUT.PUT_LINE('LAST = ' || p_Table.LAST);
  END Print;

BEGIN
  DBMS_OUTPUT.PUT_LINE('At initialization, v_Numbers contains');
  Print(v_Numbers);

  -- Delete element 6.
  v_Numbers.DELETE(6);
  DBMS_OUTPUT.PUT_LINE('After delete , v_Numbers contains');
  Print(v_Numbers);

  -- Trim the last 3 elements.  This will remove the 2 and 3, but
  -- also remove the (now empty) spot where 1 was.
  v_Numbers.TRIM(3);
  DBMS_OUTPUT.PUT_LINE('After trim, v_Numbers contains');
  Print(v_Numbers);
END;
/
