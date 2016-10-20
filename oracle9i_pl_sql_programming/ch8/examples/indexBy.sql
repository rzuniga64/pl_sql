REM indexBy.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This file contains several examples of index-by tables.

DECLARE
  TYPE NameTab IS TABLE OF students.first_name%TYPE
    INDEX BY BINARY_INTEGER;
  TYPE DateTab IS TABLE OF DATE
    INDEX BY BINARY_INTEGER;
  v_Names NameTab;
  v_Dates DateTab;
BEGIN
  v_Names(1) := 'Scott';
  v_Dates(-4) := SYSDATE - 1;
END;
/

DECLARE
  TYPE CharacterTab IS TABLE OF VARCHAR2(10)
    INDEX BY BINARY_INTEGER;
  v_Characters CharacterTab;
BEGIN
  -- Assign to three elements of the table.  Note that the key
  -- values are not sequential.
  v_Characters(0) := 'Harold';
  v_Characters(-7) := 'Susan';
  v_Characters(3) := 'Steve';
END;
/

set serveroutput on

DECLARE
  TYPE NumberTab IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
  v_Numbers NumberTab;
BEGIN
  -- Assign to several of the elements.
  FOR v_Count IN 1..10 LOOP
    v_Numbers(v_Count) := v_Count * 10;
  END LOOP;

  -- And print them out
  DBMS_OUTPUT.PUT_LINE('Table elements: ');
  FOR v_Count IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE('  v_Numbers(' || v_Count || '): ' ||
                         v_Numbers(v_Count));
  END LOOP;

  -- Read from v_Numbers(11).  Since it hasn't been assigned a
  -- value, this will raise NO_DATA_FOUND.
  BEGIN
    DBMS_OUTPUT.PUT_LINE('v_Numbers(11): ' || v_Numbers(11));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE(
         'No data found reading v_Numbers(11)!');
  END;
END;
/
