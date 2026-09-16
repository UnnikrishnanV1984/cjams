/*
   Issue Description: CJAMS-61656
   Category/ Module  : service log
   Root cause:PA link was missing as the migrated service log start date was missing.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_purchase_authorization
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-61656'
where authorization_id = '382626'
and delete_sw = 'N';

update tb_service_log
set start_dt = '2014-04-03',--null
	update_ts = now(),--18-08-2014
	update_user_id = 'CJAMS-61656', --CBA179230
	end_service_reason_cd = '1824' --null
where client_id = '1735644' 
and service_log_id = '559680'