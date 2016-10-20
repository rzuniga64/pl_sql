REM RoomsPkg.sql
REM Chapter 1, Oracle9i PL/SQL Programming by Scott Urman
REM This script contains a PL/SQL package.

CREATE OR REPLACE PACKAGE RoomsPkg AS
  PROCEDURE NewRoom(p_Building rooms.building%TYPE,
                    p_RoomNum rooms.room_number%TYPE,
                    p_NumSeats rooms.number_seats%TYPE,
                    p_Description rooms.description%TYPE);

  PROCEDURE DeleteRoom(p_RoomID IN rooms.room_id%TYPE);
END RoomsPkg;
/
show errors

CREATE OR REPLACE PACKAGE BODY RoomsPkg AS
  PROCEDURE NewRoom(p_Building rooms.building%TYPE,
                    p_RoomNum rooms.room_number%TYPE,
                    p_NumSeats rooms.number_seats%TYPE,
                    p_Description rooms.description%TYPE) IS
  BEGIN
    INSERT INTO rooms
      (room_id, building, room_number, number_seats, description)
      VALUES
      (room_sequence.NEXTVAL, p_Building, p_RoomNum, p_NumSeats,
       p_Description);
  END NewRoom;

  PROCEDURE DeleteRoom(p_RoomID IN rooms.room_id%TYPE) IS
  BEGIN
    DELETE FROM rooms
      WHERE room_id = p_RoomID;
  END DeleteRoom;
END RoomsPkg;
/
show errors
