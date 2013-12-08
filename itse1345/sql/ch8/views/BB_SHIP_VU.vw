CREATE OR REPLACE VIEW bb_ship_vu
AS
   SELECT b.idbasket,
          b.shipflag,
          bs.idstage,
          bs.dtstage,
          bs.notes,
          bs.shipper,
          bs.shippingnum
     FROM bb_basket b, bb_basketstatus bs
    WHERE b.idBasket = bs.idBasket
/