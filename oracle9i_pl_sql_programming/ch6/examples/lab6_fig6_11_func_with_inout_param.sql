DECLARE
	lv_var1_num NUMBER(5) :=1 ;
	lv_var2_txt VARCHAR2(10);
BEGIN
	lv_var2_txt := test_out_sf(lv_var1_num);
	DBMS_OUTPUT.PUT_LINE(lv_var1_num);
	DBMS_OUTPUT.PUT_LINE(lv_var2_txt);
END;