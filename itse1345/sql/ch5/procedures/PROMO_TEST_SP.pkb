CREATE OR REPLACE PROCEDURE promo_test_sp
  (p_mth IN CHAR,
   p_year IN CHAR)
 IS
 CURSOR cur_purch IS
   SELECT idshopper, SUM(Subtotal) sub
   FROM bb_basket
   WHERE TO_CHAR(dtCreated,'MON') = p_mth
   AND TO_CHAR(dtCreated,'YYYY') = p_year
   AND orderplaced = 1
   GROUP BY idshopper;
promo_flag CHAR(1);
BEGIN
 FOR rec_purch IN cur_purch LOOP
 	IF rec_purch.sub > 50 THEN
 		   promo_flag := 'A';
 	ELSIF rec_purch.sub > 25 THEN
 		   promo_flag := 'B';
 	END IF;
 	IF promo_flag IS NOT NULL THEN
 	  INSERT INTO bb_promolist
 	    VALUES (rec_purch.idshopper, p_mth, p_year, promo_flag, NULL);
 	END IF;
 	promo_flag := NULL;
 END LOOP;
 COMMIT;
END;