--Figure 4-4 Cursor attributes reflecting the most recent SQL statement
DECLARE
	lv_tot_num bb_basket.total%TYPE;
BEGIN
	SELECT total
	INTO lv_tot_num
	FROM bb_basket
	WHERE idbasket = 12;
	DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT); --Diplays 1 as output
	UPDATE bb_product
	SET stock = stock + 25
	WHERE idproduct = 15;
	DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT); --Displays 0 as output
END;