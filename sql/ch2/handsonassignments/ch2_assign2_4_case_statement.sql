/*
	ASSIGNMENT 2-4 CASE Statements

	Create a block using a CASE statement to perform the actions 
	described in Assignment 2-2.  Use a scalar variable for the 
	total purchase amount, and initialize this variable to different 
	values to test your block.
.
*/

DECLARE
  lv_total_purchase NUMBER(4) := 300;
  lv_cust_rating VARCHAR2(5);
BEGIN
  CASE
    WHEN lv_total_purchase > 200 THEN
    lv_cust_rating := 'high';
    WHEN  lv_total_purchase > 100 THEN
    lv_cust_rating := 'mid';
    ELSE
      lv_cust_rating := 'low';
  END CASE;
  DBMS_OUTPUT.PUT_LINE(lv_cust_rating);
END;

