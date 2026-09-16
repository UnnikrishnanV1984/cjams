/*
   Issue Description: CDM-30468
   Category/ Module  : Service log
   Root cause: user requested to remove purchase auth duplicates
   Pull request# for code fix: 8705
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/

UPDATE tb_service_purchase_authorization SET delete_sw = 'Y', update_ts= now()::character varying, 
update_user_id = 'CDM-30468' WHERE authorization_id in (2099319 , 2099318);