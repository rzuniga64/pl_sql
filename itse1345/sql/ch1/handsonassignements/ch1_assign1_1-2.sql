/* 	Enter the query shown in Figure 1-22 and check your data against the listing shown
	
	IDPRODUCT PRODUCTNAME                    PRICE     ACTIVE TYPE      STOCK
	---------- ------------------------- ---------- ---------- ---- ----------
			 1 CapressoBar Model #351         99.99          1 E             2 
			 2 Capresso Ultima               129.99          1 E             2 
			 3 Eileen 4-cup French Press       32.5          1 E             2 
			 4 Coffee Grinder                  28.5          1 E             2 
			 5 Sumatra                         10.5          1 C             1 
			 6 Guatamala                         10          1 C             1 
			 7 Columbia                        10.8          1 C             1 
			 8 Brazil                          10.8          1 C             1 
			 9 Ethiopia                          10          1 C             1 
			10 Espresso                          10          1 C             1 
*/

select idproduct, productname, price, active, type, iddepartment stock
	from bb_product;