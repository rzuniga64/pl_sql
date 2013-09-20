/*
  Figure 4-21 Coding a user-defined exception
  
  Because Oracle doesn't riase an error if an UPDATE statement
  doesn't affect any rows, you must include specific instructions
  to raise an error if no rows are updated.  To do this, you need 
  to add three items to the block, as shown in Figure 4-21.  
  1. Declare an exception
  2. Specify when to raise this error in the executable section.
  3. Code an exception handler.  The exception must be raised in 
     executable section by using the RAISE command. A declared 
     exception must be referred to  in the RAISE statement, or a 
     PL/SQL error occurs.
     
     In Figure 4-21, the cursor attribute SQL%NOTFO0UND is ued to
     test whether the UPDATE statement affected any rows and whether
     the exception is raised.
*/
DECLARE
  ex_prod_update EXCEPTION; --Declare an exception name
BEGIN
  UPDATE bb_product
    SET description = 'Mill grinder with 5 gind settings'
    WHERE idproduct = 30;
  
  IF SQL%NOTFOUND THEN --If no rows are updated, raise the exception
    RAISE ex_prod_update;
  END IF;
EXCEPTION
  WHEN ex_prod_update THEN -- Establish an exception handler
    DBMS_OUTPUT.PUT_LINE('Invalid product ID entered');
END;