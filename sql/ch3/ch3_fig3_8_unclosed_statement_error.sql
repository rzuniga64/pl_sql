/* 
	Figure 3-8 An error caused by not closing the previous statement

	When an error occurs at the beginning of a line starting a new 
	statement, the cause is often that the previous statement wasn't 
	terminated correctly with a semicolon.
*/
DECLARE 
 lv_basket_num NUMBER(3);
 lv_created_date DATE;
 lv_qty_num NUMBER(2);
 lv_sub_num NUMBER(5,2);
 lv_days_num NUMBER(3);
 lv_shopper_num NUMBER(3) := 25;	
BEGIN
 SELECT idBasket, dtcreated, quantity, subtotal
  INTO lv_basket_num, lv_created_date, lv_qty_num, lv_sub_num
  FROM bb_basket
  WHERE idShopper = lv_shopper_num 
    AND orderplaced = 0;
-- lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date
 lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;
 DBMS_OUTPUT.PUT_LINE(lv_basket_num||' * '||lv_created_date||' * '||
                       lv_qty_num||' * '||lv_sub_num||' * '||lv_days_num);
END;