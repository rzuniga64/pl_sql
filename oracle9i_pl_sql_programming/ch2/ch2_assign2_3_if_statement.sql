/*
	ASSIGNMENT 2-3 IF Statements

	Create a block using an IF statement to perform the actions 
	described in Assignment 2-2.  Use a scalar variable for the 
	total purchase amount, and initialize this variable to different 
	values to test your block.
*/

DECLARE
  lv_total_purchase NUMBER(4) := 200;
  lv_cust_rating VARCHAR2(5);
BEGIN
  IF lv_total_purchase > 200 THEN
    lv_cust_rating := 'high';
  ELSIF lv_total_purchase > 100 THEN
    lv_cust_rating := 'mid';
  ELSE
    lv_cust_rating := 'low';
  END IF;
  DBMS_OUTPUT.PUT_LINE(lv_cust_rating);
END;
