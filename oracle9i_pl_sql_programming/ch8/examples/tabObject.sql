REM tabObject.sql
REM Chapter 8, Oracle9i PL/SQL Programming by Scott Urman
REM This block shows an index-by table of an object type.

CREATE OR REPLACE TYPE MyObject AS OBJECT (
  field1 NUMBER,
  field2 VARCHAR2(20),
  field3 DATE);
/

DECLARE
  TYPE ObjectTab IS TABLE OF MyObject
    INDEX BY BINARY_INTEGER;
  /* Each element of v_Objects is an instance of the MyObject object
   * type. */
  v_Objects ObjectTab;
BEGIN
  /* Directly assign to v_Objects(1).  First we have to initialize
   * the object type. */
  v_Objects(1) := MyObject(1, NULL, NULL);
  v_Objects(1).field2 := 'Hello World!';
  v_Objects(1).field3 := SYSDATE;
END;
/
