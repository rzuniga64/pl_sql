/*
	Purpose: To compare two dates
	Input Parameters: 2 dates
	Input/Output parameters: None
	Output Parameters: None
	Return Value: Integer (-1, 0, +1) depending on whether the 1st date is less than, 
	equal to, or greater than the 2nd date. (The time component is not to be considered
	here)
	Preconditions: Dates in standard format
	Postconditions: Dates unchanged. Comparison Value Returned.
		           -  Write a simple driver to call and test the procedure
		           -  Test each of the three different possible comparison values.
*/
CREATE OR REPLACE FUNCTION compare_date_sf
	( p_date1 IN DATE, p_date2 IN DATE)
RETURN INTEGER
IS
	lv_date_flag INTEGER(2);
BEGIN
	IF (p_date1 - p_date2) > 0 THEN
		lv_date_flag := 1;
	ELSIF (p_date1 - p_date2) < 0 THEN
		lv_date_flag := -1;
	ElSIF (p_date1 - p_date2) = 0 THEN
		lv_date_flag := 0;
	END IF;
	RETURN lv_date_flag;
END;
/