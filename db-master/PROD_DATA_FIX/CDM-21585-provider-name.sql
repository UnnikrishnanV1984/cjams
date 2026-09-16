/*
-- CDM-21585 - 
   Provider #5028179 The name's was changed from Verna Dukes to Verna Norton in provider case 
   The name did not change on the provider information screen. 

-- Root cause: Data fix
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5028179
and delete_sw = 'N' ;


Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-21585'
where provider_id = 5028179
	and delete_sw  = 'N' ;