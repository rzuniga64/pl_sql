/* 
	Declaring a ROWTYPE variable 
	
	If you need to retrieve many columns you can 
	use the %ROWTYPE attribute to declare a record
	data type.  A %ROWTYPE is similar to %TYPE in that 
	it determines the needed data type by referencing
	a database table structure.  This attribute goes
	a step further and reviews the table structure for all 
	column names and data types and creates the record data
	type based on this information.  In essence, PL/SQL creates
	the record data type to match the table structure information.
	the table column names are assigned as teh record field names.
*/
DECLARE 
  rec_shopper bb_shopper%ROWTYPE;
BEGIN
  SELECT *
  INTO rec_shopper
  FROM bb_shopper
  WHERE idshopper = 25;
  DBMS_OUTPUT.PUT_LINE(rec_shopper.idshopper);
  DBMS_OUTPUT.PUT_LINE(rec_shopper.lastname);
  DBMS_OUTPUT.PUT_LINE(rec_shopper.address);
  DBMS_OUTPUT.PUT_LINE(rec_shopper.email);
END;