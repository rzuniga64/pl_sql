DECLARE
	lv_in_state_cnt NUMBER(3) := 0;
	lv_out_state_cnt NUMBER(3) := 0;
BEGIN
	home_state_cnt_sp(lv_in_state_cnt, lv_out_state_cnt);
	DBMS_OUTPUT.PUT_LINE('The number of in state students is ' || lv_in_state_cnt);
	DBMS_OUTPUT.PUT_LINE('The number of out of state students is ' || lv_out_state_cnt);	
END;
/