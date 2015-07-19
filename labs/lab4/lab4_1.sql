/*
	COURSE: ITSE 1345
	AUTHOR: Raul Zuniga
	ASSIGNMENT: Lab 4 part 1
	Purpose:  Write a simple driver to call the procedure. 
	Teste the following ranges of Cust_ids.
	
	- 90001 to 90008
	- 90003 to 90007
	- 90009 to 90010
	- 900005 to 90004
*/
DECLARE
  lv_start_range1 INTEGER(5) := 90001;
  lv_end_range1 INTEGER(5) := 90008;
  
  lv_start_range2 INTEGER(5) := 90003;
  lv_end_range2 INTEGER(5) := 90007;
  
  lv_start_range3 INTEGER(5) := 90009;
  lv_end_range3 INTEGER(5) := 90010;
  
  lv_start_range4 INTEGER(5) := 90005;
  lv_end_range4 INTEGER(5) := 90004;
BEGIN
  has_purchase_order_sp(lv_start_range1, lv_end_range1);
  has_purchase_order_sp(lv_start_range2, lv_end_range2);
  has_purchase_order_sp(lv_start_range3, lv_end_range3);
  has_purchase_order_sp(lv_start_range4, lv_end_range4);  
END;
/
