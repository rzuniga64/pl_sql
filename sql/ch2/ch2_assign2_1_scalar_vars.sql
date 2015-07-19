/*
ASSIGNMENT 2-1: Using Scalar Variables
Create a PL/SQL block containing the following variables:

Name			Data Type	Option		Initial Value
lv_test_date	DATE					December 10, 2012
lv_test_num		NUMBER(3)	CONSTANT	10
lv_test_txt	VAR CHAR2(10)		

Assign your last name as the value of the text variable in the executable section of the block.  Include statements in the block to display each variable’s value onscreen.
*/

DECLARE
  lv_test_date DATE := '10-DECEMBER-12';
  lv_test_num CONSTANT NUMBER(3) := 10;
  lv_test_txt VARCHAR2(10) := 'Zuniga';
BEGIN
  DBMS_OUTPUT.PUT_LINE(lv_test_date);
  DBMS_OUTPUT.PUT_LINE(lv_test_num);
  DBMS_OUTPUT.PUT_LINE(lv_test_txt);
END;
