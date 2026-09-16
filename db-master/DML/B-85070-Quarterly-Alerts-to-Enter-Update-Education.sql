Insert Into cjams.environmentconfig
 (env_variable_id, env_variable, env_variable_value, env_variable_module, 
 is_enabled, create_ts, create_user_id, update_ts, update_user_id)
values
 (gen_random_uuid(), 'cw-qtrly-alerts', '{"dates":[''08-15'',''11-15'',''02-15'',''06-15'']}', 'CW', 
False, now(), 'CIDM-4403', now(), 'CIDM-4403');

select *
from cjams.getenvironmentconfigvalue('cw-qtrly-alerts'::character varying, 'CW'::character varying);