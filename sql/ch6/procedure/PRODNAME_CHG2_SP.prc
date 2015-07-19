CREATE OR REPLACE PROCEDURE prodname_chg2_sp
	(p_id IN bb_product.idproduct%TYPE,
	p_name IN bb_product.productname%TYPE) 
	IS
	p_flag CHAR := 'N';	
BEGIN
	UPDATE bb_product
		SET productname = p_name
		WHERE idproduct = p_id;
	IF SQL%ROWCOUNT = 0 THEN
		RETURN;
	END IF;
	COMMIT;
	p_flag := 'Y';
END;
