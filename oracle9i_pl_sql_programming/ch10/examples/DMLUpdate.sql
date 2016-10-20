REM DMLUpdate.sql
REM Chapter 10, Oracle9i PL/SQL Programming by Scott Urman
REM This function can be called from a DML statement in Oracle8i.

CREATE OR REPLACE FUNCTION UpdateTemp(p_ID IN students.ID%TYPE)
  RETURN students.ID%TYPE AS
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES(p_ID, 'Updated!');
  RETURN p_ID;
END UpdateTemp;
/

UPDATE students
  SET major = 'Nutrition'
  WHERE UpdateTemp(ID) = ID;
