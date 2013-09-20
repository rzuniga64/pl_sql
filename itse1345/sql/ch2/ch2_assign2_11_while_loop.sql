/*
	ASSIGNMENT 2-11: Using a WHILE Loop

	Accomplish the task in Assignment 2-9 by using a WHILE loop structure.  
	Instead of displaying the donation balance (remaining amount of pledge owed) 
	on each line of output, display the total paid to date. 
*/

DECLARE
  lv_donor_balance NUMBER(8,2):= 1000.00;
  lv_amount_paid NUMBER(8,2) := 0;
  lv_payment_due_date DATE := '01-JAN-13';
  lv_monthly_payment NUMBER(7,2) := 100.00;
  lv_number_payments NUMBER(3) := 10;
  lv_get_month VARCHAR2(10);
  lv_cnt_num NUMBER(2):= 1;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Payment Number' || '     Balance     ' || 'Payment     ' || 'Due Date' );
  WHILE lv_amount_paid < lv_donor_balance LOOP
    lv_get_month := EXTRACT(MONTH FROM lv_payment_due_date);
    IF lv_get_month IN (1,3,5,7,8,10,12) THEN 
      lv_payment_due_date := lv_payment_due_date + interval '31' day;
    ELSIF lv_get_month IN (4,6,9,11) THEN
      lv_payment_due_date := lv_payment_due_date + interval '30' day;   
    ELSE 
      lv_payment_due_date := lv_payment_due_date + interval '28' day;
    END IF;
    lv_amount_paid := lv_amount_paid + lv_monthly_payment;
    DBMS_OUTPUT.PUT_LINE(lv_cnt_num || '                  ' || lv_amount_paid|| '         '|| lv_monthly_payment || '         ' || lv_payment_due_date);
    EXIT WHEN lv_donor_balance <= 0;
  END LOOP;
END;





