SELECT name, type, referenced_name, referenced_type, referenced_owner
FROM user_dependencies
WHERE name = 'ORDER_TOTAL_SP';