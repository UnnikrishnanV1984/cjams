/*
   Issue Description: CDM-42179
   Category/ Module  :Services: Service Log --> purchase authorization
   Root cause:  user requested to remove purchase auth as well as the service log
   Client ID: 1251985 (Christina Lewis)
    Provider ID: 6116301 (Lukes Liquor)
    Purchase Auth ID#: 3669957
   The case worker completed another service log and it was able to be approved.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
/*
select * from tb_service_purchase_authorization where authorization_id = 3669957 and delete_sw = 'N';
*/
UPDATE tb_service_purchase_authorization SET delete_sw = 'Y', update_ts= now()::character varying, 
update_user_id = 'CDM-42179' WHERE authorization_id = 3669957 and delete_sw = 'N';
-- select * from tb_service_log tsl where service_log_id = 3534726;
update tb_service_log
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-42179'
 where service_log_id = 3534726 and delete_sw = 'N';