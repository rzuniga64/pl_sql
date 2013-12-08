REM Notice that the dependent object, the ORDER_TOTAL_SP
REM procedure, is still VALID.  If this procedure didn't 
REM use the database link to call the SHIP_COST_SP procedure, 
REM it would have an INVALID status; however, its treated as a 
REM remote connection, so it's not updated immediately.

SELECT object_name, status
FROM user_objects
WHERE object_name IN ('SHIP_COST_SP', 'ORDER_TOTAL_SP');