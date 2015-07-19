/*
ASSIGNMENT 2-5: using a Boolean Variable

	Brewbean’s needs program code to indicate whether an amount is 
	still due on an account when a payment is received.  Create a 
	PL/SQL block using a Boolean variable to indicate whether an 
	amount is still due.  Declare and initialize two variables to 
	provide input for the account balance and the payment amount 
	received.  A TRUE Boolean value should indicate an amount is still 
	owed, and a FALSE value should indicate the account is paid in full.  
	Use output statements to confirm that the Boolean variable is 
		working correctly.
*/

DECLARE
  lv_account_balance NUMBER(8,2) := 300.50;
  lv_payment_amount NUMBER(8,2) := 300.50;
    lv_amount_due BOOLEAN := FALSE;
BEGIN
  lv_account_balance := lv_account_balance - lv_payment_amount;
  IF lv_account_balance > 0 THEN lv_amount_due := TRUE;
  ELSE lv_amount_due := FALSE;
  END IF;
  
  IF lv_amount_due THEN DBMS_OUTPUT.PUT_LINE( lv_account_balance );
  ELSE  DBMS_OUTPUT.PUT_LINE('Account is paid in full');
  END IF;
END;



