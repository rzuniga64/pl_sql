REM firingOrder.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This script demonstrates the order of trigger firing.

DROP SEQUENCE trig_seq;

CREATE SEQUENCE trig_seq
  START WITH 1
  INCREMENT BY 1;

CREATE OR REPLACE PACKAGE TrigPackage AS
  -- Global counter for use in the triggers
  v_Counter NUMBER;
END TrigPackage;
/

CREATE OR REPLACE TRIGGER ClassesBStatement
  BEFORE UPDATE ON classes
BEGIN
  -- Reset the counter first.
  TrigPackage.v_Counter := 0;

  INSERT INTO temp_table (num_col, char_col)
    VALUES (trig_seq.NEXTVAL,
      'Before Statement: counter = ' || TrigPackage.v_Counter);

  -- And now increment it for the next trigger.
  TrigPackage.v_Counter := TrigPackage.v_Counter + 1;
END ClassesBStatement;
/

CREATE OR REPLACE TRIGGER ClassesAStatement1
  AFTER UPDATE ON classes
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (trig_seq.NEXTVAL,
      'After Statement 1: counter = ' || TrigPackage.v_Counter);

  -- Increment for the next trigger.
  TrigPackage.v_Counter := TrigPackage.v_Counter + 1;
END ClassesAStatement1;
/

CREATE OR REPLACE TRIGGER ClassesAStatement2
  AFTER UPDATE ON classes
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (trig_seq.NEXTVAL,
      'After Statement 2: counter = ' || TrigPackage.v_Counter);

  -- Increment for the next trigger.
  TrigPackage.v_Counter := TrigPackage.v_Counter + 1;
END ClassesAStatement2;
/

CREATE OR REPLACE TRIGGER ClassesBRow1
  BEFORE UPDATE ON classes
  FOR EACH ROW
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (trig_seq.NEXTVAL,
      'Before Row 1: counter = ' || TrigPackage.v_Counter);

  -- Increment for the next trigger.
  TrigPackage.v_Counter := TrigPackage.v_Counter + 1;
END ClassesBRow1;
/

CREATE OR REPLACE TRIGGER ClassesBRow2
  BEFORE UPDATE ON classes
  FOR EACH ROW
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (trig_seq.NEXTVAL,
      'Before Row 2: counter = ' || TrigPackage.v_Counter);

  -- Increment for the next trigger.
  TrigPackage.v_Counter := TrigPackage.v_Counter + 1;
END ClassesBRow2;
/

CREATE OR REPLACE TRIGGER ClassesBRow3
  BEFORE UPDATE ON classes
  FOR EACH ROW
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (trig_seq.NEXTVAL,
      'Before Row 3: counter = ' || TrigPackage.v_Counter);

  -- Increment for the next trigger.
  TrigPackage.v_Counter := TrigPackage.v_Counter + 1;
END ClassesBRow3;
/

CREATE OR REPLACE TRIGGER ClassesARow
  AFTER UPDATE ON classes
  FOR EACH ROW
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (trig_seq.NEXTVAL,
      'After Row: counter = ' || TrigPackage.v_Counter);

  -- Increment for the next trigger.
  TrigPackage.v_Counter := TrigPackage.v_Counter + 1;
END ClassesARow;
/

DELETE FROM temp_table;

UPDATE classes
  SET num_credits = 4
  WHERE department IN ('HIS', 'CS');

SELECT *
  FROM temp_table
  ORDER BY num_col;
