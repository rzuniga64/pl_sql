REM Point.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This object type represents a point on a Cartesian grid.

CREATE OR REPLACE TYPE Point AS OBJECT (
  -- A point is represented by its location on an X-Y Cartesian
  -- grid.
  x NUMBER,
  y NUMBER,

  -- Returns a string '(x, y)'
  MEMBER FUNCTION ToString RETURN VARCHAR2,
  PRAGMA RESTRICT_REFERENCES(ToString, RNDS, WNDS, RNPS, WNPS),

  -- Returns the distance between p and the current Point (SELF).
  -- If p is not specified then it defaults to (0, 0).
  MEMBER FUNCTION Distance(p IN Point DEFAULT Point(0,0))
    RETURN NUMBER,
  PRAGMA RESTRICT_REFERENCES(Distance, RNDS, WNDS, RNPS, WNPS),

  -- Returns the sum of p and the current Point.
  MEMBER FUNCTION Plus(p IN Point) RETURN Point,
  PRAGMA RESTRICT_REFERENCES(Plus, RNDS, WNDS, RNPS, WNPS),

  -- Returns the current Point * n.
  MEMBER FUNCTION Times(n IN NUMBER) RETURN Point,
  PRAGMA RESTRICT_REFERENCES(Times, RNDS, WNDS, RNPS, WNPS)
);
/
show errors

CREATE OR REPLACE TYPE BODY Point AS
  -- Returns a string '(x, y)'
  MEMBER FUNCTION ToString RETURN VARCHAR2 IS
    v_Result VARCHAR2(20);
    v_xString VARCHAR2(8) := SUBSTR(TO_CHAR(x), 1, 8);
    v_yString VARCHAR2(8) := SUBSTR(TO_CHAR(y), 1, 8);
  BEGIN
    v_Result := '(' || v_xString || ', ';
    v_Result := v_Result || v_yString || ')';
    RETURN v_Result;
  END ToString;

  -- Returns the distance between p and the current Point (SELF).
  -- If p is not specified then it defaults to (0, 0).
  MEMBER FUNCTION Distance(p IN Point DEFAULT Point(0,0))
    RETURN NUMBER IS
  BEGIN
    RETURN SQRT(POWER(x - p.x, 2) + POWER(y - p.y, 2));
  END Distance;

  -- Returns the sum of p and and the current Point.
  MEMBER FUNCTION Plus(p IN Point) RETURN Point IS
    v_Result Point;
  BEGIN
    v_Result := Point(x + p.x, y + p.y);
    RETURN v_Result;
  END Plus;

  -- Returns the current Point * n.
  MEMBER FUNCTION Times(n IN NUMBER) RETURN Point IS
    v_Result Point;
  BEGIN
    v_Result := Point(x * n, y * n);
    RETURN v_Result;
  END Times;
END;
/
show errors

set serveroutput on

-- Demonstrates some points.
DECLARE
  v_Point1 Point := Point(1, 2);
  v_Point2 Point;
  v_Point3 Point;
BEGIN
  v_Point2 := v_Point1.Times(4);
  v_Point3 := v_Point1.Plus(v_Point2);
  DBMS_OUTPUT.PUT_LINE('Point 2: ' || v_Point2.ToString);
  DBMS_OUTPUT.PUT_LINE('Point 3: ' || v_Point3.ToString);
  DBMS_OUTPUT.PUT_LINE('Distance between origin and point 1: ' ||
    v_Point1.Distance);
  DBMS_OUTPUT.PUT_LINE('Distance between point 1 and point 2: ' ||
    v_Point1.Distance(v_Point2));
END;
/
