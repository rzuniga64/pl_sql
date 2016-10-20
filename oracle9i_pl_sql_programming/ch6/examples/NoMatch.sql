REM NoMatch.sql
REM Chapter 6, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates the use of cursor attributes on the
REM implicit SQL cursor.

BEGIN
  UPDATE rooms
    SET number_seats = 100
    WHERE room_id = 99980;
  -- If the previous UPDATE statement didn't match any rows, 
  -- insert a new row into the rooms table.
  IF SQL%NOTFOUND THEN
    INSERT INTO rooms (room_id, number_seats)
      VALUES (99980, 100);
  END IF;
END;
/

BEGIN
  UPDATE rooms
    SET number_seats = 100
    WHERE room_id = 99980;
  -- If the previous UPDATE statement didn't match any rows, 
  -- insert a new row into the rooms table.
  IF SQL%ROWCOUNT = 0 THEN
    INSERT INTO rooms (room_id, number_seats)
      VALUES (99980, 100);
  END IF;
END;
/
