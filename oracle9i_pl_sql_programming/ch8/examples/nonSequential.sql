REM nonSequential.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This file shows the behavior of storing and retreiving a
REM nested table with non-sequential keys.

DROP TABLE famous_dates;
DROP TYPE DateTab;

CREATE OR REPLACE TYPE DateTab AS
  TABLE OF DATE;
/

CREATE TABLE famous_dates (
  key        VARCHAR2(100) PRIMARY KEY,
  date_list  DateTab)
  NESTED TABLE date_list STORE AS dates_tab;


DECLARE
  -- Create a nested table with 5 dates.
  v_Dates DateTab := DateTab(TO_DATE('04-JUL-1776', 'DD-MON-YYYY'),
                             TO_DATE('12-APR-1861', 'DD-MON-YYYY'),
                             TO_DATE('05-JUN-1968', 'DD-MON-YYYY'),
                             TO_DATE('26-JAN-1986', 'DD-MON-YYYY'),
                             TO_DATE('01-JAN-2001', 'DD-MON-YYYY'));

  -- Local procedure to print out a DateTab.
  PROCEDURE Print(p_Dates IN DateTab) IS
    v_Index BINARY_INTEGER := p_Dates.FIRST;
  BEGIN
    WHILE v_Index <= p_Dates.LAST LOOP
      DBMS_OUTPUT.PUT('  ' || v_Index || ': ');
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(p_Dates(v_Index), 
                                   'DD-MON-YYYY'));
      v_Index := p_Dates.NEXT(v_Index);
    END LOOP;
  END Print;

BEGIN
  -- Delete element 2 of the table.  This will result in a table of
  -- 4 elements.
  v_Dates.DELETE(2);

  DBMS_OUTPUT.PUT_LINE('Initial value of the table:');
  Print(v_Dates);

  -- INSERT the nested table into the database, and then SELECT it
  -- back out.
  INSERT INTO famous_dates (key, date_list)
    VALUES ('Dates in American History', v_Dates);

  SELECT date_list
    INTO v_Dates
    FROM famous_dates
    WHERE key = 'Dates in American History';

  DBMS_OUTPUT.PUT_LINE('Table after INSERT and SELECT:');
  Print(v_Dates);
END;
/

