REM if1.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates an IF statement.

DECLARE
  v_NumberSeats rooms.number_seats%TYPE;
  v_Comment VARCHAR2(35);
BEGIN
  /* Retrieve the number of seats in the room identified by ID 20008.
     Store the result in v_NumberSeats. */
  SELECT number_seats
    INTO v_NumberSeats
    FROM rooms
    WHERE room_id = 20008;
  IF v_NumberSeats < 50 THEN
    v_Comment := 'Fairly small';
  ELSIF v_NumberSeats < 100 THEN
    v_Comment := 'A little bigger';
  ELSE
    v_Comment := 'Lots of room';
  END IF;
END;
/
