/*
	If you're retriving thousands of rows, you can also use a
	LIMIT clause to give you more control over the number of 
	rows processed with each FETCH statement, thereby improving
	memory use on the database server.
	
	The FETCH action must be inside a loop because each fetch is
	limited to 1000 rows, so multiple fetches are required to 
	retrieve all rows.  Also, the EXIT statement is included at 
	the bottom of the loop to ensure that all rows fetched are 
	processed before the loop ends.
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
	LOOP
		FETCH cur_item BULK COLLECT INTO tbl_item LIMIT 1000;
			FOR i IN 1..tbl_item.COUNT LOOP
				DBMS_OUTPUT.PUT_LINE('Basket ID: ' ||tbl_item(i).idbasketitem || 
					' - ' || 'Product ID: ' || tbl_item(i).idproduct);
			END LOOP;
	--ensure all rows fetched are processed before loop ends		
	EXIT WHEN cur_item%NOTFOUND; 
	END LOOP;
	CLOSE cur_item;
END;			