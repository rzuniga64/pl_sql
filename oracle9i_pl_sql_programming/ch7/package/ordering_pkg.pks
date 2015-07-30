CREATE OR REPLACE PACKAGE ordering_pkg
IS
pv_total_num NUMBER(3,2) := 0;
pv_bonus_num NUMBER(3,2) := 0;
--FUNCTION ship_calc_pf
--	(p_qty IN NUMBER)
--	RETURN NUMBER;	
PROCEDURE order_total_pp
	(p_bsktid IN bb_basketitem.idbasket%TYPE,
   	p_cnt OUT NUMBER,
   	p_sub OUT NUMBER,
   	p_ship OUT NUMBER,
   	p_total OUT NUMBER);
END ordering_pkg;
/
----------------------------------------------
CREATE OR REPLACE PACKAGE BODY ordering_pkg IS
-- forward declaration of the function ship_calc_pf
FUNCTION ship_calc_pf
	(p_qty IN NUMBER)
	RETURN NUMBER;		
	
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
-- add a calculation to reduce the subtotal
-- by the bonus percentage amount
	p_sub := p_sub - (p_sub * pv_bonus_num); 
-- the ship_calc_pf function is called to
-- determine the shipping cost	
    p_ship := ship_calc_pf(p_cnt);
    p_total := NVL(p_sub,0) + NVL(p_ship,0);
END order_total_pp;
----------------------------------------------
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
-- a one-time only procedure is included in a package body as an
-- anonymous PL/SQL block at the end of the body code.
-- A one-time only procedure is a packaged procedure that runs o
-- only once = when the package is first called.

-- reduce order subtotals by a bonus percentage
BEGIN
SELECT amount
	INTO pv_bonus_num
	from bb_promo
	where idPromo = 'B';
END ordering_pkg;
/