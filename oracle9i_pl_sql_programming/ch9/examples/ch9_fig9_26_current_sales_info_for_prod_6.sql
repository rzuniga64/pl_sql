-- A current sales period currently exists for product 6.
SELECT idproduct, salestart, saleend, saleprice
	FROM bb_product
	WHERE idproduct = 6;