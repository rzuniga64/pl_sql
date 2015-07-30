DECLARE
	lv_basket_num bb_basketitem.idbasketitem%TYPE := 16;
	lv_cnt_num NUMBER(3);
	lv_sub_num NUMBER(8,2);
	lv_ship_num NUMBER(8,2);
	lv_total_num NUMBER(8,2);
BEGIN
	DBMS_OUTPUT.PUT_LINE('Anonymous block started');
	order_total_sp(lv_basket_num, lv_cnt_num, lv_sub_num,
					lv_ship_num, lv_total_num);
	DBMS_OUTPUT.PUT_LINE(lv_cnt_num);	
	DBMS_OUTPUT.PUT_LINE(lv_sub_num);	
	DBMS_OUTPUT.PUT_LINE(lv_ship_num);	
	DBMS_OUTPUT.PUT_LINE(lv_total_num);	
	DBMS_OUTPUT.PUT_LINE('Anonymous block ended');	
END;