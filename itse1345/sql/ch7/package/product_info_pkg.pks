CREATE OR REPLACE PACKAGE product_info_pkg IS
-- two procedures declared with the same name
PROCEDURE prod_search_pp 
	(p_id IN bb_product.idproduct%TYPE,
  	 p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE);
PROCEDURE prod_search_pp
    (p_id IN bb_product.productname%TYPE,
     p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY product_info_pkg IS
-- same coding in the two procedures, except the
-- p_id parameter is set to a different data type
-- for each procedure (NUMBER and VARCHAR2)
PROCEDURE prod_search_pp
	(p_id IN bb_product.idproduct%TYPE,
     p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE)
IS
BEGIN
	SELECT saleprice, price
   		INTO p_sale, p_price
   	 	FROM bb_product
   	 	WHERE idProduct = p_id;
END;
PROCEDURE prod_search_pp 
    (p_id IN bb_product.productname%TYPE,
     p_sale OUT bb_product.saleprice%TYPE,
     p_price OUT bb_product.price%TYPE)
     IS
BEGIN
	SELECT saleprice, price
   	 	INTO p_sale, p_price
   	 	FROM bb_product
   	 	WHERE productname = p_id;
END;    
END product_info_pkg;
/