--FIGURE 3-28 Using a BULK COLLECT option

DECLARE
  TYPE type_product IS TABLE OF bb_product%ROWTYPE
    INDEX BY PLS_INTEGER;
  tb1_prod type_product;
BEGIN
  SELECT * BULK COLLECT INTO tb1_prod
  FROM bb_product
  WHERE type = 'E';
  
  FOR i IN 1..tb1_prod. COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(tb1_prod(i).productname);
  END LOOP;
END;