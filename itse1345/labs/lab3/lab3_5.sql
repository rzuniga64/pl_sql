	/*
	A simple driver to test the function ADJUST_STRING_SP. 
	Call the function with the following parameters:
o	1. String: ‘Now is the Time.’				Specified length = 6
o	2. String: ‘Now is the Time.’				Specified length = 25
o	3. String: ‘bbbbNow is the Time.bbbbbbbbb’  Specified length = 15    
	   (Where b = Blank Space)
	   
	Display the original string, the adjusted string and the length of the adjusted string. 
*/
DECLARE
	lv_length1 INTEGER := 5;
	lv_length2 INTEGER := 25;
	lv_length3 INTEGER := 15;
	lv_string1 VARCHAR2(16) := 'Now is the Time.';
	lv_string2 VARCHAR2(16) := 'Now is the Time.';
	lv_string3 VARCHAR2(30) := '    Now is the Time.         ';
	lv_adjusted_string VARCHAR(30);
BEGIN
	lv_adjusted_string := adjust_string_sp(lv_string1, lv_length1);
	DBMS_OUTPUT.PUT_LINE('Original string: '  || lv_string1 );
	DBMS_OUTPUT.PUT_LINE('Adjusted string: '  || lv_adjusted_string ); 
	DBMS_OUTPUT.PUT_LINE('Length of adjusted string: ' || LENGTH(lv_adjusted_string));  
	
	lv_adjusted_string := adjust_string_sp(lv_string2, lv_length2);
  	DBMS_OUTPUT.PUT_LINE(' ');  
  	DBMS_OUTPUT.PUT_LINE('Original string: '  || lv_string2 );
	DBMS_OUTPUT.PUT_LINE('Adjusted string: '  || lv_adjusted_string ); 
	DBMS_OUTPUT.PUT_LINE('Length of adjusted string: ' || LENGTH(lv_adjusted_string));  

	lv_adjusted_string := adjust_string_sp(lv_string3, lv_length3);
  	DBMS_OUTPUT.PUT_LINE(' ');  
  	DBMS_OUTPUT.PUT_LINE('Original string: '  || lv_string3 );
	DBMS_OUTPUT.PUT_LINE('Adjusted string: '  || lv_adjusted_string ); 
	DBMS_OUTPUT.PUT_LINE('Length of adjusted string: ' || LENGTH(lv_adjusted_string));  
END;
/