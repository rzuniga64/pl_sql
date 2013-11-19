/*
	A key-preserved table is one that's involved in a join
 	and the original table's keys are included in the keys 
   	of the resulting joing.  In this case the promary key
   	column IDSTATUS isn't included in the view, yet you're 
	attempting to insert a new row in the BB_BASKETSTATUS 
	table, which would require a value for this column.
*/
UPDATE bb_ship_vu
	SET shipflag = 'Y', idstage =3, dtstage = '20-FEB_2012',
		shipper = 'UPS', shippingnum = 'ZM497C0K70MFCM8'
	WHERE idbasket = 12;