-- Verifying PL/SQL compiler parameters for a specific object

SELECT * 
FROM user_plsql_object_settings
WHERE name = 'SHIP_COST_SP';