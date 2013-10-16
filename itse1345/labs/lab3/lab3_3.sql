DECLARE 
	lv_customer_id NUMBER(5) := 00001;
BEGIN
	get_customer_info_sp(lv_customer_id);
END;
/