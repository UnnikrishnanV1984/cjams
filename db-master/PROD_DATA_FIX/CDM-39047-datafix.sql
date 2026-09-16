/* 
    Issue Description: CDM-39047
  Category/ Module  : Services: Service Log
  Root cause: User request to update the end date and start date
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

--Khilah Locklear

update tb_service_log
set start_dt  = '04/01/2024',
    update_ts = now(), 
	update_user_id = 'CDM-39047'  
	where service_log_id ='3176917';

update tb_service_purchase_authorization
set start_dt  = '04/01/2024',
	update_user_id = 'CDM-39047',
	update_ts = now()
where authorization_id = 3177194;


--Diamond Locklear
update tb_service_log
set end_dt  = '04/30/2024',
    update_ts = now(), 
	update_user_id = 'CDM-39047'  
	where service_log_id ='3176983';

update tb_service_purchase_authorization
set end_dt  = '04/30/2024',
	update_user_id = 'CDM-39047',
	update_ts = now()
where authorization_id = 3177261;