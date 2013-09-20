/*
	ASSIGNMENT 2-13: Using nested IF Statements

	An organization has committed to matching pledge amounts based on 
	the donor type and pledge amount.  Donor types include  I = Individual, 
	B = Business organization, and G = Grant funds.  The matching percent’s 
	are to be applied as follows:

	Donor Type	Pledge Amount	Matching %
	I			$100-$249		50%
	I			$250-$499		30%
	I			%500 or more	20%
	B			$100-$499		20%
	B			$500-$999		10%
	B			$1,000 or more	5%
	G 			$100 or more	5%

	Create a PL/SQL block using nested IF statements to accomplish the task.  
	Input values for the block are the donor type code and the pledge amount. 
*/

DECLARE
  lv_donor_type CHAR(1) NOT NULL := upper('G');
  lv_pledge_amount NUMBER(5) NOT NULL :=1000;
  lv_matching_percent NUMBER (4,2) NOT NULL :=0;
BEGIN
  IF lv_donor_type = 'I' THEN
    IF lv_pledge_amount >= 100 AND lv_pledge_amount <= 249 THEN 
      lv_matching_percent := 0.50;
    ELSIF lv_pledge_amount >= 250 AND lv_pledge_amount <= 499 THEN 
      lv_matching_percent := 0.30;
    ELSIF lv_pledge_amount >= 500 THEN 
      lv_matching_percent := 0.20;
    END IF;
  ELSIF lv_donor_type = 'B' THEN 
    IF lv_pledge_amount >= 100 AND lv_pledge_amount <= 499 THEN 
      lv_matching_percent := 0.20;
    ELSIF lv_pledge_amount >= 500 AND lv_pledge_amount <= 999 THEN 
      lv_matching_percent := 0.10;
    ELSIF lv_pledge_amount >= 1000 THEN 
      lv_matching_percent := 0.05; 
    END IF;
  ELSIF lv_donor_type = 'G' THEN 
    IF lv_pledge_amount >= 100 THEN 
       lv_matching_percent := 0.05;      
    END IF;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Donor type not recognized');
  END IF;
  DBMS_OUTPUT.PUT_LINE('Donor Type: ' || lv_donor_type);
  DBMS_OUTPUT.PUT_LINE('Pledge Amount: ' || lv_pledge_amount);
  DBMS_OUTPUT.PUT_LINE('Matching %: ' || lv_matching_percent * 100 || '%');
END;






