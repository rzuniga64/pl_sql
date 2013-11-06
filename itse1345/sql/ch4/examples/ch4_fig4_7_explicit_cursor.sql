-- Scalar variables can't handle more than one row being return from a query.
DECLARE
	lv_created_date DATE;
	lv_basket_num NUMBER(3);
	lv_qty_num NUMBER(3);
	lv_sub_num NUMBER(5,2);
	lv_days_num NUMBER(3);
	lv_shopper_num NUMBER(3) := 26;
BEGIN
	SELECT idbasket, dtcreated, quantity, subtotal
  	INTO lv_basket_num, lv_created_date, lv_qty_num, lv_sub_num
	FROM bb_basket
	WHERE idshopper = lv_shopper_num
	AND orderplaced = 0;
	lv_days_num := TO_DATE('02/28/13', 'mm/dd/yy') - lv_created_date;
	DBMS_OUTPUT.PUT_LINE(lv_basket_num || '*' || lv_created_date || '*' 
										|| lv_qty_num || '*' || lv_sub_num || '*' || lv_days_num);
END;
/