CREATE OR REPLACE PROCEDURE STOCK_CHECK_SP
	(p_qty IN NUMBER,
	 p_prod IN NUMBER)
IS
	lv_stock_num bb_product.idproduct%TYPE;
BEGIN
	SELECT stock
		INTO  lv_stock_num
		FROM bb_product
		WHERE idproduct = p_prod;
	IF p_qty > lv_stock_num THEN
		RAISE_APPLICATION_ERROR(-20000, 'Not enough in stock. ' || 'Request = ' || p_qty || ' / stock level = ' || lv_stock_num);
	END IF;
EXCEPTION
	WHEN NO_DATA_FOUND THEN 
		DBMS_OUTPUT.PUT_LINE('No stock found');
END;
/