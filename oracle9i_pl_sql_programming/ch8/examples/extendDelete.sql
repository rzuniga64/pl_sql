REM extendDelete.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the interaction between EXTEND and DELETE.

set serveroutput on

DECLARE
  -- Initialize a nested table to 5 elements.
  v_Numbers NumTab := NumTab(-2, -1, 0, 1, 2);

  -- Local procedure to print out a table.
  -- Note the use of FIRST, LAST, and NEXT.
  PROCEDURE Print(p_Table IN NumTab) IS
    v_Index INTEGER;
  BEGIN
    v_Index := p_Table.FIRST;
    WHILE v_Index <= p_Table.LAST LOOP
      DBMS_OUTPUT.PUT('Element ' || v_Index || ': ');
      DBMS_OUTPUT.PUT_LINE(p_Table(v_Index));
      v_Index := p_Table.NEXT(v_Index);
    END LOOP;
  END Print;

BEGIN
  DBMS_OUTPUT.PUT_LINE('At initialization, v_Numbers contains');
  Print(v_Numbers);

  -- Delete element 3.  This removes the '0', but keeps a placeholder
  -- where it was.
  v_Numbers.DELETE(3);

  DBMS_OUTPUT.PUT_LINE('After delete, v_Numbers contains');
  Print(v_Numbers);

  -- Add 2 copies of element 1 onto the table.  This will add elements
  -- 6 and 7.
  v_Numbers.EXTEND(2, 1);

  DBMS_OUTPUT.PUT_LINE('After extend, v_Numbers contains');
  Print(v_Numbers);
  
  DBMS_OUTPUT.PUT_LINE('v_Numbers.COUNT = ' || v_Numbers.COUNT);
  DBMS_OUTPUT.PUT_LINE('v_Numbers.LAST = ' || v_Numbers.LAST);
END;
/
