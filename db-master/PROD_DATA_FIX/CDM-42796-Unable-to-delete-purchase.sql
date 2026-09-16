/*
   Issue Description: CDM-42796
   Category/ Module  :  Removing Service Log in Purchase Authorization
   Root cause: Removing Service Log in Purchase Authorization
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_service_purchase_authorization 
 set update_ts = now() , update_user_id = 'CDM-42796', delete_sw ='Y'
 where authorization_id= 3679919 and service_log_id = 3543891;
