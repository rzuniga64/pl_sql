REM PointSQL.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates SQL operations on object types.

DROP TABLE point_object_tab;

CREATE TABLE point_object_tab OF Point;
  
DROP TABLE point_column_tab;

CREATE TABLE point_column_tab (
  key VARCHAR2(20),
  value Point);

set serveroutput on

DECLARE
  v_Point Point := Point(1, 1);
  v_NewPoint Point;
  v_Key point_column_tab.key%TYPE;
  v_XCoord NUMBER;
  v_YCoord NUMBER;
BEGIN
  -- Insert into both tables.
  INSERT INTO point_object_tab VALUES (v_Point);
  INSERT INTO point_column_tab VALUES ('My Point', v_Point);
  
  -- If we just query the object table, we get back each row as a 
  -- set of select list items, as if it were a relational table.
  SELECT *
    INTO v_XCoord, v_YCoord
    FROM point_object_tab;
  DBMS_OUTPUT.PUT_LINE('Relational query of object table: ' ||
    v_XCoord || ', ' || v_YCoord);
    
  -- But if we use the VALUE operator, we get each row as an
  -- object.
  SELECT VALUE(ot)
    INTO v_NewPoint
    FROM point_object_tab ot;
  DBMS_OUTPUT.PUT_LINE('object table: ' || v_NewPoint.ToString);
  
  -- Selecting from an object column always returns an object
  -- instance.
  SELECT key, value
    INTO v_Key, v_NewPoint
    FROM point_column_tab;
  DBMS_OUTPUT.PUT_LINE('column table: ' || v_NewPoint.ToString);
  
END;
/

-- Illustrates the use of object references
DECLARE
  v_PointRef REF Point;
  v_Point Point;
BEGIN
  DELETE FROM point_object_tab;
  
  -- Insert some points into the object table.
  INSERT INTO point_object_tab (x, y)
    VALUES (0, 0);
  INSERT INTO point_object_tab (x, y)
    VALUES (1, 1);
    
  -- Retreive a reference to the second row
  SELECT REF(ot)
    INTO v_PointRef
    FROM point_object_tab ot
    WHERE x = 1 AND y = 1;
    
  -- Dereference it to get an actual point
  SELECT DEREF(v_PointRef)
    INTO v_Point
    FROM dual;
  DBMS_OUTPUT.PUT_LINE('Selected reference ' ||
    v_Point.ToString);
    
  -- We can also get a reference to a newly inserted row 
  -- with REF INTO
  INSERT INTO point_object_tab ot (x, y)
    VALUES (10, 10)
    RETURNING REF(ot) INTO v_PointRef;
END;
/

