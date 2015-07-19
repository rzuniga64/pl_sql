DECLARE
	lv_user_txt bb_shopper.username%TYPE := 'fdwell';
	lv_pass_txt bb_shopper.password%TYPE := 'tweak';
	lv_id_num bb_shopper.idshopper%TYPE;
	lv_flag_txt CHAR(1);
	lv_name_txt VARCHAR2(50);
BEGIN
	login_sp(lv_user_txt, lv_pass_txt, lv_id_num, lv_flag_txt, lv_name_txt);
	DBMS_OUTPUT.PUT_LINE(lv_id_num);
	DBMS_OUTPUT.PUT_LINE(lv_flag_txt);
	DBMS_OUTPUT.PUT_LINE(lv_name_txt);
END;