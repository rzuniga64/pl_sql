/* 
	Figure 3-7 An error for a variable that's not declared.

	You should see the error message "identifier 'lv_basket_nu'
	must be declared.
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
  INTO lv_basket_nu, lv_created_date, lv_qty_num, lv_sub_num
  FROM bb_basket
  WHERE idShopper = lv_shopper_num 
    AND orderplaced = 0;
 lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - lv_created_date;
 DBMS_OUTPUT.PUT_LINE(lv_basket_num||' * '||lv_created_date||' * '||
                       lv_qty_num||' * '||lv_sub_num||' * '||lv_days_num);
END;