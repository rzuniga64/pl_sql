CREATE OR REPLACE TRIGGER bb_sales_trg
FOR UPDATE OF salestart ON bb_product
-- Compund trigger clause
COMPOUND TRIGGER
	CURSOR sdates_cur IS
		SELECT idproduct, salestart, saleend
		FROM bb_product;
	TYPE slist_typ IS TABLE OF sdates_cur%ROWTYPE
		INDEX BY BINARY_INTEGER;
	sdates_tbl slist_typ;
	int NUMBER(2) := 0;
BEFORE STATEMENT IS
		BEGIN
		FOR rec IN sdates_cur LOOP
			int := int + 1;
			sdates_tbl(int).idproduct := rec.idproduct;
			sdates_tbl(int).salestart := rec.salestart;
			sdates_tbl(int).saleend := rec.saleend;
		END LOOP;
END BEFORE STATEMENT;
BEFORE EACH ROW IS 
	lv_start_dt DATE;
	lv_end_dt DATE;
BEGIN
	FOR i IN 1..sdates_tbl.COUNT LOOP
		IF sdates_tbl(i).idproduct = :NEW.idproduct THEN
			lv_start_dt := sdates_tbl(i).salestart;
			lv_end_dt := sdates_tbl(i).saleend;
			EXIT;
		END IF;
	END LOOP;
	IF :NEW.salestart BETWEEN lv_start_dt AND lv_end_dt THEN
		RAISE_APPLICATION_ERROR(-20101, 'Product Already on Sale!');
	END IF;
	END BEFORE EACH ROW;
END;
		
			
/*
	This trigger fires when an UPDATE statement is attempted on a product's
	sale period and checks whether the new sales period is attempted on a 
	product's sales period and checks whether the new sales period overlaps
	an existing sales period. IF so, the trigger raises an error. 

CREATE OR REPLACE TRIGGER bb_sales_trg 
-- an UPDATE statement on the BB_PRODUCT table fires this trigger, and the 
-- trigger attempts to query the same table. 
BEFORE UPDATE OF salestart ON bb_product
FOR EACH ROW
DECLARE
	lv_start_dt DATE;
	lv_end_dt DATE;
BEGIN
	SELECT salestart, saleend
	INTO lv_start_dt, lv_end_dt
	FROM bb_product
	WHERE idproduct = :NEW.idproduct;
	-- the IF statement raises an error if there's an overloap of sales data
	IF :NEW.salestart BETWEEN lv_start_dt AND lv_end_dt THEN
		RAISE_APPLICATION_ERROR(-20101, 'Product Already on Sale!');
	END IF;
END;
*/