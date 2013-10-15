DECLARE
	lv_cost_num NUMBER(5,2);
BEGIN
	lv_cost_num := ship_calc_sf(12);
	DBMS_OUTPUT.PUT_LINE(lv_cost_num);
END;