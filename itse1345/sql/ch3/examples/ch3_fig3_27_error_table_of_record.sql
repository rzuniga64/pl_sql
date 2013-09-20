/* 
	FIGURE 3-27 An error using a table of records
	
	Using %ROWTYPE to create a table of records variable
	allows constructing a variable that matches a table's
	structure.  Therefore, you might think that querying
	a set of rows from the table and pushing the query results
	to the table of records should be possible.
	
	Figure 3-27 shows the result of attempting this action:
	an error with using the table of records
*/

DECLARE
  TYPE type_product IS TABLE OF bb_product%ROWTYPE
    INDEX BY PLS_INTEGER;
  tb1_prod type_product;
BEGIN
  SELECT * INTO tb1_prod
  FROM bb_product
  WHERE type = 'E';
  
  FOR i IN 1..tb1_prod. COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(tb1_prod(i).productname);
  END LOOP;
END;