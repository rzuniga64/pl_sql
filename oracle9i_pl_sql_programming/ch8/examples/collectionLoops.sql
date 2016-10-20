REM collectionLoops.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates FIRST, LAST, NEXT, and PRIOR.

set serveroutput on

DECLARE
  TYPE CharTab IS TABLE OF CHAR(1);
  v_Characters CharTab :=
    CharTab('M', 'a', 'd', 'a', 'm', ',', ' ',
            'I', '''', 'm', ' ', 'A', 'd', 'a', 'm');

  v_Index INTEGER;
BEGIN
  -- Loop forwards over the table.
  v_Index := v_Characters.FIRST;
  WHILE v_Index <= v_Characters.LAST LOOP
    DBMS_OUTPUT.PUT(v_Characters(v_Index));
    v_Index := v_Characters.NEXT(v_Index);
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;

  -- Loop backwards over the table.
  v_Index := v_Characters.LAST;
  WHILE v_Index >= v_Characters.FIRST LOOP
    DBMS_OUTPUT.PUT(v_Characters(v_Index));
    v_Index := v_Characters.PRIOR(v_Index);
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;
END;
/
