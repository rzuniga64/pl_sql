/* 
	Figure4-11 Checking CURSOR's FOR loop results
	Explicit cursors offer two options to simplify the process of
	iterating through a table and then performing an update on the
	database: FOR UPDATE and WHERE CURRENT OF.
	
	Cursors have a feature that enables you to instruct the Oracle server
	to keep track of which physical database row corresponds to each row
	in the cursor. 
	
	To use this feature, add a FOR UPDATE clause in the cursor declaration.
	It instructs the system to lock the rows retrieved with the SELECT 
	statement because you intend to issue updates via the cursor and to
	keep track of the physical row in the database table that each row in 
	the cursor corresponds to. In addition, the WHERE CURRENT OF cursor
	clause is added to the UPDATE statements to instruct the system to 
	update the table's physical row corresponding to the cursor row currently 
	being processed.  The FOR UPDATE and WHERE CURRENT OF clauses work together
	to simplify update actitivity via a cursor.
*/

DECLARE
	CURSOR cur_prod IS
		SELECT type, price
		FROM bb_product
		WHERE active = 1
	FOR UPDATE NOWAIT;
		lv_sale bb_product.saleprice%TYPE;
BEGIN
	FOR rec_prod IN cur_prod LOOP
		IF rec_prod.type = 'C' Then lv_sale := rec_prod.price * 0.9;
		ELSIF rec_prod.type = 'E' THEN lv_sale := rec_prod.price * 0.95;
		END IF;
		UPDATE bb_product
			SET saleprice = lv_sale
		WHERE CURRENT OF cur_prod;
	END LOOP;
	COMMIT;
END;