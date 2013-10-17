/*
	Purpose: Adjust a string to a specific length.
	Input Parameters: String, Specified Length
	Output Parameters: None
	Input/Output Parameters: None
	Return Value: VARCHAR2 (adjusted string)
	
	- If there are any leading spaces, delete them.
	- If the specified length is greater than the actual length of 
	  the string, the string is padded on the right by spaces.
	- If the specified length is less than the actual length of the
	  string, the string is truncated on the right to the specified 
	  length.
*/

CREATE OR REPLACE
FUNCTION adjust_string_sp
	(p_string VARCHAR2, p_specified_length INTEGER)
RETURN VARCHAR2
IS
	lv_adjusted_string VARCHAR2(30) := p_string;
BEGIN
	-- trim any leading spaces
	lv_adjusted_string := TRIM(LEADING ' ' FROM lv_adjusted_string);
	
	-- If the specified length is greater than the actual length  
	-- of the string, the string is padded on the right by spaces.
  	IF LENGTH(lv_adjusted_string) < p_specified_length THEN
    	lv_adjusted_string := LPAD(lv_adjusted_string, p_specified_length, ' ');
		
	-- If the specified length is less than the actual length of the
	-- string, the string is truncated on the right to the specified length.	
  	ELSIF LENGTH(lv_adjusted_string) > p_specified_length THEN
    	lv_adjusted_string := SUBSTR(lv_adjusted_string, 1, p_specified_length);
  	END IF;
	RETURN lv_adjusted_string;
END;
