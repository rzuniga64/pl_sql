REM ClassesRoomsInstead.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This is a complete instead-of trigger.

CREATE OR REPLACE TRIGGER ClassesRoomsInstead
  INSTEAD OF INSERT OR UPDATE OR DELETE ON classes_rooms
  FOR EACH ROW
DECLARE
  v_roomID rooms.room_id%TYPE;
  v_UpdatingClasses BOOLEAN := FALSE;
  v_UpdatingRooms BOOLEAN := FALSE;

  -- Local function that returns the room ID, given a building
  -- and room number.  This function will raise ORA-20000 if the
  -- building and room number are not found.
  FUNCTION getRoomID(p_Building IN rooms.building%TYPE,
                     p_Room IN rooms.room_number%TYPE)
    RETURN rooms.room_id%TYPE IS

    v_RoomID rooms.room_id%TYPE;
  BEGIN
    SELECT room_id
      INTO v_RoomID
      FROM rooms
      WHERE building = p_Building
      AND room_number = p_Room;
    RETURN v_RoomID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20000, 'No matching room');
  END getRoomID;

  -- Local procedure which checks if the class identified by
  -- p_Department and p_Course exists.  If not, it raises
  -- ORA-20001.
  PROCEDURE verifyClass(p_Department IN classes.department%TYPE,
                        p_Course IN classes.course%TYPE) IS
    v_Dummy NUMBER;
  BEGIN
    SELECT 0
      INTO v_Dummy
      FROM classes
      WHERE department = p_Department
      AND course = p_Course;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001,
        p_Department || ' ' || p_Course || ' doesn''t exist');
  END verifyClass;

BEGIN
  IF INSERTING THEN
    -- This essentially assigns a class to a given room.  The logic
    -- here is the same as the "updating rooms" case below:  First,
    -- determine the room ID:
      v_RoomID := getRoomID(:new.building, :new.room_number);

      -- And then update classes with the new ID.
      UPDATE CLASSES
        SET room_id = v_RoomID
        WHERE department = :new.department
        AND course = :new.course;

  ELSIF UPDATING THEN
    -- Determine if we are updating classes, or updating rooms.
    v_UpdatingClasses := (:new.department != :old.department) OR
                         (:new.course != :old.course);
    v_UpdatingRooms := (:new.building != :old.building) OR
                       (:new.room_number != :old.room_number);

    IF (v_UpdatingClasses) THEN
      -- In this case, we are changing the class assigned for a
      -- given room.  First make sure the new class exists.
      verifyClass(:new.department, :new.course);

      -- Get the room ID,
      v_RoomID := getRoomID(:old.building, :old.room_number);

      -- Then clear the room for the old class,
      UPDATE classes
        SET room_ID = NULL
        WHERE department = :old.department
        AND course = :old.course;

      -- And finally assign the old room to the new class.
      UPDATE classes
        SET room_ID = v_RoomID
        WHERE department = :new.department
        AND course = :new.course;
    END IF;

    IF v_UpdatingRooms THEN
      -- Here, we are changing the room for a given class.  This
      -- logic is the same as the "inserting" case above, except
      -- that classes is updated with :old instead of :new.
      -- First, determine the new room ID.
      v_RoomID := getRoomID(:new.building, :new.room_number);

      -- And then update classes with the new ID.
      UPDATE CLASSES
        SET room_id = v_RoomID
        WHERE department = :old.department
        AND course = :old.course;
    END IF;

  ELSE
    -- Here, we want to clear the class assigned to the room,
    -- without actually removing rows from the underlying tables.
    UPDATE classes
      SET room_ID = NULL
      WHERE department = :old.department
      AND course = :old.course;
  END IF;
END ClassesRoomsInstead;
/
show errors

set echo off
REM First select from all three to verify the initial values
PROMPT original classes:
SELECT department, course, room_id
  FROM classes
  ORDER BY room_id;

PROMPT original rooms:
SELECT room_id, building, room_number
  FROM rooms
  ORDER BY room_id;

PROMPT original classes_rooms:
SELECT *
  FROM classes_rooms;

REM Now insert into classes_rooms.  This will cause classes to be
REM updated.
PROMPT INSERTing into classes_rooms...
INSERT INTO classes_rooms
  VALUES ('MUS', 100, 'Music Building', 200);

REM And select again.
PROMPT classes after insert:
SELECT department, course, room_id
  FROM classes
  ORDER BY room_id;

PROMPT rooms after insert:
SELECT room_id, building, room_number
  FROM rooms
  ORDER BY room_id;

PROMPT classes_rooms after insert:
SELECT *
  FROM classes_rooms;

REM Update classes_rooms.  This will cause corresponding updates to
REM classes.
PROMPT UPDATing classes_rooms...
UPDATE classes_rooms
  SET department = 'NUT', course = 307
  WHERE building = 'Building 7' AND room_number = 201;

REM And select again.
PROMPT classes after update:
SELECT department, course, room_id
  FROM classes
  ORDER BY room_id;

PROMPT rooms after update:
SELECT room_id, building, room_number
  FROM rooms
  ORDER BY room_id;

PROMPT classes_rooms after update:
SELECT *
  FROM classes_rooms;

REM Delete from classes_rooms.
REM DELETing classes_rooms...
DELETE FROM classes_rooms
  WHERE building = 'Building 6';

REM And select again.
PROMPT classes after delete:
SELECT department, course, room_id
  FROM classes
  ORDER BY room_id;

PROMPT rooms after delete:
SELECT room_id, building, room_number
  FROM rooms
  ORDER BY room_id;

PROMPT classes_rooms after delete:
SELECT *
  FROM classes_rooms;


REM Rollback to undo our changes.
rollback;