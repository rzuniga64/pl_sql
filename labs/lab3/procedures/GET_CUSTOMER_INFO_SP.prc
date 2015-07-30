/*
	Purpose: To find the customer information for a given account number
	Input Parameters: Account ID
	Input/Output Parameters: None
	Output Parameters: Row of customer table that has the account ID
	Preconditions: Account ID is valid
	Postconditions: Customer Table unchanged. 
	                - If customer found, customer row returned
					- If customer not found, return Message “Cust_ID not valid” and customer row is returned as garbage.
*/
CREATE OR REPLACE PROCEDURE get_customer_info_sp
	(p_cust_id IN NUMBER)
AS
	lv_customer customer%ROWTYPE;
BEGIN
	SELECT * INTO lv_customer
	FROM customer
	WHERE cust_id = p_cust_id;
	
	DBMS_OUTPUT.PUT_LINE(lpad('Customer ID: ',15) 	|| lv_customer.cust_id);	
	DBMS_OUTPUT.PUT_LINE(lpad('Customer Name: ',15) || lv_customer.cust_name);
	DBMS_OUTPUT.PUT_LINE( lpad('Account ID: ',15)  	|| lv_customer.account_id); 
	DBMS_OUTPUT.PUT_LINE( lpad('Account Type: ',15) || lv_customer.account_type);
	DBMS_OUTPUT.PUT_LINE( lpad('State: ',15)  		|| lv_customer.state);
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE(' ');		
		DBMS_OUTPUT.PUT_LINE('customer ID not valid');
		DBMS_OUTPUT.PUT_LINE(' ');					
END;