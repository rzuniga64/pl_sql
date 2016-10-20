REM LabeledBlock.sql
REM Chapter 3, Oracle9i PL/SQL Programming by Scott Urman
REM This is an example of a labeled block.

<<l_InsertIntoTemp>>
DECLARE
  /* Declare variables to be used in this block. */
  v_Num1      NUMBER := 1;
  v_Num2      NUMBER := 2;
  v_String1   VARCHAR2(50) := 'Hello World!';
  v_String2   VARCHAR2(50) :=
    '-- This message brought to you by PL/SQL!';
  v_OutputStr VARCHAR2(50);
BEGIN
  /* First, insert two rows into temp_table, using the values
     of the variables. */
  INSERT INTO temp_table (num_col, char_col)
    VALUES (v_Num1, v_String1);
  INSERT INTO temp_table (num_col, char_col)
    VALUES (v_Num2, v_String2);
	
  /* Now query temp_table for the two rows we just inserted, and
     output them to the screen using the DBMS_OUTPUT package. */
  SELECT char_col
    INTO v_OutputStr
	FROM temp_table
	WHERE num_col = v_Num1;
  DBMS_OUTPUT.PUT_LINE(v_OutputStr);
  
  SELECT char_col
    INTO v_OutputStr
	FROM temp_table
	WHERE num_col = v_Num2;
  DBMS_OUTPUT.PUT_LINE(v_OutputStr);
  
  /* Rollback our changes */
  ROLLBACK;

END l_InsertIntoTemp;
/

