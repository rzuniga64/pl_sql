/*
	List all active coffee products (product ID, name, and price) for 
	all coffee itemspriced above the overall average of coffee items.

	Product ID Product Name                   Price
	---------- ------------------------- ----------
			 5 Sumatra                         10.5 
			 7 Columbia                        10.8 
			 8 Brazil                          10.8 
*/

select idproduct "Product ID", productname "Product Name", price "Price"
from bb_product
where type='C' and price > (select avg(price) from bb_product where type='C');