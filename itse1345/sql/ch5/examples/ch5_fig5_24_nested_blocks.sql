DECLARE
	lv_one_num NUMBER(2) := 10;
	lv_two_num NUMBER(2) := 20;
BEGIN
	DECLARE
		lv_one_num NUMBER(2) := 30;
		lv_three_num NUMBER(2) := 40;
	BEGIN
		lv_one_num := lv_one_num + 10;
		lv_two_num := lv_one_num + 10;
		DBMS_OUTPUT.PUT_LINE('Nested one = ' || lv_one_num);
		DBMS_OUTPUT.PUT_LINE('Nested two = ' || lv_two_num);
		DBMS_OUTPUT.PUT_LINE('Nested three = ' || lv_three_num);				
	END;
	lv_one_num := lv_one_num + 10;
	lv_two_num := lv_one_num + 10;
	--lv_three_num := lv_three_num + 10;
	DBMS_OUTPUT.PUT_LINE('Enclosing one = ' || lv_one_num);
	DBMS_OUTPUT.PUT_LINE('Enclosing two = ' || lv_two_num);
	--DBMS_OUTPUT.PUT_LINE('Enclosing three = ' || lv_three_num);
END;