CREATE OR REPLACE PACKAGE ordering_pkg
IS
-- Three objects are declared:
-- variable, procedure and function
pv_total_num NUMBER(3,2) := 0;
FUNCTION ship_calc_pf
	(p_qty IN NUMBER)
	RETURN NUMBER;	
PROCEDURE order_total_pp
	(p_bsktid IN bb_basketitem.idbasket%TYPE,
   	p_cnt OUT NUMBER,
   	p_sub OUT NUMBER,
   	p_ship OUT NUMBER,
   	p_total OUT NUMBER);
END;
----------------------------------------------
CREATE OR REPLACE PACKAGE BODY ordering_pkg IS
	
-- The ship_calc_pf function calculates the 
-- shipping cost based on the number of items
-- in the order.
FUNCTION ship_calc_pf  
	(p_qty IN NUMBER)
    RETURN NUMBER
IS
	lv_ship_num NUMBER(5,2);
BEGIN
	IF p_qty > 10 THEN
    	lv_ship_num := 11.00;
    ELSIF p_qty > 5 THEN
     	lv_ship_num := 8.00;
    ELSE
     	lv_ship_num := 5.00;
   END IF;
   RETURN lv_ship_num;
END ship_calc_pf;
----------------------------------------------
-- The order_total_pp procedure determines the 
-- quantity of items, order subtotal, shipping 
-- cost, and overall order total
PROCEDURE order_total_pp
	(p_bsktid IN bb_basketitem.idbasket%TYPE,
     p_cnt OUT NUMBER,
     p_sub OUT NUMBER,
     p_ship OUT NUMBER,
     p_total OUT NUMBER)
IS
BEGIN
    SELECT SUM(quantity),SUM(quantity*price)
	    INTO p_cnt, p_sub
	    FROM bb_basketitem
	    WHERE idbasket = p_bsktid;
	-- the ship_calc_pf function is called to
	-- determine the shipping cost
    p_ship := ship_calc_pf(p_cnt);
    p_total := NVL(p_sub,0) + NVL(p_ship,0);
END order_total_pp;
END;