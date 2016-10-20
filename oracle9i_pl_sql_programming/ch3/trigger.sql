REM trigger.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This is an example of a database trigger.

CREATE OR REPLACE TRIGGER OnlyPositive
  BEFORE INSERT OR UPDATE OF num_col
  ON temp_table
  FOR EACH ROW
BEGIN
  IF :new.num_col < 0 THEN
    RAISE_APPLICATION_ERROR(-20100, 'Please insert a positive value');
  END IF;
END OnlyPositive;
/

-- This INSERT will succeed, since the value is positive.
INSERT INTO temp_table (num_col, char_col)
  VALUES (1, 'This is row 1');
  
-- This one will fail, however, because the value is negative.
INSERT INTO temp_table (num_col, char_col)
  VALUES (-1, 'This is row -1');

ROLLBACK;
