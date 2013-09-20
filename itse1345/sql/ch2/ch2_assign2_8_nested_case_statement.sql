/*
	Assignment 2-8: Nested case statements

	Create a block to accomplish the task outlined in Assignment 2-7.  
	Include a variable containing a Y or N to indicate membership status 
	and a variable to represent the number of items purchased.  Test with 
	a variety of values
	
	Quantity of Items	Nonmember Shipping  Cost Member Shipping Cost
	Up to 3				$5.00				$3.00
	4-6					$7.50				$5.00
	7-10				$10.00				$7.00
	More than 10		$12.00				$9.00
*/

DECLARE 
  lv_member_status VARCHAR2(1) := UPPER('y');
  lv_no_items_purchased NUMBER(4) := 11;
  lv_shipping_cost NUMBER(5,2);
BEGIN
  CASE
    WHEN lv_member_status = 'N' THEN
    CASE 
      WHEN lv_no_items_purchased >=0 AND lv_no_items_purchased <=3 THEN lv_shipping_cost := 5.00;
      WHEN lv_no_items_purchased >=4 AND lv_no_items_purchased <=6 THEN lv_shipping_cost := 7.50;  
      WHEN lv_no_items_purchased >=7 AND lv_no_items_purchased <=10 THEN lv_shipping_cost := 10.00;      
      ELSE lv_shipping_cost := 12.00;   
    END CASE;
    WHEN lv_member_status = 'Y' THEN
    CASE
      WHEN lv_no_items_purchased >=0 AND lv_no_items_purchased <=3 THEN lv_shipping_cost := 3.00;
      WHEN lv_no_items_purchased >=4 AND lv_no_items_purchased <=6 THEN lv_shipping_cost := 5.00;  
      WHEN lv_no_items_purchased >=7 AND lv_no_items_purchased <=10 THEN lv_shipping_cost := 7.00;      
      ELSE lv_shipping_cost := 9.00; 
    END CASE;
  END CASE;
  DBMS_OUTPUT.PUT_LINE('Member: ' || lv_member_status);
  DBMS_OUTPUT.PUT_LINE('Number of items purchased:' || lv_no_items_purchased);
  DBMS_OUTPUT.PUT_LINE('Shipping cost: ' || lv_shipping_cost);
END;




