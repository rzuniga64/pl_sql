/*
	Figure 4-13 A BULK COLLECT option in a FETCH statement
	The major advantage of using bulk processing is improving
	performance.
	
	All rows are retrieved with one FETCH because of the
	BULK COLLECT option, instead of fetching one row at at 
	time, as in previous examples.  The rows are placed in 
	a table of records variable, and a loop is ued to verify
	the data that's retrieved.  Running this block displays
	all 29 rows of the BB_BASKETITEM table.
*/

DECLARE
	CURSOR cur_item IS
		SELECT *
		FROM bb_basketitem;
	TYPE type_item IS TABLE OF cur_item%ROWTYPE
		INDEX BY PLS_INTEGER;
	tbl_item type_item;
BEGIN
	OPEN cur_item;
	FETCH cur_item BULK COLLECT INTO tbl_item;
	FOR i IN 1..tbl_item.COUNT LOOP
		DBMS_OUTPUT.PUT_LINE('Basket ID: ' ||tbl_item(i).idbasketitem || 
				' - ' || 'Product ID: ' || tbl_item(i).idproduct);
	END LOOP;
	CLOSE cur_item;
END;			