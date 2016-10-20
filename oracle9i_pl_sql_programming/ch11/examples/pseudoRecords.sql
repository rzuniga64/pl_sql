REM pseudoRecords.sql
REM Chapter 11, Oracle9i PL/SQL Programming by Scott Urman
REM This trigger shows that :old and :new are pseudo-records.

set echo on

CREATE OR REPLACE TRIGGER TempDelete
  BEFORE DELETE ON temp_table
  FOR EACH ROW
DECLARE
  v_TempRec temp_table%ROWTYPE;
BEGIN
  /* This is not a legal assignment, since :old is not truly
     a record. */
  v_TempRec := :old;

  /* We can accomplish the same thing, however, by assigning
    the fields individually. */
  v_TempRec.char_col := :old.char_col;
  v_TempRec.num_col := :old.num_col;
END TempDelete;
/

show errors
