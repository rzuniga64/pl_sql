--FIGURE 3-17 Performing an UPDATE in a block
DECLARE
  lv_idbasket bb_basket.idbasket%TYPE :=14;
BEGIN
  UPDATE bb_basket
  SET orderplaced = 1
  WHERE idbasket = lv_idbasket;
  COMMIT;
END;