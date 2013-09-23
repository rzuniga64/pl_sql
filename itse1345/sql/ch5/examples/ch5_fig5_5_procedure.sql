CREATE OR REPLACE
PROCEDURE SHIP_COST_SP
	(p_qty IN NUMBER,
	 p_ship OUT NUMBER)
AS
BEGIN
	IF p_qty > 10 THEN
		p_ship := 11.00;
	ELSIF p_qty > 5 THEN 
		p_ship := 8.00;
	ELSE
		p_ship := 5.00;
	END IF;
END SHIP_COST_SP;