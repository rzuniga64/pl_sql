/*
	the goal of an INSTEAD OF trigger is to replace a DML stratement issued on a view.  
	It no only simplifies code by using views, but also allows a variety of actions to 
	occur, if needed.
	
	NOTE. The INSTEAD OF trigger body needs to peform any checking included in the view 
	as a check option. The CHECK option for views isn't enforced when inserts or updates 
	views are done with INSTEAD OF triggers.
*/

create or replace 
TRIGGER bb_ship_trg
  INSTEAD OF UPDATE ON bb_ship_vu
  FOR EACH ROW
BEGIN
  UPDATE bb_basket
   SET shipflag = :NEW.shipflag
   WHERE idBasket = :NEW.idBasket;
  UPDATE bb_basketstatus
   SET dtStage = :NEW.dtStage, 
       notes = :NEW.notes, 
       shipper = :NEW.shipper, 
       shippingnum = :NEW.shippingnum
   WHERE idBasket = :NEW.idBasket AND idStage = 3;
END;