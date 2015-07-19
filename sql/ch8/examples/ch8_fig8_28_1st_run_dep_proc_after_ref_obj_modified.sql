REM The ORDER_TOTAL_SP procedure's dependency on 
REM SHIP_COST_SP is checked at runtime because a 
REM remote connection is used. The first run after
REM modifying the referenced object fails because 
REM Oracle recognizes that a change has been made 
REM ORDER_TOTAL_SP need to be recompiled. Notice that
REM one of the error messages shows that the timestamp
REM of SHIP_COST has been changed.
REM
REM Run the ORDER_TOTAL_SP procedure again.  The second
REM run recompiles ORDER_TOTAL_SP automatically, and the 
REM procedure runs successfuly.

DECLARE
	lv_cnt_num NUMBER(3);
	lv_sub_num NUMBER(8,2);
	lv_ship_num NUMBER(8,2);
	lv_total_num NUMBER(8,2);
BEGIN
	order_total_sp(12, lv_cnt_num, lv_sub_num, lv_ship_num, lv_total_num);
	DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
	DBMS_OUTPUT.PUT_LINE(lv_sub_num);
	DBMS_OUTPUT.PUT_LINE(lv_ship_num);
	DBMS_OUTPUT.PUT_LINE(lv_total_num);			
END;