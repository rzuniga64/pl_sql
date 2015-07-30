-- Notice that BB_BASKETITEM table isn't included 
-- in the list because it's an indirect dependency
SELECT referenced_name, referenced_type, referenced_owner
FROM user_dependencies
WHERE name = 'ORDER_TOTAL_SP';