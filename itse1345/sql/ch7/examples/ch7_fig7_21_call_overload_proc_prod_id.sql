DECLARE
	lv_id_num	bb_product.productname%TYPE := 'Guatamala';
	lv_sale_num	bb_product.saleprice%TYPE;
	lv_price_num bb_product.price%TYPE;
BEGIN
	product_info_pkg.prod_search_pp(lv_id_num, lv_sale_num, lv_price_num);
	DBMS_OUTPUT.PUT_LINE('Sale price : ' || lv_sale_num);
	DBMS_OUTPUT.PUT_LINE('Total price: ' || lv_price_num);
END;