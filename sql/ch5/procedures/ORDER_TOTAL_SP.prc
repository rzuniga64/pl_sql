CREATE OR REPLACE PROCEDURE ORDER_TOTAL_SP
	(p_basketid IN bb_basketitem.idbasket%TYPE,
	 p_cnt OUT NUMBER, 
	 p_sub OUT NUMBER,
	 p_ship OUT NUMBER,
	 p_total OUT NUMBER)
AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('order total proc called');
	SELECT SUM(quantity), SUM(quantity * price)
		INTO p_cnt, p_sub
		FROM bb_basketitem
		WHERE idbasket = p_basketid;
	ship_cost_sp(p_cnt, p_ship);
	p_total := NVL(p_sub,0) + NVL(p_ship,0);
	DBMS_OUTPUT.PUT_LINE('order total proc ended');
END ORDER_TOTAL_SP;	
