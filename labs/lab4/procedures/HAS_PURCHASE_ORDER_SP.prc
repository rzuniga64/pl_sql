/*	
	COURSE: ITSE 1345
	AUTHOR: Raul Zuniga
	ASSIGNMENT: Lab 4 Part 1
	PURPOSE: A procedure which will determine whether a given range of customers
   	has a purchase order or not.	         	 	
	INPUT PARAMETERS: 1. The low Cust_ID value for the customer number range.
					  2. The high Cust_ID value for the customer number range.		
	INPUT/OUTPUT PARAMETERS: None
	OUTPUT PARAMETERS: None
	PRECONDITIONS: The first Cust_ID parameter value should be less than the 
	second Cust_ID parameter value.  If not, put out an appropriate error message.
	POSTCONDITIONS: Order the output by Cust_ID. Print out the Cust_ID and either 
	'has a purchase order' or the message 'does not have a purchase order'
*/
create or replace 
PROCEDURE has_purchase_order_sp (p_start_range   IN NUMBER,
                             p_end_range     IN NUMBER)
IS
	TYPE type_purchase_order IS RECORD (
    cust_id customer.cust_id%TYPE,
    order_count purchase_order.order_id%TYPE );
  
  	TYPE table_purchase_order IS TABLE OF type_purchase_order
    INDEX BY PLS_INTEGER;
  	purchase_order_count table_purchase_order;

   ex_range_order EXCEPTION;
   not_found  EXCEPTION;
BEGIN
	SELECT cust_id, COUNT(DISTINCT (order_id)) 
    	BULK COLLECT INTO purchase_order_count
      	FROM customer LEFT OUTER JOIN purchase_order p 
		USING (cust_id)
      	WHERE cust_id BETWEEN p_start_range AND p_end_range
      	GROUP BY cust_id
      	ORDER BY cust_id; 
      
  	DBMS_OUTPUT.PUT_LINE ('Customer range: ' || p_start_range || ' - ' || p_end_range);	  
	IF p_start_range > p_end_range THEN
    	RAISE ex_range_order;
  	ELSIF SQL%NOTFOUND THEN
    	RAISE not_found;
  	END IF;
  
  	FOR i IN 1..purchase_order_count.COUNT LOOP
    	IF purchase_order_count(i).order_count > 0 THEN
          	DBMS_OUTPUT.PUT_LINE ('Shopper: ' || purchase_order_count(i).cust_id || ' has a purchase order');
      	ELSE
          	DBMS_OUTPUT.PUT_LINE ('Shopper: ' || purchase_order_count(i).cust_id || ' does not have a purchase order');
      	END IF;
  	END LOOP;
    DBMS_OUTPUT.PUT_LINE(' '); 
EXCEPTION
	WHEN ex_range_order THEN
    	DBMS_OUTPUT.PUT_LINE ('Invalid customer id range: ' || p_start_range || '-' || p_end_range);
      	DBMS_OUTPUT.PUT_LINE(' '); 
  	WHEN not_found THEN 
    	DBMS_OUTPUT.PUT_LINE ('There are no customers in range: ' || p_start_range || '-' || p_end_range);
    	DBMS_OUTPUT.PUT_LINE(' ');  
END;