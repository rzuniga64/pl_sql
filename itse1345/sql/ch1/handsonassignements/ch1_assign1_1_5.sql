/*
	Display the total quantity sold by product ID.
	
	Product ID Quantity Sold
	---------- -------------
			 2             3 
			 4             4 
			 6            13 
			 7            21 
			 8            27 
			 9            14 
*/

select idproduct, sum(b.quantity)
from bb_basketitem join bb_basket b using(idbasket)
group by idproduct
order by idproduct;