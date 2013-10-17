/*
	A simple driver to call and test the procedure GET_CUSTOMER_INFO_SP
	- Test customer found, customer row returned
   	- Test customer not found, return Message “Cust_ID not valid” and customer row is returned as garbage.
*/
DECLARE 
	lv_customer_id1 NUMBER(5) := 90001;
	lv_customer_id2 NUMBER(5) := 00001;	
BEGIN
	get_customer_info_sp(lv_customer_id1);
	get_customer_info_sp(lv_customer_id2);	
END;
/