create or replace 
PROCEDURE has_purchase_order_sp
  (p_start_range IN NUMBER, p_end_range IN NUMBER)
AS
  CURSOR cur_basket1 IS
    SELECT p.cust_id, COUNT(DISTINCT(p.cust_id)) AS purchase_order
    FROM purchase_order p
    WHERE p.cust_id BETWEEN p_start_range AND p_end_range
    GROUP BY p.cust_id
    ORDER BY p.cust_id;
    
  CURSOR cur_basket2 IS     
    SELECT cust_id
      FROM customer 
      WHERE cust_id BETWEEN p_start_range AND p_end_range      
      GROUP BY cust_id
      MINUS
      SELECT cust_id
      FROM purchase_order p
      WHERE cust_id BETWEEN p_start_range AND p_end_range           
      GROUP BY cust_id;
  ex_range_order EXCEPTION;
BEGIN
  IF p_start_range > p_end_range THEN
    RAISE ex_range_order;
  END IF;  
  DBMS_OUTPUT.PUT_LINE('Customer range: ' || p_start_range || ' - ' || p_end_range);
  FOR shopper_record IN cur_basket1 LOOP
    DBMS_OUTPUT.PUT_LINE('Shopper: ' || shopper_record.cust_id || ' has a purchase order');
  END LOOP;
  FOR shopper_record IN cur_basket2 LOOP
     DBMS_OUTPUT.PUT_LINE('Shopper: ' || shopper_record.cust_id || ' does not have a purchase order');
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(' ');
EXCEPTION
  WHEN ex_range_order THEN
    DBMS_OUTPUT.PUT_LINE('Invalid customer id range');  
END;