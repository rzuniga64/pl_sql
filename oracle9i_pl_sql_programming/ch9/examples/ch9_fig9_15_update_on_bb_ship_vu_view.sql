UPDATE bb_ship_vu
	SET shipflag = 'Y', idstage = 3, dtstage = '20-FEB-2012',
		shipper = 'UPS', shippingnum = 'ZH49GC0K70MFC3M0'
	WHERE idbasket = 12;
COMMIT;