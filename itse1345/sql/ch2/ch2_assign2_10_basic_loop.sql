/*
	ASSIGNMENT 2-9: Using a FOR Loop 

	Create a PL/SQL block using a FOR loop to generate a payment schedule
	for a donor’s pledge, which is to be paid monthly in equal increments.  
	Values available for the block are starting payment due date, monthly 
	payment amount, and number of total monthly payments for the pledge.  
	The list that’s generated should display a line for each monthly payment 
	showing payment number, date due, payment amount, and donation balance 
	(remaining amount of pledge owed).
*/

DECLARE
  lv_donor_balance NUMBER(8,2):= 1000.00;
  lv_payment_due_date DATE := '01-JAN-13';
  lv_monthly_payment NUMBER(7,2) := 100.00;
  lv_number_payments NUMBER(3) := 10;
  lv_get_month VARCHAR2(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Payment Number' || '     Balance     ' || 'Payment     ' || 'Due Date' );
  FOR i IN 1..10 LOOP
  	lv_get_month := EXTRACT(MONTH FROM lv_payment_due_date);
    IF lv_get_month IN (1,3,5,7,8,10,12) THEN 
      lv_payment_due_date := lv_payment_due_date + interval '31' day;
    ELSIF lv_get_month IN (4,6,9,11) THEN
      lv_payment_due_date := lv_payment_due_date + interval '30' day;   
    ELSE 
      lv_payment_due_date := lv_payment_due_date + interval '28' day;
    END IF;
    lv_donor_balance := lv_donor_balance - lv_monthly_payment;
    DBMS_OUTPUT.PUT_LINE(i || '                  ' || lv_donor_balance|| '         '|| lv_monthly_payment || '         ' || lv_payment_due_date);
  END LOOP;
END;




