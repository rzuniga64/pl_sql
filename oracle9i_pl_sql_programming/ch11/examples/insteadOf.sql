REM insteadOf.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates the use of an Oracle8 instead-of
REM trigger.

CREATE OR REPLACE VIEW classes_rooms AS
  SELECT department, course, building, room_number
  FROM rooms, classes
  WHERE rooms.room_id = classes.room_id;

SELECT * FROM classes_rooms;

PROMPT Illegal insert...
INSERT INTO classes_rooms (department, course, building, room_number)
  VALUES ('MUS', 100, 'Music Building', 200);

CREATE TRIGGER ClassesRoomsInsert
  INSTEAD OF INSERT ON classes_rooms
DECLARE
  v_roomID rooms.room_id%TYPE;
BEGIN
  -- First determine the room ID
  SELECT room_id
    INTO v_roomID
    FROM rooms
    WHERE building = :new.building
    AND room_number = :new.room_number;

  -- And now update the class
  UPDATE CLASSES
    SET room_id = v_roomID
    WHERE department = :new.department
    AND course = :new.course;
END ClassesRoomsInsert;
/

PROMPT Successful insert...
INSERT INTO classes_rooms (department, course, building, room_number)
  VALUES ('MUS', 100, 'Music Building', 200);

SELECT * FROM classes_rooms;
