/*
	ASSIGNMENT 2-6: Using Loop Statements

	Create a block using a loop that determines the number of items 
	that can be purchased based on the item prices and the total 
	available to spend.  Include on initialized variable to represent 
	the price and another to represent the total available to spend. 
	(You could solve it with division, but you need to practice using 
	loop structures). The block should include statements to display 
	the total number of items that can be purchased and the total 
	amount spent.
*/

DECLARE 
  lv_price NUMBER(8,2) := 20.00;
  lv_total_amount NUMBER(8,2) := 200.00;
  lv_total_spent NUMBER(8,2) := 0;
  lv_number_items NUMBER(3) := 0;
BEGIN
  LOOP
    lv_total_amount := lv_total_amount - lv_price;
    IF lv_total_amount >= 0 THEN
      lv_total_spent := lv_total_spent + lv_price;
      lv_number_items := lv_number_items + 1;
      DBMS_OUTPUT.PUT_LINE(lv_total_amount);
    END IF;      
    EXIT WHEN lv_total_amount <= 0;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Total amount spent: ' || lv_total_spent);
  DBMS_OUTPUT.PUT_LINE('Number of items: ' || lv_number_items);
END;  




