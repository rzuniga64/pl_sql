REM NoDataFound.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates the behavior of the NO_DATA_FOUND
REM exception.

set serveroutput on

DECLARE
  -- Record to hold room information.
  v_RoomData   rooms%ROWTYPE;
BEGIN
  -- Retrieve information about room ID -1.
  SELECT *
    INTO v_RoomData
    FROM rooms
    WHERE room_id = -1;

  -- The following statement will never be executed, since
  -- control passes immediately to the exception handler.
  IF SQL%NOTFOUND THEN
    DBMS_OUTPUT.PUT_LINE('SQL%NOTFOUND is true!');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND raised!');
END;
/

