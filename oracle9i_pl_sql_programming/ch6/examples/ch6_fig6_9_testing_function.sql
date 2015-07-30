DECLARE
	lv_name_txt VARCHAR2(50);
	lv_id_num bb_shopper.idshopper%TYPE := 25;
	lv_first_txt bb_shopper.firstname%TYPE := 'Scott';
	lv_last_txt bb_shopper.lastname%TYPE := 'Savid';
BEGIN
	lv_name_txt := memfmt1_sf(lv_id_num, lv_first_txt, lv_last_txt);
	DBMS_OUTPUT.put_line(lv_name_txt);
END;