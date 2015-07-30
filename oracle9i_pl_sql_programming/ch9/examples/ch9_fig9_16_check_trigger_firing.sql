SELECT idbasket, shipflag
FROM bb_basket
WHERE idbasket=12;

SELECT Idstatus, idbasket, idstage, dtstage, shipper, shippingnum
FROM bb_basketstatus
WHERE idbasket = 12;