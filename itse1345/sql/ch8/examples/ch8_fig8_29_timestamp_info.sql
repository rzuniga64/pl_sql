REM The timestamp model compares an objects' last modificatioin
REM date and time to determine whether invalidation has occurred
REM The data dictionary maintains a TIMESTAMP column that's 
REM included in the USER_OBJECTS view.

SELECT object_name, status, timestamp
FROM user_objects
WHERE object_name IN ('SHIP_COST_SP', 'ORDER_TOTAL_SP');