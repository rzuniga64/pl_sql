/*
	Enter the query shown in figure 1-23 and check your data against the
	listing shown.  Not that ANSI standard joins in Oracle 9i are used.
	
		IDSHOPPER   IDBASKET ORDERPLACED DTORDERED DTCREATED
	---------- ---------- ----------- --------- ---------
			21          3           1 23-JAN-12 23-JAN-12 
			21          4           1 12-FEB-12 12-FEB-12 
			22          5           1 19-FEB-12 19-FEB-12 
			22          6           1 01-MAR-12 01-MAR-12 
			23          7           1 26-JAN-12 26-JAN-12 
			23          8           1 16-FEB-12 16-FEB-12 
			23          9           1 02-MAR-12 02-MAR-12 
			24         10           1 07-FEB-12 07-FEB-12 
			24         11           1 27-FEB-12 27-FEB-12 
			25         12           0 19-FEB-12 19-FEB-12 
			26         13           0           09-FEB-12 
			26         14           0           10-FEB-12 
			27         15           0           14-FEB-12 
			27         16           0           24-FEB-12 
*/

select idshopper, b.idbasket, b.orderplaced, b.dtordered, b.dtcreated
	from bb_shopper s join bb_basket b using(idshopper);
	