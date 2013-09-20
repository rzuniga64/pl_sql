/*
  Figure 4-19 DELETE statement Oracle error
  
  To determine undefined Oracle error numbers, many developers
  use stand-alone SQL statements to test which Oracle errors
  might need to be handled in the block.
  
  This testing helps you develop a list of potential Oracle 
  errors that the SQL statement could generate. When dealing
  with undefined exceptions, the Oracle error number must 
  be included in the PRAGMA EXCEPTION_INIT statement. 
*/
DELETE from bb_basket
  WHERE idbasket= 4;