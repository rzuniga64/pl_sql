/*
	Product an unduplicated list of all product IDs for all products 
	that have been sold.  Sort the list.
	
	Product ID Product Name              Quantity of product sold
	---------- ------------------------- ------------------------
			 2 Capresso Ultima                                  3 
			 4 Coffee Grinder                                   4 
			 6 Guatamala                                       13 
			 7 Columbia                                        21 
			 8 Brazil                                          27 
			 9 Ethiopia                                        14 
			10 Espresso 										7
*/

select idproduct "Product ID", productname "Product Name", sum(b.quantity) "Quantity of product sold"
from bb_product join bb_basketitem b using(idproduct)
join bb_basket using(idbasket)
group by idproduct, productname
order by idproduct;
