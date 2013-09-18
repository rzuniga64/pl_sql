--Figure 4-18 Exception handler for an undefined exception

DECLARE
	ex_basket_fk EXCEPTION; --Declare an exception name
	-- associate an Oracle error with the exception name
	PRAGMA EXCEPTION_INIT(ex_basket_fk, -2292);
BEGIN
	DELETE FROM bb_basket
	--foreign key error occurs because of existing items in the bb_basketitem table
	WHERE idbasket = 4;
EXCEPTION
	--exception handler runs if the DELETE statement raises foreign key error -2292
	WHEN ex_basket_fk THEN 
		DBMS_OUTPUT.PUT_LINE('Item still in the basket');
END;