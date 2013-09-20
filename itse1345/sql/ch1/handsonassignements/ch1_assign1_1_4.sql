/*
	Display all orders (basketID, shopperID, and dates ordered) placed 
	in February, 2012. The date should be displayed in this format: 
	February 12, 2012.

	 Basket ID Shopper ID Date Ordered     
	---------- ---------- ------------------
			 4         21 FEBRUARY  12, 2012 
			 5         22 FEBRUARY  19, 2012 
			 8         23 FEBRUARY  16, 2012 
			10         24 FEBRUARY  07, 2012 
			11         24 FEBRUARY  27, 2012 
			12         25 FEBRUARY  19, 2012 
			13         26 FEBRUARY  09, 2012 
			14         26 FEBRUARY  10, 2012 
			15         27 FEBRUARY  14, 2012 
			16         27 FEBRUARY  24, 2012 
*/

select idbasket "Basket ID", idshopper "Shopper ID", to_char(dtcreated, 'MONTH DD, YYYY') "Date Ordered" 
from bb_shopper join bb_basket using(idshopper)
where dtcreated between '01-FEB-12' and '29-FEB-12'