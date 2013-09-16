DECLARE
   CURSOR cur_basket IS
     SELECT bi.idBasket, p.type, bi.price, bi.quantity
       FROM bb_basketitem bi INNER JOIN bb_product p
         USING (idProduct)
       WHERE bi.idBasket = 6;
   TYPE type_basket IS RECORD (
     basket bb_basketitem.idBasket%TYPE,
     type bb_product.type%TYPE,
     price bb_basketitem.price%TYPE,
     qty bb_basketitem.quantity%TYPE);
   rec_basket type_basket;
   lv_rate_num NUMBER(2,2);
   lv_tax_num NUMBER(4,2) := 0;
BEGIN
   OPEN cur_basket;
   LOOP 
     FETCH cur_basket INTO rec_basket;
      EXIT WHEN cur_basket%NOTFOUND;
      IF rec_basket.type = 'E' THEN lv_rate_num := .05;
        ELSIF rec_basket.type = 'C' THEN lv_rate_num := .03;
      END IF;
      lv_tax_num := lv_tax_num + ((rec_basket.price*rec_basket.qty)*lv_rate_num);
      IF lv_tax_num >=5 THEN
       lv_tax_num := 5;
       EXIT;
      END IF;      
   END LOOP;
   DBMS_OUTPUT.PUT_LINE(cur_basket%ROWCOUNT);
   CLOSE cur_basket;
   DBMS_OUTPUT.PUT_LINE(lv_tax_num); 
END;