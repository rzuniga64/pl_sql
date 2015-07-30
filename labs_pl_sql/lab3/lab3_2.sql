/*
	A simple driver to call and test the procedure COMPARE_DATE_SF
	Test each of the three different possible comparison values.
	- Return Value: -1 if the 1st date is less than the 2nd date.
	- Return Value: 0 if the 1st date is equal to the 2nd date.
	- Return Value: 1 if the 1st date is greater than the 2nd date.
*/
DECLARE 
	lv_date1 DATE := '01-JAN-01';
	lv_date2 DATE := '01-FEB-01';
	lv_date3 DATE := '01-JAN-00';
	lv_date4 DATE := '01-JAN-01';
  lv_date_flag INTEGER;
BEGIN
	lv_date_flag := compare_date_sf(lv_date1, lv_date2);
  	DBMS_OUTPUT.PUT_LINE(lv_date1 || ' compared with ' || lv_date2 || ' is ' || lv_date_flag);
	lv_date_flag := compare_date_sf(lv_date1, lv_date3);
  	DBMS_OUTPUT.PUT_LINE(lv_date1 || ' compared with ' || lv_date3 || ' is ' || lv_date_flag);  
	lv_date_flag := compare_date_sf(lv_date1, lv_date4);
  	DBMS_OUTPUT.PUT_LINE(lv_date1 || ' compared with ' || lv_date4 || ' is ' || lv_date_flag);  	
END;
/