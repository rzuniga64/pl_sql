CREATE OR REPLACE PACKAGE budget_pkg
IS
CURSOR pcur_sales IS
	SELECT p.idProduct, p.price, p.type, SUM(bi.quantity) qty
	FROM bb_product p, bb_basketitem bi, bb_basket b
	WHERE p.idProduct = bi.idProduct
	AND b.idBasket = bi.idBasket
	AND b.orderplaced =1
	GROUP BY p.idProduct, p.price, p.type;
PROCEDURE project_sales_pp
	(p_pcte IN OUT NUMBER,
	p_pctc IN OUT NUMBER,
	p_incr OUT NUMBER);	
END;
CREATE OR REPLACE PACKAGE BODY budget_pkg
IS
PROCEDURE project_sales_pp
	(p_pcte IN OUT NUMBER,
	 p_pctc IN OUT NUMBER,
	 P_incr OUT NUMBER)
IS
	equip NUMBER := 0;
	coff NUMBER := 0;
BEGIN
	FOR rec_sales IN pcur_sales LOOP
		IF rec_sales.type = 'E' THEN 
			equip := equip + ((rec_sales.price * p_pcte) * rec_sales.qty);
		ELSIF rec_sales.type = 'C' THEN 
			coff := coff + ((rec_sales.price * p_pctc) * rec_sales.qty);
		END IF;
	END LOOP;
	p_incr := equip + coff;
END project_sales_pp;
END;
	