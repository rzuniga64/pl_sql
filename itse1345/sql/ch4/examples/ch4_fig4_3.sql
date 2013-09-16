--Figure 4-3 Using cursor attributes
BEGIN
	UPDATE bb_product
	SET stock = stock + 25
	WHERE idProduct = 15;
	DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
	
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('Not found');
	END IF;
END;