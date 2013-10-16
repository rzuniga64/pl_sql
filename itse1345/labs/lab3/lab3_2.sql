DECLARE 
	lv_date1 DATE := '01-JAN-01';
	lv_date2 DATE := '01-FEB-01';
  lv_date_flag INTEGER;
BEGIN
	lv_date_flag := compare_date_sf(lv_date1, lv_date2);
  DBMS_OUTPUT.PUT_LINE(lv_date1 || ' compared with ' || lv_date2 || ' is ' || lv_date_flag);
END;
/