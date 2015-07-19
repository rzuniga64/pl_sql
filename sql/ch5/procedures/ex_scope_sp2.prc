CREATE OR REPLACE PROCEDURE EX_SCOPE_SP2
	(p_bsktid IN bb_basketitem.idbasket%TYPE)
AS
	lv_qty_num bb_basket.quantity%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Proc2 before SELECT');
	SELECT quantity
	INTO lv_qty_num
	FROM bb_basket
	WHERE idbasket = p_bsktid;
	DBMS_OUTPUT.PUT_LINE('Proc2 after SELECT');
EXCEPTION
	WHEN NO_DATA_FOUND THEN 
		DBMS_OUTPUT.PUT_LINE('Proc2 exception handler');
		RAISE;
END;
/