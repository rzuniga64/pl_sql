SELECT object_name, object_type, status
FROM user_objects
WHERE object_type LIKE '%PACKAGE%';