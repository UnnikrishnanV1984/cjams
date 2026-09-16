/*
   Issue Description: CDM-31951
   Category/ Module  :Service 
   Root cause: user requested to remove returned service log
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

UPDATE tb_service_purchase_authorization SET delete_sw = 'Y', update_ts= now()::character varying,update_user_id = 'CDM-31951'
WHERE authorization_id =1827959;

