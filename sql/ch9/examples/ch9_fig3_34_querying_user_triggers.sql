SELECT trigger_name, trigger_body, description
FROM user_triggers
WHERE trigger_name = 'FIRE_ONE_TRG';