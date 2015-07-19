DECLARE
	lv_phone_txt VARCHAR2(13) := '112223333';
BEGIN
	phone_fmt_sp(lv_phone_txt);
	DBMS_OUTPUT.PUT_LINE(lv_phone_txt);
END;
/