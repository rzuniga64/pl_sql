/*
	Modify the query in Step 5 to show only products that have sold 
	less than a quantity of 3.

	Product ID Quantity Sold
	---------- -------------
			 4             1 
			 7             2 
			 7             2 
			 7             2 
			 7             2 
			 7             2 
			 8             2 
			 8             2 
			 8             2 
			 8             2 
			 8             2 
			 9             1 
			 9             2 
*/

select idproduct "Product ID", b.quantity "Quantity Sold"
from bb_basketitem join bb_basket b using(idbasket)
where b.quantity < 3
order by idproduct;