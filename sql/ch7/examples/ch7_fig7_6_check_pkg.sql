DECLARE
	lv_bask_num bb_basketitem.idbasket%TYPE := 12;
	lv_cnt_num NUMBER(3);
	lv_sub_num NUMBER(8,2);
	lv_ship_num NUMBER(8,2);
	lv_total_num NUMBER(8,2);
BEGIN
	ordering_pkg.order_total_pp(lv_bask_num, lv_cnt_num, lv_sub_num, lv_ship_num, lv_total_num);
	DBMS_OUTPUT.PUT_LINE(lpad('No. of items ordered: ',25) || lv_cnt_num);
	DBMS_OUTPUT.PUT_LINE(lpad('Subtotal: ',25) || lv_sub_num);
	DBMS_OUTPUT.PUT_LINE(lpad('Shipping cost: ',25) || lv_ship_num);
	DBMS_OUTPUT.PUT_LINE(lpad('Total cost: ',25) || lv_total_num);			
END;