DECLARE
	lv_ship_num NUMBER(6,2);
BEGIN
	SHIP_COST_SP(7, lv_ship_num);
	DBMS_OUTPUT.PUT_LINE('Ship Cost = ' || lv_ship_num);
END;